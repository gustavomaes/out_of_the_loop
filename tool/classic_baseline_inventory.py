"""Print a deterministic inventory of the legacy content, without secrets.

Run from any directory: python3 tool/classic_baseline_inventory.py
Counts are localized entries, not editorial approval or unique concepts.
"""

import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def inventory():
    assets = []
    for path in sorted((ROOT / "assets/content").glob("*.json")):
        raw = path.read_bytes()
        data = json.loads(raw)
        categories = []
        for category in data["categories"]:
            words = category["words"]
            questions = [q for word in words for q in word["questions"]]
            categories.append({
                "id": category["id"],
                "words": len(words),
                "questions": len(questions),
                "localized": {
                    language: {
                        "words": sum(
                            bool(word["value"].get(language, "").strip())
                            for word in words
                        ),
                        "questions": sum(
                            bool(question["text"].get(language, "").strip())
                            for question in questions
                        ),
                    }
                    for language in data["languages"]
                },
            })
        assets.append({
            "asset": path.relative_to(ROOT).as_posix(),
            "sha256": hashlib.sha256(raw).hexdigest(),
            "schemaVersion": data["schemaVersion"],
            "contentVersion": data.get("contentVersion"),
            "languages": data["languages"],
            "categories": categories,
        })
    return {"assets": assets}


if __name__ == "__main__":
    print(json.dumps(inventory(), ensure_ascii=False, indent=2) + "\n", end="")
