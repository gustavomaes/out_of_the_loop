# Stitch Design Refresh Specification

## Problem Statement

O app `Out of the Loop` ja possui um MVP funcional, offline, localizado e coberto por testes, mas a interface atual ainda pode ficar mais proxima da referencia visual criada no Stitch para transmitir uma experiencia mais divertida, noturna, social e marcante.

Esta especificacao define uma reformulacao visual usando como referencia o projeto Stitch `Social Deduction Party Game`: https://stitch.withgoogle.com/projects/9176738143713775135.

## Reference Access Notes

- Nao ha MCP `stitch` habilitado neste workspace. A referencia foi acessada via browser.
- A pagina carregou o canvas do Stitch com frames mobile e uma nota lateral do proprio projeto: centralizar o titulo e os botoes da `Home Screen`, preservando a estetica neutra/vibrante do sistema de design.
- Elementos visuais observados: fundo escuro pontilhado, telas mobile estreitas, marca em caixa alta, acento verde-limao dominante, magenta para contraste, cards de alto contraste, bordas fortes, sombras/glow, bottom navigation em telas de descoberta, e telas de jogo focadas sem excesso de navegacao.
- Como a referencia visual foi observada por screenshot/browser e nao por uma API estruturada, detalhes finos de medidas, nomes de camadas e tokens devem ser validados manualmente durante a auditoria visual.

## Goals

- Reposicionar o design visual do app para ficar alinhado ao Stitch sem alterar as regras de jogo validadas no MVP.
- Aumentar a expressividade da marca com neon/glow, cards mais contrastados, tipografia forte e hierarquia mobile-first.
- Centralizar e simplificar a Home conforme a referencia do Stitch.
- Atualizar telas de descoberta, configuracao e jogo para compartilhar uma linguagem visual consistente.
- Preservar gameplay offline, sigilo de revelacao/votacao, localizacao e testes existentes.

## Out of Scope

| Item | Motivo |
| --- | --- |
| Login, cadastro de conta, profile real ou logout | O MVP continua local/offline. |
| Assinatura Pro, paywall, compra ou monetizacao | A tela aparece na referencia, mas nao faz parte do escopo atual. |
| Multiplayer online ou sincronizacao em nuvem | Fora do escopo funcional do produto. |
| Mudanca de regras, pontuacao, sorteio ou conteudo local | Esta feature e uma reformulacao visual. |
| Reescrita de arquitetura ou troca de roteamento | O app atual ja possui arquitetura suficiente para o refresh. |
| Export/import automatico do Stitch | Nao ha MCP/API Stitch disponivel no workspace. |

---

## User Stories

### P1: Home mais focada e centralizada

**User Story**: Como novo jogador, eu quero entender imediatamente o nome do jogo e as acoes principais para iniciar ou aprender as regras sem distracao.

**Why P1**: A propria referencia do Stitch destaca centralizacao do titulo e dos botoes da Home como ajuste desejado.

**Acceptance Criteria**:

1. WHEN o usuario abre a Home THEN o sistema SHALL exibir `OUT OF THE LOOP` como elemento principal centralizado.
2. WHEN a Home e exibida THEN o sistema SHALL centralizar vertical e horizontalmente as acoes principais.
3. WHEN a Home e exibida THEN o sistema SHALL priorizar `START GAME`/`Jogar` e `HOW TO PLAY`/`Como Jogar`.
4. WHEN a Home usa decoracao visual THEN o sistema SHALL manter legibilidade e touch targets minimos de `44x44`.
5. WHEN a Home tem bottom navigation THEN o sistema SHALL nao competir visualmente com as acoes centrais.

**Independent Test**: Abrir a Home em widget test e confirmar titulo, CTAs principais, navegacao e touch targets.

---

### P1: Tokens visuais inspirados no Stitch

**User Story**: Como jogador, eu quero uma interface mais vibrante e memoravel para que o jogo pareca uma experiencia social de festa.

**Why P1**: O refresh depende de uma base visual consistente antes de alterar telas individuais.

**Acceptance Criteria**:

1. WHEN o tema e carregado THEN o sistema SHALL manter fundo escuro como base.
2. WHEN tokens de destaque forem usados THEN o sistema SHALL suportar acento verde-limao observado no Stitch e magenta/rosa como contraste.
3. WHEN cards e botoes forem renderizados THEN o sistema SHALL aplicar bordas, sombras e glow de forma tokenizada.
4. WHEN cores forem alteradas THEN o sistema SHALL atualizar testes de tema para prevenir regressao.
5. WHEN `.agents/DESIGN.md` divergir do Stitch THEN o sistema SHALL registrar a decisao tomada antes da implementacao final.

