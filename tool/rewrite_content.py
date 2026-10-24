"""Build nine localized prompts from three editorial situations per word.

The context source is UTF-8, pipe-separated: ID | English | Portuguese |
Spanish | Hindi | Arabic. Each locale has three semicolon-separated situations.
Premium rows have English only. The nine angles ask about different decisions,
pitfalls, observations and experiences within those word-specific situations.
Only question text is changed; IDs, words, locales and metadata are preserved.
"""

import json
import re

from audit_content import ASSETS, ROOT, audit, normalize


FRAMES = {
    "en": [
        "When {}, what deserves the most attention?",
        "When {}, what mistake is easy to make?",
        "When {}, what would make the experience more enjoyable?",
        "When {}, what would you recommend to a beginner?",
        "When {}, what would you decide first?",
        "When {}, what might be harder than it looks?",
        "When {}, what detail might other people miss?",
        "When {}, what would you like to try differently?",
        "When {}, what would you remember afterward?",
    ],
    "pt-BR": [
        "Ao {}, o que merece mais atenção?",
        "Ao {}, que erro é fácil cometer?",
        "Ao {}, o que tornaria a experiência mais agradável?",
        "Ao {}, o que você recomendaria a um iniciante?",
        "Ao {}, o que você decidiria primeiro?",
        "Ao {}, o que pode ser mais difícil do que parece?",
        "Ao {}, que detalhe pode passar despercebido?",
        "Ao {}, o que você gostaria de experimentar de outro jeito?",
        "Ao {}, do que você se lembraria depois?",
    ],
    "es": [
        "Al {}, ¿qué merece más atención?",
        "Al {}, ¿qué error es fácil cometer?",
        "Al {}, ¿qué haría la experiencia más agradable?",
        "Al {}, ¿qué recomendarías a un principiante?",
        "Al {}, ¿qué decidirías primero?",
        "Al {}, ¿qué podría ser más difícil de lo que parece?",
        "Al {}, ¿qué detalle podría pasar desapercibido?",
        "Al {}, ¿qué te gustaría probar de otra manera?",
        "Al {}, ¿qué recordarías después?",
    ],
    "hi": [
        "{} पर किस बात पर सबसे अधिक ध्यान देना चाहिए?",
        "{} पर कौन सी गलती आसानी से हो सकती है?",
        "{} पर अनुभव को और सुखद कैसे बनाया जा सकता है?",
        "{} पर आप किसी नए व्यक्ति को क्या सलाह देंगे?",
        "{} पर आप सबसे पहले क्या तय करेंगे?",
        "{} पर क्या दिखने से अधिक कठिन हो सकता है?",
        "{} पर कौन सी बारीकी अनदेखी रह सकती है?",
        "{} पर आप क्या अलग तरीके से आज़माना चाहेंगे?",
        "{} पर आपको बाद में क्या याद रहेगा?",
    ],
    "ar": [
        "عند {}، ما الذي يستحق أكبر قدر من الاهتمام؟",
        "عند {}، ما الخطأ الذي يسهل الوقوع فيه؟",
        "عند {}، ما الذي يجعل التجربة أكثر متعة؟",
        "عند {}، بماذا تنصح شخصا مبتدئا؟",
        "عند {}، ما الذي تقرره أولا؟",
        "عند {}، ما الذي قد يكون أصعب مما يبدو؟",
        "عند {}، ما التفصيل الذي قد لا يلاحظه الآخرون؟",
        "عند {}، ما الذي تود تجربته بطريقة مختلفة؟",
        "عند {}، ما الذي ستتذكره لاحقا؟",
    ],
}
LANGUAGES = ["en", "pt-BR", "es", "hi", "ar"]


def contexts():
    result = {}
    for number, line in enumerate(
        (ROOT / "tool/data/question_contexts.txt").read_text().splitlines(), 1
    ):
        if not line.strip() or line.startswith("#"):
            continue
        word_id, *values = (field.strip() for field in line.split("|"))
        assert len(values) in (1, 5), f"Invalid locales at line {number}"
        assert word_id not in result, f"Duplicate source word {word_id}"
        result[word_id] = {}
        for language, value in zip(LANGUAGES, values):
            parts = [part.strip() for part in value.split(";")]
            assert len(parts) == 3 and all(parts), f"Invalid situations: {word_id}/{language}"
            result[word_id][language] = parts
    return result


def leaks(text, word):
    # Match the existing fixture's normalization and word boundaries, including
    # its cross-language check (a localized answer must never appear as a clue).
    clean = lambda value: re.sub(r"[^a-z0-9\u0600-\u06FF\u0900-\u097F\s]", "", value.lower())
    question, secret = clean(text), clean(word)
    if not secret:
        return False
    if " " in secret:
        return secret in question
    boundary = r"a-z0-9\u0600-\u06FF\u0900-\u097F"
    return re.search(f"(^|[^{boundary}]){re.escape(secret)}([^{boundary}]|$)", question) is not None


def main():
    source = contexts()
    seen, used, outputs = set(), set(), {}
    for asset in ASSETS:
        data = json.loads((ROOT / "assets/content" / asset).read_text())
        for category in data["categories"]:
            for word in category["words"]:
                used.add(word["id"])
                local = source[word["id"]]
                assert set(local) == set(data["languages"]), word["id"]
                assert len(word["questions"]) == 9, word["id"]
                for index, question in enumerate(word["questions"]):
                    for language in data["languages"]:
                        text = FRAMES[language][index].format(local[language][index // 3])
                        for secret in word["value"].values():
                            assert not leaks(text, secret), f"{word['id']}/{language}: leaks {secret}: {text}"
                        key = (language, normalize(text))
                        assert key not in seen, f"Repeated prompt: {word['id']}/{language}: {text}"
                        seen.add(key)
                        question["text"][language] = text
        outputs[asset] = data
    assert used == set(source), f"Unused editorial rows: {set(source) - used}"
    # Validate all output in memory before modifying either bank.
    for asset, data in outputs.items():
        (ROOT / "assets/content" / asset).write_text(
            json.dumps(data, ensure_ascii=False, indent=2) + "\n"
        )
    result = audit()
    assert not result["structural_errors"], result["structural_errors"]
    assert not result["repeated_prompts_between_words"]
    print(f"Rewrote {len(used)} words; nine prompts each; {len(seen)} localized texts.")


if __name__ == "__main__":
    main()
