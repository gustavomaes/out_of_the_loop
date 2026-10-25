> Suslo / Coral Social 3.1 (25/10/2026): user selected art direction 01. Brand replaced across UI; decorative hero in `assets/suslo-cards.png`. Rule tiles and Premium dock unchanged. Historical `oddly-prototype-v*` storage keys intentionally retained. Entry folder stays `prototypes/oddly/`. 20 existing checks pass.

> V3 vigente (25/10/2026): assinatura anual/semanal, 3 grátis + 20 Premium; categorias em sheet com check/cadeado, rascunho e retorno da paywall. Ver docs/prd/monetizacao-e-paywalls.md. Preços ilustrativos US$19,99/ano e US$4,99/semana sem trial. Compras simuladas, 20 testes de lógica. Dados/decisões de v1/v2 abaixo são históricos.

> Atualização 25/10/2026 — v2 vigente: somente Classic, opções na home, sheets de nomes/impostores/timer, dock transparente Premium/Start e Share/Rate. Consulte docs/prd/PRD-reformulacao-ios-us.md. Referências abaixo a Guided/Quick ou 11 testes são históricas e foram substituídas. Protótipo: 14 testes passam; review nativo e sugestões são simulados. Troll 15% e Premium=coleção atual são propostas explícitas.

# Oddly HTML prototype
> Coral Social option 2 with compact option 1 organization

Entry: `prototypes/oddly/index.html`; usage/boundaries: `prototypes/oddly/README.md`.
Updated: 2026-10-25

- User selected warm light coral direction; explicitly requested all screens, flows and design system as locally running HTML.
- Buildless CSS/JS, bundled fonts and copied existing content. No Flutter source changes or hosted deployment.
- Three views: interactive app, clickable flow map, visual design system; gallery covers S00–S21.
- Quick 3–20, Guided 3–9, weighted imposter sampling, private hold/release, voting/scoring, timer, local snapshot and simulated purchase outcomes.
- English UI; existing content supports five languages. Native translations, SDKs, sound/music output, real restore/billing, native security and email remain explicitly outside this prototype.
- `app.js`: sample() creates gallery scenarios and replaces active demo rounds; normal game actions use act()/startRound()/go().
- `styles.css` and `tokens.json`: design handoff foundations; native accessibility requirements remain in PRD.
- `test.cjs`: 11 dependency-free Node checks; browser verified Quick reveal/result, Guided private votes/score, pending purchase and design system. No horizontal overflow at inspected 803px viewport.
- Run: python3 -m http.server 8765 --bind 127.0.0.1 --directory prototypes/oddly. Can also open index.html directly; storage semantics vary with file URLs.
