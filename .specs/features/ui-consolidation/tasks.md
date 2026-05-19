# Consolidação de UI — Tasks

**Spec**: `.specs/features/ui-consolidation/spec.md`  
**Design**: `.specs/features/ui-consolidation/design.md`  
**Status**: Phase 3 complete

---

## Planning Assumptions

- Tasks marcadas `[P]` são paralelizáveis após dependências concluídas.
- **Nunca** paralelizar edições no **mesmo** `*_screen.dart`.
- Fundação de tema (T02–T05) bloqueia extração de telas que ainda usam literais.
- Deduplicação shared (T06–T08) bloqueia telas que importam cópias privadas — preferir fazer shared **antes** das telas que duplicam.
- Refatoração mecânica: comportamento e copy idênticos; sem redesign.
- Gates conforme `.specs/codebase/TESTING.md`.

---

## Execution Plan

### Phase 0: Convenções e baseline

```text
T01
```

### Phase 1: Design system (sequencial com micro-paralelo)

```text
T01 -> T02 -> T03
T03 -> T04 [P]
T03 -> T05 [P]
T04 + T05 -> T06
```

### Phase 2: Primitivos compartilhados

```text
T06 -> T07 [P]
T06 -> T08 [P]
T07 + T08 -> T09
```

### Phase 3: Extração por tela (máximo paralelismo)

Após T09, cada tarefa T10–T20 toca **um** arquivo de tela (+ sua pasta `widgets/`).

```text
T09 -> T10 [P]  settings
T09 -> T11 [P]  match_setup
T09 -> T12 [P]  player_setup
T09 -> T13 [P]  secret_reveal
T09 -> T14 [P]  question_round
T09 -> T15 [P]  voting
T09 -> T16 [P]  round_results
T09 -> T17 [P]  final_leaderboard
T09 -> T18 [P]  home
T09 -> T19 [P]  how_to_play
T09 -> T20 [P]  category_selection
```

### Phase 4: Integração e validação

```text
T10..T20 -> T21
T21 -> T22 [P]
T21 -> T23 [P]
T22 + T23 -> T24
```

### Parallelism Summary

| Batch | Tasks | Max agents |
| --- | --- | --- |
| Após T03 | T04, T05 | 2 |
| Após T06 | T07, T08 | 2 |
| Após T09 | T10–T20 | **11** (uma tela cada) |
| Após T21 | T22, T23 | 2 |

---

## Task Breakdown

### T01: Baseline audit e convenções

**What**: Registrar contagem de literais, widgets privados por tela, e convenções finais em `design.md` (Decisions Log). Opcional: criar `.specs/codebase/CONVENTIONS.md` com seção UI.  
**Where**: `.specs/features/ui-consolidation/design.md`, `.specs/codebase/CONVENTIONS.md`  
**Depends on**: None  
**Reuses**: `rg`/`wc` no repo  
**Requirements**: UIC-25, UIC-27

**Done when**:

- [x] Tabela de literais `Color(0x` por arquivo commitada no design.
- [x] Lista de widgets privados por tela confere com inventário da spec.
- [x] Convenção “1 build por screen” documentada.

**Tests**: none  
**Gate**: docs review  
**Status**: Complete (2026-05-19)

---

### T02: Unificar cores em `app_colors.dart`

**What**: Extrair/centralizar `AppColors` + `BrutalistColors` em `app_colors.dart`; slim `brutalist_theme.dart` para helpers apenas.  
**Where**: `lib/src/theme/app_colors.dart`, `lib/src/theme/brutalist_theme.dart`, `lib/src/theme/app_tokens.dart`  
**Depends on**: T01  
**Reuses**: valores hex atuais sem alteração  
**Requirements**: UIC-01, UIC-02, UIC-03

**Done when**:

- [x] `brutalist_theme.dart` não contém definições hex duplicadas.
- [x] `OutOfTheLoopTheme` compila e usa `AppColors`.
- [x] `flutter analyze` verde.

**Tests**: `flutter test test/theme` se existir; senão analyze only  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T03: Barrel `theme.dart` e migrar imports

**What**: Criar `lib/src/theme/theme.dart` exportando cores, tokens, typography, theme data. Atualizar imports em `shared/` e `app/` (não features ainda).  
**Where**: `lib/src/theme/theme.dart`, consumidores em `lib/src/shared/`, `lib/src/app/`  
**Depends on**: T02  
**Requirements**: UIC-25

**Done when**:

- [x] Barrel export único funciona.
- [x] Nenhum import quebrado em shared/app.

**Tests**: `flutter analyze`  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T04: Presets de `DisplayTypography` [P]

**What**: Identificar estilos display repetidos (headlines jogo, section labels) e adicionar presets nomeados; remover duplicação em shared widgets se houver.  
**Where**: `lib/src/theme/display_typography.dart`, `lib/src/shared/widgets/`  
**Depends on**: T03  
**Requirements**: UIC-06, UIC-07, UIC-09