**Independent Test**: Executar testes de tema e confirmar tokens principais, backgrounds e contraste basico.

---

### P1: Primitivos compartilhados com estados mais expressivos

**User Story**: Como usuario em um celular compartilhado, eu quero botoes, cards e inputs claros para tocar rapidamente durante a partida.

**Why P1**: O app possui varias telas que reutilizam `OtlButton`, `OtlCard`, `OtlTextField`, avatares e timers.

**Acceptance Criteria**:

1. WHEN `OtlButton` e renderizado THEN o sistema SHALL exibir estados primary, secondary, outline, disabled, pressed/focused alinhados ao refresh.
2. WHEN `OtlCard` e renderizado THEN o sistema SHALL suportar variantes selected, accent/glow e neutral sem cores hardcoded nas telas.
3. WHEN `OtlTextField` e renderizado THEN o sistema SHALL preservar foco visivel e contraste.
4. WHEN `PlayerAvatar` e renderizado THEN o sistema SHALL manter leitura de iniciais e cores deterministicas.
5. WHEN timers sao exibidos THEN o sistema SHALL manter feedback visual claro e coerente com o novo acento.

**Independent Test**: Executar testes de shared widgets e timers.

---

### P1: Telas de setup alinhadas a composicao Stitch

**User Story**: Como anfitriao, eu quero selecionar categoria e jogadores em telas visualmente ricas, mas ainda rapidas de operar.

**Why P1**: Setup e o caminho mais usado antes de cada partida e aparece claramente na referencia.

**Acceptance Criteria**:

1. WHEN a tela de categorias e exibida THEN o sistema SHALL usar grid/card visual de alto contraste e estado selecionado forte.
2. WHEN a tela de categorias e exibida THEN o sistema SHALL manter carregamento de conteudo local e estado disabled ate selecao.
3. WHEN a tela de jogadores e exibida THEN o sistema SHALL usar lista clara, input e CTA fixo/visivel para iniciar.
4. WHEN houver erro de jogadores THEN o sistema SHALL exibir feedback acessivel sem depender apenas de cor.
5. WHEN o setup muda visualmente THEN o sistema SHALL preservar limites de 3 a 9 jogadores e validacoes existentes.

**Independent Test**: Executar testes de setup e validar selecao de categoria, adicao de jogadores e CTA de inicio.

---

### P1: Telas de jogo focadas, secretas e cinematicas

**User Story**: Como jogador, eu quero que as telas de revelacao, pergunta, votacao e resultado parecam tensas e claras sem comprometer o sigilo do jogo.

**Why P1**: O gameplay depende de passar o celular, ocultar informacoes e manter ritmo.

**Acceptance Criteria**:

1. WHEN a tela de revelacao e exibida THEN o sistema SHALL reforcar visualmente o estado `TOP SECRET` antes de mostrar papel/palavra.
2. WHEN o jogador fora revela seu papel THEN o sistema SHALL continuar sem mostrar a palavra secreta.
3. WHEN a tela de pergunta e exibida THEN o sistema SHALL destacar jogador da vez, pergunta e timer/acao principal.
4. WHEN a votacao e exibida THEN o sistema SHALL manter voto secreto, disabled self-vote e handoff entre votantes.
5. WHEN resultados e leaderboard sao exibidos THEN o sistema SHALL destacar vencedor, palavra e pontuacao com hierarquia visual clara.

**Independent Test**: Executar testes de telas de jogo e vertical slice.

---

### P2: Navegacao e shell coerentes com a referencia

**User Story**: Como usuario, eu quero navegacao inferior em telas de descoberta e ausencia de distracao durante o jogo.

**Why P2**: A referencia mostra bottom navigation em telas nao criticas, enquanto o fluxo de jogo deve ser focado.

**Acceptance Criteria**:

1. WHEN a rota for Home, categorias, how-to ou settings THEN o sistema SHALL permitir bottom navigation tokenizada.
2. WHEN a rota for fluxo de jogo THEN o sistema SHALL suprimir bottom navigation.
3. WHEN a navegacao inferior aparece THEN o sistema SHALL usar estados selecionado/inativo claros e compatveis com o novo tema.
4. WHEN o shell aplica padding/safe area THEN o sistema SHALL preservar layout mobile-first.

**Independent Test**: Executar testes de app shell/rotas.

---

### P2: How-to e Settings atualizados sem ampliar escopo funcional

