# Consolidação de UI — Especificação

## Problem Statement

O app **Out of the Loop** está funcional e alinhado ao fluxo de jogo, porém a camada de apresentação acumulou **três fontes de verdade visual** (`app_tokens.dart`, `brutalist_theme.dart`, `display_typography.dart`), **cores literais** espalhadas em telas e widgets compartilhados, **ícones sem catálogo único**, e **dezenas de widgets privados** (`_Foo`) embutidos em arquivos de tela — alguns com **700+ linhas** e múltiplos métodos `build`.

Isso dificulta manutenção, gera duplicação (ex.: `_ShadowedText`, `_TimerExpiredMessage`, widgets `*Atmosphere`) e impede revisão visual consistente.

Esta especificação define uma refatoração **estrutural e visual**, sem alterar regras de jogo, rotas, conteúdo local ou comportamento de sigilo.

## Goals

- **Uma hierarquia clara de tokens**: cores, espaçamento, raios, sombras, durações e tipografia acessíveis por imports previsíveis.
- **Eliminar `Color(0x...)` em features e shared widgets**, exceto definições canônicas em `lib/src/theme/`.
- **Catálogo de ícones** para Material icons e ícones de domínio (categorias, navegação).
- **Componentes reutilizáveis** promovidos para `lib/src/shared/widgets/` quando usados em 2+ telas ou claramente genéricos.
- **Uma tela = um `build`**: cada `*_screen.dart` compõe a tela; subcomponentes vivem em `widgets/` com **um arquivo por widget**.
- **Preservar** testes existentes, localização, gameplay offline e aparência atual (refatoração, não redesign).

## Out of Scope

| Item | Motivo |
| --- | --- |
| Mudança de regras, pontuação ou fluxo de jogo | Escopo é arquitetura de UI. |
| Novo design Stitch / Figma | Não é refresh visual; é consolidação. |
| Troca de roteamento (`go_router` / rotas) | Fora do escopo. |
| Migração para `ThemeExtension` completo | Pode ser evolução futura; MVP consolida arquivos existentes. |
| Renomear keys de l10n ou alterar copy | Apenas mover widgets; strings permanecem. |
| Widget tests novos para cada sub-widget extraído | Atualizar imports nos testes de tela existentes é suficiente. |

## Current State (Brownfield Snapshot)

| Área | Situação |
| --- | --- |
| Tokens legado | `AppColors`, `AppSpacing`, `AppTypography`, `OutOfTheLoopTheme` em `app_tokens.dart` |
| Tokens brutalist | `BrutalistColors`, `BrutalistScreenTheme` em `brutalist_theme.dart` |
| Tipografia display | `DisplayTypography` (Google Fonts) em `display_typography.dart` |
| Cores hardcoded | Presentes em `voting_screen`, `round_results_screen`, `how_to_play_screen`, `settings_screen`, `final_leaderboard_screen`, entre outros |
| Ícones | `category_icon.dart` na feature setup; `Icons.*` inline em várias telas |
| Widgets por tela | Parcial em `features/setup/widgets/`; demais telas com 3–11 classes privadas cada |
| Maiores arquivos | `voting_screen.dart` (~775 linhas), `round_results_screen.dart` (~751), `question_round_screen.dart` (~732) |

## Target Structure

```text
lib/src/theme/
  app_tokens.dart          # spacing, radius, shadows, durations (sem duplicar cores brutalist)
  app_colors.dart          # paleta unificada (inclui tokens legado + brutalist mapeados)
  app_typography.dart      # estilos estáticos (Poppins / theme)
  display_typography.dart  # factories Google Fonts (Rubik, Plus Jakarta, Space Grotesk)
  brutalist_theme.dart     # apenas helpers de Theme wrapper, sem cores duplicadas
  theme.dart               # barrel export único

lib/src/shared/icons/
  otl_icons.dart           # aliases Material + convenções de tamanho/cor default

lib/src/features/<feature>/<screen>/
  foo_screen.dart          # StatefulWidget/StatelessWidget da tela — UM build no widget da tela
  widgets/
    foo_header.dart
    foo_atmosphere.dart
    ...
```

### Regras de arquivo de tela

1. O widget público da tela (`FooScreen` ou `_FooScreenState`) expõe **exatamente um** método `build` que monta o layout (Scaffold, listeners, navegação).
2. **Proibido** definir outros `StatelessWidget` / `StatefulWidget` no mesmo arquivo da tela.
3. **Exceção**: `CustomPainter` e classes de dados/helpers sem `build` podem permanecer no arquivo do widget que as usa, ou ir para `widgets/` se > ~40 linhas.
4. Nome de arquivo: `snake_case.dart` espelhando o tipo (`voting_headline.dart` → `VotingHeadline`).
5. Widgets usados só naquela tela: `features/<feature>/widgets/` ou `features/<feature>/<subfeature>/widgets/` conforme já existir em setup.

### Regras de promoção para `shared/`

Promover quando **qualquer** critério for verdadeiro:

- Usado em 2+ features ou 2+ telas distintas.
- Nome/descrição genérica (`ShadowedText`, `TimerExpiredMessage`, `BrutalistToggle`).
- Documentado em `shared_widgets.dart` como primitivo OTL.

Manter local quando o widget codifica layout específico de uma única tela e não há segundo consumidor previsto.

---

## User Stories & Requirements

### P1: Fonte única de cores e tema

**User Story**: Como desenvolvedor, quero importar cores de um lugar só para não divergir paletas entre telas legado e brutalist.

**Requirement IDs**: UIC-01 … UIC-05

**Acceptance Criteria**:

1. WHEN qualquer arquivo em `lib/src/features/` ou `lib/src/shared/` precisar de cor THEN o sistema SHALL usar `AppColors` ou extensões documentadas em `app_colors.dart`, não literais `Color(0x…)`.
2. WHEN `BrutalistColors` for necessário THEN o sistema SHALL referenciar tokens em `app_colors.dart` (aliases ou grupo `brutalist*`), e `brutalist_theme.dart` SHALL NOT definir hex duplicados.
3. WHEN `ThemeData` for construído THEN o sistema SHALL continuar exposto via `OutOfTheLoopTheme.dark` sem regressão de `Theme.of(context)`.
4. WHEN um token brutalist não tiver equivalente legado THEN o sistema SHALL adicioná-lo em `app_colors.dart` com nome semântico (ex. `brutalistCardBackground`).
5. WHEN a consolidação terminar THEN o sistema SHALL ter zero ocorrências de `Color(0x` fora de `lib/src/theme/`.

**Independent Test**: `flutter analyze` + grep/`rg` de `Color(0x` restrito a `lib/src/theme/`.

---

### P1: Tipografia centralizada

**User Story**: Como desenvolvedor, quero saber se uso tipografia de tema ou display sem misturar estilos inline.

**Requirement IDs**: UIC-06 … UIC-09

**Acceptance Criteria**:

1. WHEN texto usar Poppins / TextTheme THEN o sistema SHALL usar `AppTypography` ou `Theme.of(context).textTheme`.
2. WHEN texto usar Rubik / Plus Jakarta / Space Grotesk THEN o sistema SHALL usar `DisplayTypography` com cor vinda de `AppColors`.
3. WHEN um estilo display se repetir com os mesmos parâmetros em 2+ arquivos THEN o sistema SHALL extrair preset nomeado em `display_typography.dart` (ex. `DisplayTypography.votingHeadline(...)`).
4. WHEN `fontSize` / `fontWeight` forem copiados inline na tela THEN o sistema SHALL substituir por preset ou `AppTypography` durante a refatoração da tela.

**Independent Test**: `flutter analyze`; revisão de amostra em telas de jogo e home.

---

### P1: Catálogo de ícones

**User Story**: Como desenvolvedor, quero um ponto de entrada para ícones de navegação e categorias.

**Requirement IDs**: UIC-10 … UIC-12

**Acceptance Criteria**:

1. WHEN ícones de bottom nav / app bar forem usados THEN o sistema SHALL referenciar `OtlIcons` (ou nome acordado em `otl_icons.dart`).
2. WHEN ícones de categoria forem usados THEN o sistema SHALL permanecer em módulo de domínio (`category_icon.dart`) exportado via barrel `shared/icons` ou `features/setup/icons/`.
3. WHEN um `IconData` for usado em 2+ telas para o mesmo significado THEN o sistema SHALL centralizar em `OtlIcons`.

**Independent Test**: `flutter analyze`; busca por `Icons.` em features reduzida a casos justificados documentados.

---

### P1: Primitivos compartilhados deduplicados

**User Story**: Como desenvolvedor, quero reutilizar sombras, timers expirados e toggles sem copiar classes privadas.

**Requirement IDs**: UIC-13 … UIC-17

**Acceptance Criteria**:

1. WHEN `_ShadowedText` existir em mais de uma tela THEN o sistema SHALL expor um único `OtlShadowedText` em `shared/widgets/`.
2. WHEN `_TimerExpiredMessage` existir em mais de uma tela THEN o sistema SHALL expor um único widget compartilhado.
3. WHEN `_BrutalistToggle` for idêntico ao padrão de settings THEN o sistema SHALL viver em `shared/widgets/` e ser importado pela tela.
4. WHEN widgets `*Atmosphere` forem estruturalmente iguais THEN o sistema SHALL unificar em `OtlPartyAtmosphere` ou documentar divergência aceita em `design.md`.
5. WHEN um primitivo for adicionado a `shared/` THEN o sistema SHALL exportá-lo em `shared_widgets.dart`.

**Independent Test**: `flutter test test/shared/widgets` (criar/atualizar se necessário) + testes de tela afetados.

---

### P1: Extração de widgets por tela

**User Story**: Como desenvolvedor, quero abrir `voting_screen.dart` e ver só composição, não dezenas de implementações internas.

**Requirement IDs**: UIC-18 … UIC-24

**Acceptance Criteria**:

1. WHEN um arquivo `*_screen.dart` for refatorado THEN o widget da tela SHALL ter apenas **um** método `build`.
2. WHEN um subcomponente tiver `build` próprio THEN o sistema SHALL movê-lo para `widgets/<nome>.dart` na mesma feature.
3. WHEN a tela importar subwidgets THEN o sistema SHALL usar imports relativos ou package imports consistentes com `features/setup/widgets/`.
4. WHEN `category_selection_screen` for refatorada THEN `_CategoryHeader` SHALL virar arquivo dedicado em `widgets/`.
5. WHEN telas de jogo listadas no inventário forem refatoradas THEN cada uma SHALL ter pasta `widgets/` com um arquivo por widget extraído.
6. WHEN telas de setup forem refatoradas THEN widgets privados restantes SHALL seguir o padrão já iniciado em `otl_category_tile.dart`.
7. WHEN a refatoração não alterar layout THEN testes widget existentes da tela SHALL passar sem mudança de comportamento.

**Inventário de telas (obrigatório)**:

| Tela | Arquivo | Widgets privados (~) | Prioridade |
| --- | --- | --- | --- |
| Home | `home_screen.dart` | 2 | P2 |
| How to play | `how_to_play_screen.dart` | 2 | P2 |
| Settings | `settings_screen.dart` | 8 | P1 |
| Category selection | `category_selection_screen.dart` | 1 | P2 |
| Match setup | `match_setup_screen.dart` | 7 | P1 |
| Player setup | `player_setup_screen.dart` | 5 | P1 |
| Secret reveal | `secret_reveal_screen.dart` | 8 | P1 |
| Question round | `question_round_screen.dart` | 10 | P1 |
| Voting | `voting_screen.dart` | 9 | P1 |
| Round results | `round_results_screen.dart` | 10 | P1 |
| Final leaderboard | `final_leaderboard_screen.dart` | 4 | P1 |

**Independent Test**: `flutter test test/features/<area>` por tela refatorada.

---

### P2: Barrel exports e convenções documentadas

**User Story**: Como contribuidor, quero saber onde importar tema e widgets.

**Requirement IDs**: UIC-25 … UIC-27

**Acceptance Criteria**:

1. WHEN código precisar de tema THEN o sistema SHOULD importar `package:.../src/theme/theme.dart` (barrel).
2. WHEN convenções forem definidas THEN o sistema SHALL documentá-las em `.specs/features/ui-consolidation/design.md` e referenciar em `.specs/codebase/CONVENTIONS.md` (criar se ausente).
3. WHEN `shared_widgets.dart` for atualizado THEN exports SHALL refletir novos primitivos sem exports circulares.

**Independent Test**: docs review + `flutter analyze`.

---

## Non-Functional Requirements

| ID | Requisito |
| --- | --- |
| UIC-NFR-01 | Nenhuma alteração em `lib/src/domain/` ou regras de serviço. |
| UIC-NFR-02 | Commits atômicos por tarefa; telas podem ser migradas incrementalmente. |
| UIC-NFR-03 | Cada tarefa executa gate mínimo definido em `tasks.md`. |
| UIC-NFR-04 | Diffs preferencialmente mecânicos (move + rename) antes de mudança visual. |
| UIC-NFR-05 | Arquivos de tela alvo: **&lt; 200 linhas** após extração (orientação, não bloqueante se composição exigir mais). |

---

## Success Metrics

- `rg 'Color\(0x' lib/src/features lib/src/shared` → **0 matches**
- Nenhum `*_screen.dart` com mais de **1** método `build` em widget de tela
- 11/11 telas do inventário com pasta `widgets/` e subcomponentes extraídos
- `flutter analyze && flutter test` verde no repositório

---

## Risks & Mitigations

| Risco | Mitigação |
| --- | --- |
| Regressão visual sutil | Refatorar por tela; comparar screenshots manuais nas telas P1 |
| Conflitos de merge em arquivos grandes | Paralelizar por **tela diferente**, não pelo mesmo arquivo |
| Testes que importam símbolos privados | Testes usam keys/finders de texto; ajustar apenas se quebrarem |
| Unificar paletas altera contraste | Mapear brutalist → aliases sem mudar valores hex na primeira fase |

---

## Traceability

| Requirement | Tasks |
| --- | --- |
| UIC-01 … UIC-05 | T02, T03 |
| UIC-06 … UIC-09 | T04 |
| UIC-10 … UIC-12 | T05 |
| UIC-13 … UIC-17 | T06, T07, T08 [P] |
| UIC-18 … UIC-24 | T10–T20 [P] |
| UIC-25 … UIC-27 | T01, T21 |
| UIC-NFR-* | Todas |

---

## Open Questions

1. **Atmosphere widgets**: são pixel-identical ou apenas similares? T08 decide unificar ou documentar variantes.
2. **Deprecar `AppColors` legado**: na fase 1 manter aliases; remoção agressiva fica fora deste escopo.
3. **`category_icon.dart`**: permanece em setup ou move para `shared/icons/` — T05 decide com base em reuso.

Respostas devem ser registradas em `design.md` durante T01/T08.