**Done when**:

- [x] Presets documentados no arquivo.
- [x] Zero `GoogleFonts.*` novo em features (features migradas depois).

**Tests**: `flutter analyze`  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T05: Catálogo `OtlIcons` [P]

**What**: Criar `lib/src/shared/icons/otl_icons.dart`; migrar ícones de nav/settings/home; decidir local de `category_icon.dart`.  
**Where**: `lib/src/shared/icons/`, `lib/src/features/setup/category_icon.dart`  
**Depends on**: T03  
**Requirements**: UIC-10, UIC-11, UIC-12

**Done when**:

- [x] Bottom nav e app bars usam `OtlIcons`.
- [x] Decisão `category_icon` no Decisions Log.

**Tests**: `flutter analyze`  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T06: `OtlShadowedText` + `OtlBrutalistToggle`

**What**: Extrair widgets duplicados/privados para shared; export em `shared_widgets.dart`.  
**Where**: `lib/src/shared/widgets/otl_shadowed_text.dart`, `otl_brutalist_toggle.dart`  
**Depends on**: T04, T05  
**Requirements**: UIC-13, UIC-17

**Done when**:

- [x] Implementação única compila.
- [x] Ainda não migrar telas (T15/T16 fazem).

**Tests**: `flutter test test/shared/widgets` (adicionar testes mínimos se ausentes)  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T07: `OtlTimerExpiredMessage` [P]

**What**: Unificar mensagem de timer expirado usada em question round e voting.  
**Where**: `lib/src/shared/widgets/otl_timer_expired_message.dart`  
**Depends on**: T06  
**Requirements**: UIC-14, UIC-17

**Done when**:

- [x] Widget compartilhado exportado.
- [x] API aceita `line1`/`line2` ou l10n keys como hoje.

**Tests**: `flutter test test/shared/widgets`  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T08: Unificar `*Atmosphere` [P]

**What**: Comparar 5 implementações `*Atmosphere`; unificar em `OtlPartyAtmosphere` ou variantes documentadas.  
**Where**: `lib/src/shared/widgets/otl_party_atmosphere.dart` (+ design.md decision)  
**Depends on**: T06  
**Requirements**: UIC-15, UIC-16

**Done when**:

- [x] Decisão 1 vs N registrada.
- [x] Widget(s) shared prontos para consumo pelas telas.

**Tests**: `flutter analyze`  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T09: Remover literais em `shared/`

**What**: Substituir `Color(0x` restantes em `lib/src/shared/` por tokens; migrar shared para imports de `theme.dart`.  
**Where**: `lib/src/shared/widgets/**`  
**Depends on**: T07, T08  
**Requirements**: UIC-01, UIC-05

**Done when**:

- [x] `rg 'Color\(0x' lib/src/shared` → 0.

**Tests**: `flutter test test/shared/widgets`  
**Gate**: `flutter analyze && flutter test test/shared/widgets`  
**Status**: Complete (2026-05-19)

---

### T10: Extrair widgets — Settings [P]

**What**: Mover 8 widgets privados para `features/settings/widgets/`; screen com 1 `build`.  
**Where**: `settings_screen.dart`, `features/settings/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-19, UIC-22

**Done when**:

- [x] `settings_screen.dart` < 200 linhas (orientação).
- [x] 1 método `build` na tela.

**Tests**: `flutter test test/features` (path settings se existir) ou widget test settings  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T11: Extrair widgets — Match setup [P]

**What**: Extrair 7 widgets + usar shared atmosphere/toggle/chips onde aplicável.  
**Where**: `match_setup_screen.dart`, `features/setup/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-23

**Done when**:

- [x] Pasta widgets com 1 arquivo por componente.
- [x] Literais de cor removidos.

**Tests**: `flutter test test/features` (setup)  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T12: Extrair widgets — Player setup [P]

**What**: Extrair widgets privados restantes; alinhar com tiles existentes.  
**Where**: `player_setup_screen.dart`, `features/setup/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-23

**Done when**:

- [x] Consistente com `otl_player_tile.dart` pattern.

**Tests**: setup widget tests  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T13: Extrair widgets — Secret reveal [P]

**What**: Extrair 8 widgets para `features/game/widgets/` (ou `secret_reveal/widgets/`).  
**Where**: `secret_reveal_screen.dart`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-20

**Done when**:

- [x] Usa `OtlPartyAtmosphere` / shared onde decidido em T08.

**Tests**: `flutter test test/features/game`  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T14: Extrair widgets — Question round [P]

**What**: Extrair ~10 widgets incluindo painter; usar `OtlTimerExpiredMessage`.  
**Where**: `question_round_screen.dart`, `features/game/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-20

**Done when**:

- [x] Sem `_TimerExpiredMessage` local.

**Tests**: game screen tests  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T15: Extrair widgets — Voting [P]

**What**: Extrair 9 widgets; consumir `OtlShadowedText`, `OtlTimerExpiredMessage`, atmosphere shared.  
**Where**: `voting_screen.dart`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-20

