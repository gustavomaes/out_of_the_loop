"""Audit bundled content. --check fails on structural errors or reused prompts.

Text comparison is per language across both banks; semantic suitability still
requires editorial review. --json includes every repeated prompt and its owners.
"""

import argparse
import json
import unicodedata
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ASSETS = ("seed_content.json", "us_game_night.json")


def normalize(text):
    text = unicodedata.normalize("NFKC", text).casefold()
    return " ".join(
        "".join(c for c in text if not unicodedata.category(c).startswith("P")).split()
    )


def audit():
    errors, categories = [], []
    prompts = defaultdict(list)
    ids = {kind: set() for kind in ("category", "word", "question")}

    def register(kind, value):
        if not isinstance(value, str) or not value.strip():
            errors.append(f"Invalid {kind} ID: {value!r}")
        elif value in ids[kind]:
            errors.append(f"Duplicate {kind} ID: {value}")
        else:
            ids[kind].add(value)

    def localized(value, languages, owner):
        for language in languages:
            if not isinstance(value.get(language), str) or not value[language].strip():
                errors.append(f"{owner}: missing {language}")

    for asset in ASSETS:
        data = json.loads((ROOT / "assets/content" / asset).read_text())
        languages = data["languages"]
        if data["schemaVersion"] != 1:
            errors.append(f"{asset}: unsupported schema")
        for category in data["categories"]:
            register("category", category["id"])
            localized(category["name"], languages, category["id"])
            texts = {language: [] for language in languages}
            for word in category["words"]:
                register("word", word["id"])
                localized(word["value"], languages, word["id"])
                count = len(word["questions"])
                if count != 9:
                    errors.append(f"{word['id']}: expected nine questions, found {count}")
                if not data["minQuestionsPerWord"] <= count <= data["maxQuestionsPerWord"]:
                    errors.append(f"{word['id']}: invalid question count {count}")
                for question in word["questions"]:
                    register("question", question["id"])
                    localized(question["text"], languages, question["id"])
                    for language in languages:
                        text = question["text"].get(language)
                        if not isinstance(text, str) or not text.strip():
                            continue
                        key = normalize(text)
                        texts[language].append(key)
                        prompts[(language, key)].append({
                            "asset": asset, "category": category["id"],
                            "word": word["id"], "question": question["id"],
                            "text": text,
                        })
            categories.append({
                "asset": asset, "id": category["id"],
                "words": len(category["words"]),
                "questions": sum(len(w["questions"]) for w in category["words"]),
                "unique_questions": {lang: len(set(values)) for lang, values in texts.items()},
            })
    repeated = [
        {"language": lang, "normalized_text": text, "occurrences": occurrences}
        for (lang, text), occurrences in prompts.items()
        if len({item["word"] for item in occurrences}) > 1
    ]
    return {"structural_errors": errors, "categories": categories,
            "repeated_prompts_between_words": repeated}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--json", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = audit()
    if args.json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        for category in result["categories"]:
            print(f"{category['id']}: {category['words']} words, "
                  f"{category['questions']} questions, unique per language: "
                  f"{category['unique_questions']}")
        print(f"Structural errors: {len(result['structural_errors'])}")
        for error in result["structural_errors"]:
            print(error)
        print("Repeated prompt groups between words (counted per language): "
              f"{len(result['repeated_prompts_between_words'])}")
    if args.check and (result["structural_errors"] or result["repeated_prompts_between_words"]):
        raise SystemExit(1)


if __name__ == "__main__":
    main()