**User Story**: Como novo jogador ou anfitriao, eu quero telas informativas consistentes com o novo visual, sem encontrar recursos indisponiveis.

**Why P2**: A referencia inclui how-to, settings e pro, mas o app deve evitar prometer funcoes fora do MVP.

**Acceptance Criteria**:

1. WHEN `HowToPlayScreen` e exibida THEN o sistema SHALL usar cards/icone/hierarquia visual alinhados ao refresh.
2. WHEN `SettingsScreen` e exibida THEN o sistema SHALL atualizar idioma e timer visualmente sem adicionar login, audio, tema claro ou Pro.
3. WHEN textos localizados forem alterados THEN o sistema SHALL preservar chaves e fallback de localizacao existentes.
4. WHEN a tela Pro aparecer na referencia THEN o sistema SHALL continuar fora do produto ate nova decisao.

**Independent Test**: Executar testes de how-to, settings e l10n impactados.

---

### P2: Auditoria visual manual contra Stitch

**User Story**: Como time de produto, eu quero uma comparacao explicita entre app e Stitch para aceitar divergencias conscientemente.

**Why P2**: A referencia nao esta disponivel como API estruturada; a validacao precisa ser registrada.

**Acceptance Criteria**:

1. WHEN o refresh estiver integrado THEN o sistema SHALL registrar uma auditoria visual por tela principal.
2. WHEN houver divergencia entre app, Stitch e `.agents/DESIGN.md` THEN o sistema SHALL documentar decisao e motivo.
3. WHEN uma divergencia for funcionalmente necessaria THEN o sistema SHALL marcar como aceita.
4. WHEN a auditoria terminar THEN o sistema SHALL listar riscos residuais e follow-ups visuais.

**Independent Test**: Revisar documento de validacao e executar `flutter analyze`.

---

## Edge Cases

- WHEN o dispositivo tem largura pequena THEN o layout SHALL manter CTAs visiveis e sem overflow.
- WHEN textos localizados sao maiores que ingles/portugues THEN cards e botoes SHALL continuar responsivos.
- WHEN usuario usa fonte grande/acessibilidade THEN telas SHALL permitir scroll sem esconder a acao principal.
- WHEN timer esta desabilitado THEN a tela SHALL nao reservar espaco visual confuso para timer.
- WHEN o app esta offline THEN nenhuma tela SHALL depender de asset remoto do Stitch.
- WHEN testes antigos dependem de labels/hierarquia THEN a implementacao SHALL atualizar testes somente para comportamento visual esperado, sem relaxar regras de jogo.

---

## Requirement Traceability

| Requirement ID | Story | Priority | Status |
| --- | --- | --- | --- |
| SDR-01 | Home mais focada e centralizada | P1 | Planned |
| SDR-02 | Tokens visuais inspirados no Stitch | P1 | Planned |
| SDR-03 | Primitivos compartilhados com estados mais expressivos | P1 | Planned |
| SDR-04 | Telas de setup alinhadas a composicao Stitch | P1 | Planned |
| SDR-05 | Telas de jogo focadas, secretas e cinematicas | P1 | Planned |
| SDR-06 | Navegacao e shell coerentes com a referencia | P2 | Planned |
| SDR-07 | How-to e Settings atualizados sem ampliar escopo funcional | P2 | Planned |
| SDR-08 | Auditoria visual manual contra Stitch | P2 | Planned |

## Success Criteria

- [ ] Home centralizada e mais proxima da direcao Stitch.
- [ ] Tema, botoes, cards, inputs, avatares e timers usam tokens atualizados.
- [ ] Telas de setup e jogo preservam regras, validacoes e sigilo.
- [ ] How-to/settings mantem apenas funcionalidades existentes.
- [ ] Testes de tema, shared widgets, features e app flow passam.
- [ ] Auditoria visual documenta diferencas aceitas entre Stitch, app e `.agents/DESIGN.md`.

## Open Questions

- O verde-limao do Stitch deve substituir o rosa atual como cor primaria, ou entrar como novo acento dominante mantendo rosa como contraste?
- A fonte atual declarada como `Poppins` deve ser realmente embarcada no `pubspec.yaml`, ou o refresh deve continuar usando fallback do sistema?
- O bottom navigation deve manter os destinos atuais ou mudar os labels para espelhar exatamente o Stitch?
- A referencia visual deve ser considerada fonte de verdade acima de `.agents/DESIGN.md`, ou `.agents/DESIGN.md` deve ser atualizado primeiro para incorporar o Stitch?