**Done when**:

- [x] Arquivo de tela reduzido a composição.
- [x] Zero literais de cor.

**Tests**: `flutter test test/features/game/game_screens_test.dart`  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T16: Extrair widgets — Round results [P]

**What**: Extrair ~10 widgets; `OtlShadowedText` shared.  
**Where**: `round_results_screen.dart`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-20

**Done when**:

- [x] Sem duplicação de shadow text local.

**Tests**: game screen tests  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T17: Extrair widgets — Final leaderboard [P]

**What**: Extrair 4 widgets privados.  
**Where**: `final_leaderboard_screen.dart`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-20

**Done when**:

- [x] Literais removidos.

**Tests**: game screen tests  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T18: Extrair widgets — Home [P]

**What**: Extrair `_HomeHeroTitle`, `_TitleLines`.  
**Where**: `home_screen.dart`, `features/home/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18

**Done when**:

- [x] `features/home/widgets/` criada.

**Tests**: app/home tests se existirem  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T19: Extrair widgets — How to play [P]

**What**: Extrair `_RuleCard`, `_KaPowBanner`; remover literais.  
**Where**: `how_to_play_screen.dart`, `features/how_to_play/widgets/`  
**Depends on**: T09  
**Requirements**: UIC-18

**Done when**:

- [x] Tokens apenas via theme.

**Tests**: analyze + widget test se existir  
**Gate**: `flutter analyze`  
**Status**: Complete (2026-05-19)

---

### T20: Extrair widgets — Category selection [P]

**What**: Extrair `_CategoryHeader`; garantir grid usa widgets/ existentes.  
**Where**: `category_selection_screen.dart`  
**Depends on**: T09  
**Requirements**: UIC-18, UIC-21

**Done when**:

- [x] Header em arquivo dedicado.

**Tests**: setup tests  
**Gate**: quick widget gate  
**Status**: Complete (2026-05-19)

---

### T21: Migrar imports de tema nas features + barrel

**What**: Garantir todas as features importam `theme.dart`; varredura final de literais.  
**Where**: `lib/src/features/**`  
**Depends on**: T10–T20  
**Requirements**: UIC-05, UIC-25

**Done when**:

- [ ] `rg 'Color\(0x' lib/src/features lib/src/shared` → 0.
- [ ] Imports consistentes.

**Tests**: `flutter analyze`  
**Gate**: `flutter analyze`  
**Status**: Pending

---

### T22: Atualizar testes e exports [P]

**What**: Corrigir testes quebrados por moves; atualizar `shared_widgets.dart`; adicionar testes mínimos para novos shared se ausentes.  
**Where**: `test/**`, `shared_widgets.dart`  
**Depends on**: T21  
**Requirements**: UIC-NFR-03

**Done when**:

- [ ] Todos os testes de features/app passam.

**Tests**: `flutter test test/shared test/features test/app`  
**Gate**: app flow gate  
**Status**: Pending

---

### T23: Validação estrutural [P]

**What**: Script/checklist: 1 build por screen, pastas widgets/, inventário 11/11.  
**Where**: `.specs/features/ui-consolidation/validation.md` (criar)  
**Depends on**: T21  
**Requirements**: UIC-18, UIC-24, success metrics

**Done when**:

- [ ] Checklist preenchido.
- [ ] Métricas da spec atendidas.

**Tests**: none (manual + rg)  
**Gate**: docs + rg  
**Status**: Pending

---

### T24: Full gate e handoff

**What**: Executar gate completo; registrar lições em STATE se existir.  
**Where**: repo root  
**Depends on**: T22, T23  
**Requirements**: UIC-NFR-03, success metrics

**Done when**:

- [ ] `flutter analyze && flutter test` verde.
- [ ] Feature marcada complete em tasks.md.

**Tests**: full gate  
**Gate**: `flutter analyze && flutter test`  
**Status**: Pending

---

## Requirement Traceability Matrix

| Task | Requirements |
| --- | --- |
| T01 | UIC-25, UIC-27 |
| T02–T03 | UIC-01–03, UIC-25 |
| T04 | UIC-06–09 |
| T05 | UIC-10–12 |
| T06–T09 | UIC-13–17, UIC-01, UIC-05 |
| T10–T20 | UIC-18–24 |
| T21 | UIC-05, UIC-25 |
| T22–T24 | UIC-NFR-*, all success metrics |

---

## Suggested Implementation Batches (for agents)

| Sprint | Tasks | Notes |
| --- | --- | --- |
| 1 | T01 → T03 | Fundação; single agent |
| 2 | T04 + T05 | 2 agents parallel |
| 3 | T06 → T09 | Shared primitives |
| 4 | T10–T20 | **Up to 11 agents**, one screen each |
| 5 | T21 → T24 | Integration |

---

## Status Legend

- **Pending** — not started  
- **In progress** — active work  
- **Complete** — done when + gate passed
