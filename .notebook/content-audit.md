# Content audit and rewrite
> Word-specific situations, nine localized prompts per word

- Findings, current counts and verification: `docs/content-audit-2026-10-20.md`.
- Source: `tool/data/question_contexts.txt` (ID + en/pt-BR/es/hi/ar, three semicolon-separated situations per locale; premium English only).
- `tool/rewrite_content.py:main()` composes nine question angles, checks locale coverage, cross-word uniqueness and cross-language literal secret leakage before writing only question texts.
- `tool/regenerate_seed_content.dart:main()` and deprecated `tool/expand_seed_questions.dart` delegate to this source; old generic category templates were removed.
- `tool/audit_content.py --check` now passes: nine questions per word, no reused complete prompts across both banks per language. `--json` includes duplicate owners if a regression occurs.
- `test/fixtures/content_editorial_test.dart` enforces nine localized prompts, stable IDs and cross-bank text uniqueness. Automated checks do not certify semantic novelty or translation quality; editorial situations remain reviewable in the source.
- Existing 180 free words and 60 premium words/locales/IDs preserved; 2,160 questions / 8,640 localized texts rewritten. Targeted content, round generation and history tests passed (28 tests).

Updated: 2026-10-20
