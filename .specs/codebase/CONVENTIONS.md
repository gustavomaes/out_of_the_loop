# Out of the Loop — Convenções de código

**Status**: Brownfield (parcial)  
**UI consolidation**: ver `.specs/features/ui-consolidation/design.md` (fonte detalhada)

---

## UI e tema

### Imports

```dart
// Barrel de tema (T03)
import 'package:outoftheloop/src/theme/theme.dart';

// Ícones globais (T05)
import 'package:outoftheloop/src/shared/icons/icons.dart';

// Widgets compartilhados
import 'package:out_of_the_loop/src/shared/widgets/shared_widgets.dart';

// Subwidgets locais da feature
import 'widgets/voting_headline.dart';
```

- **Não** importar `features/` a partir de `lib/src/shared/`.
- Evitar imports circulares via `shared_widgets.dart` (apenas re-exports de widgets, sem lógica de feature).

### Cores

- Usar `AppColors` / `BrutalistColors` (pós-T02: `app_colors.dart`) — **nunca** `Color(0x…)` em `features/` ou `shared/`.
- Literais hex só em `lib/src/theme/`.
- Mapeamento literal → token: tabela em `design.md` § Color Consolidation Strategy.

### Tipografia

| Caso | API |
| --- | --- |
| Shell legado, forms | `AppTypography` / `Theme.of(context).textTheme` |
| Telas brutalist / jogo | `DisplayTypography.*` + cor de `AppColors` |
| Estilo repetido 2+ vezes | Preset nomeado em `display_typography.dart` |

Proibido: `GoogleFonts.*` inline em features.

### Ícones

- Navegação e ações globais → `OtlIcons` em `lib/src/shared/icons/` (após T05).
- Categorias de jogo → `category_icon.dart` em setup até haver segundo consumidor.

### Estrutura de tela

1. **Um** `build` no widget da tela (`*_screen.dart`).
2. Subcomponentes com `build` → `features/<feature>/widgets/<nome>.dart`.
3. Nome de arquivo `snake_case.dart` espelha o tipo (`VotingHeadline` → `voting_headline.dart`).
4. Tipos em arquivos dedicados são **públicos** (sem `_` no nome da classe).
5. Promover para `shared/widgets/` se usado em 2+ telas/features ou primitivo genérico OTL; exportar em `shared_widgets.dart`.

### Exceções

- `CustomPainter` e classes de dados sem `build` podem ficar junto ao widget consumidor ou em `widgets/` se grandes.
- Orientação pós-extração: `*_screen.dart` &lt; ~200 linhas (não bloqueante).

### Baseline (2026-05-19)

- 32 literais `Color(0x` fora de `theme/` (features + shared).
- 11 telas com widgets privados embutidos; maior arquivo: `voting_screen.dart` (775 linhas).
- Inventário completo: `design.md` § Baseline Audit (T01).

---

## Geral (repositório)

- Análise e testes a partir da raiz do repo; gates em `.specs/codebase/TESTING.md`.
- Refatorações de UI: comportamento e copy inalterados; sem mudança de rotas ou domínio.
- Commits atômicos por tarefa em `.specs/features/ui-consolidation/tasks.md`.
