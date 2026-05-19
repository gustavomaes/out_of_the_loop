# Out of the Loop MVP Specification

## Problem Statement

Grupos presenciais precisam de uma forma simples de jogar uma partida social em um unico aparelho, sem login, internet ou preparacao manual. O app deve conduzir a rodada, manter segredo sobre quem esta fora do circulo, apresentar perguntas, coletar votos secretos e calcular a pontuacao automaticamente.

Esta especificacao converte o PRD em requisitos rastreaveis para o MVP do app Flutter. O prototipo visual informado e o Figma `Out-of-the-loop`, arquivo `Q4zPj8JvM2JJh7EU8IfDg0`, node `0:1`: https://www.figma.com/design/Q4zPj8JvM2JJh7EU8IfDg0/Out-of-the-loop?node-id=0-1

O design system de implementacao deve seguir `.agents/DESIGN.md`. Quando houver diferenca entre o codigo de referencia do Figma e o design system documentado, `.agents/DESIGN.md` e a fonte de verdade para tokens, componentes e regras gerais; o Figma serve como referencia de fluxo, composicao e hierarquia visual.

## Goals

- [ ] Permitir uma partida local completa de 5 rodadas configuraveis para 3 a 9 jogadores.
- [ ] Conduzir uma rodada completa com revelacao de papeis, perguntas publicas, votacao, resultado, adivinhacao condicional e pontuacao.
- [ ] Garantir que o jogador fora nunca veja a palavra secreta antes da fase de adivinhacao.
- [ ] Operar totalmente offline, usando conteudo local para categorias, palavras e perguntas.
- [ ] Suportar localizacao de interface e conteudo em `pt-BR`, `en`, `es` e `hi`.
- [ ] Implementar a experiencia visual mobile-first seguindo `.agents/DESIGN.md` e validando os fluxos principais contra o Figma.

## Prototype Reference

O Figma `Out-of-the-loop` contem os seguintes frames validados por metadata:

| Frame | Node | Uso esperado no MVP |
| --- | --- | --- |
| Home | `2:2` | Tela inicial com titulo, `START GAME`, `HOW TO PLAY` e navegacao inferior. |
| Category Selection | `2:50` | Selecao de categoria em grid/bento, header e navegacao inferior. |
| Cadastro de Jogadores | `2:131` | Cadastro/lista de jogadores e acao fixa para iniciar. |
| The Secret Reveal | `2:196` | Revelacao individual de papel/palavra. |
| Question Round | `2:225` | Pergunta da rodada, jogador da vez e timer. |
| The Vote | `2:264` | Votacao contextual com lista de jogadores e confirmacao. |
| Game Results | `2:338` | Resultado da rodada, revelacao e pontuacao. |
| Como Jogar | `2:441` | Explicacao das regras. |
| Configuracoes | `2:545` | Idioma e preferencias locais. |
| Assinatura Pro | `2:625` | Fora do escopo do MVP, salvo decisao explicita. |

Direcoes visuais confirmadas no Figma e no design system:

- Interface mobile com largura base de `390px`, fundo escuro e estetica noturna/social.
- Marca em caixa alta para `OUT OF THE LOOP`.
- Uso de elementos decorativos, sombra marcada/neon/glow e botoes grandes arredondados.
- Navegacao inferior visivel em telas de descoberta/configuracao; fluxos de jogo podem suprimir a navegacao para foco.
- Telas de jogo devem priorizar leitura rapida, acao primaria clara e sigilo durante revelacao/votacao.

## Out of Scope

| Feature | Reason |
| --- | --- |
| Login, contas ou perfis persistentes | O jogo e presencial e roda em um unico aparelho compartilhado. |
| Multiplayer online ou remoto | O PRD define uso local/offline. |
| Registro digitado das respostas dos jogadores | As respostas sao dadas em voz alta. |
| Bloqueio tecnico entre visualizacoes de papel | A mecanica depende da confianca entre jogadores. |
| Editor de categorias/palavras pelo usuario | O MVP usa banco local predefinido e expansivel. |
| Sincronizacao em nuvem | Incompativel com o requisito totalmente offline. |
| Perfil de usuario | O Figma mostra `PROFILE`, mas o PRD nao define conta, login ou dados de perfil para o MVP. |
| Assinatura Pro / monetizacao | O Figma inclui tela Pro, mas o PRD prioriza o fluxo offline jogavel. |

---

## User Stories

### P1: Configurar e iniciar partida MVP

**User Story**: Como anfitriao, eu quero configurar categoria, numero de rodadas e jogadores para iniciar uma partida presencial rapidamente.

**Why P1**: Sem configuracao de partida nao ha fluxo jogavel.

**Acceptance Criteria**:

1. WHEN o usuario abre o app THEN o sistema SHALL exibir a tela inicial com acoes `Jogar` e `Como Jogar`.
2. WHEN o usuario toca em `Jogar` THEN o sistema SHALL exibir a tela de configuracao da partida.
3. WHEN a tela de configuracao e exibida THEN o sistema SHALL permitir selecionar uma categoria entre 20 categorias disponiveis.
4. WHEN a tela de configuracao e exibida THEN o sistema SHALL permitir definir o numero de rodadas com valor padrao 5.
5. WHEN o usuario cadastra jogadores THEN o sistema SHALL aceitar apenas nomes, sem login ou conta.
6. WHEN houver menos de 3 jogadores cadastrados THEN o sistema SHALL manter `Iniciar Partida` desabilitado.
7. WHEN houver entre 3 e 9 jogadores cadastrados THEN o sistema SHALL permitir iniciar a partida.
8. WHEN o usuario tentar exceder 9 jogadores THEN o sistema SHALL impedir a inclusao e informar o limite.

**Independent Test**: Configurar uma partida com 2 jogadores e confirmar botao desabilitado; adicionar o terceiro jogador e iniciar a partida.

---

### P1: Revelar papeis com segredo preservado

**User Story**: Como jogador, eu quero visualizar meu papel individualmente para participar da rodada sem revelar informacoes aos outros.

**Why P1**: A regra central do jogo depende de separar quem sabe a palavra secreta de quem esta fora.

**Acceptance Criteria**:

1. WHEN uma rodada inicia THEN o sistema SHALL escolher aleatoriamente 1 jogador como fora.
2. WHEN uma rodada inicia THEN o sistema SHALL escolher uma palavra secreta da categoria selecionada que ainda nao foi usada na partida.
3. WHEN for a vez de um jogador visualizar seu papel THEN o sistema SHALL exibir o nome do jogador e a acao `Visualizar minha palavra`.
4. WHEN um jogador dentro toca em `Visualizar minha palavra` THEN o sistema SHALL exibir a palavra secreta da rodada.
5. WHEN o jogador fora toca em `Visualizar minha palavra` THEN o sistema SHALL exibir apenas a mensagem `Voce esta FORA do circulo — aja naturalmente`.
6. WHEN o jogador confirma a visualizacao THEN o sistema SHALL avancar para o proximo jogador ate todos terem visto seus papeis.
7. WHEN todos os jogadores tiverem visualizado seus papeis THEN o sistema SHALL avancar para a fase de perguntas.

**Independent Test**: Iniciar uma rodada com 4 jogadores, passar por todas as visualizacoes e verificar que exatamente 1 jogador recebe mensagem de fora e os demais recebem a palavra.

---

### P1: Conduzir perguntas publicas

**User Story**: Como grupo, eu quero receber perguntas com indicacao de quem deve responder para que a conversa gere pistas sobre quem esta fora.

**Why P1**: As perguntas sao o mecanismo principal de deducao antes da votacao.

**Acceptance Criteria**:

1. WHEN a fase de perguntas inicia THEN o sistema SHALL selecionar uma quantidade de perguntas igual ao numero de jogadores, com maximo de 9.
2. WHEN a fase de perguntas inicia THEN o sistema SHALL usar perguntas associadas a palavra secreta da rodada.
3. WHEN uma pergunta e exibida THEN o sistema SHALL mostrar o texto da pergunta e o nome do jogador que deve responder em voz alta.
4. WHEN o usuario avanca uma pergunta THEN o sistema SHALL exibir a proxima pergunta e o proximo jogador definido para responder.
5. WHEN todas as perguntas forem exibidas THEN o sistema SHALL avancar para a fase de votacao.
6. WHEN o timer estiver habilitado THEN o sistema SHALL usar 30 segundos como duracao padrao por pergunta.

**Independent Test**: Em uma rodada com 5 jogadores, verificar que 5 perguntas aparecem, cada uma com um jogador indicado, e que a fase seguinte e votacao.

---

### P1: Coletar votos secretos

**User Story**: Como jogador, eu quero votar secretamente em quem acredito estar fora para que o grupo possa revelar o suspeito sem vieses publicos.

**Why P1**: A votacao determina se o fora foi descoberto e aciona as regras de pontuacao.

**Acceptance Criteria**:

1. WHEN a fase de votacao inicia THEN o sistema SHALL conduzir uma vez por jogador cadastrado.
2. WHEN for a vez de um jogador votar THEN o sistema SHALL exibir o nome do votante antes da lista de candidatos.
3. WHEN o votante escolhe um jogador THEN o sistema SHALL registrar exatamente um voto para aquele votante.
4. WHEN um voto e registrado THEN o sistema SHALL ocultar a escolha antes de passar ao proximo votante.
5. WHEN todos os jogadores votarem THEN o sistema SHALL calcular a contagem total de votos por jogador.
6. WHEN a contagem for concluida THEN o sistema SHALL revelar o total de votos por jogador.

**Independent Test**: Executar votacao com 4 jogadores e confirmar que cada jogador vota uma vez, os votos ficam ocultos durante a coleta e aparecem agregados ao final.

---

### P1: Calcular resultado e pontuacao da rodada

**User Story**: Como grupo, eu quero que o app revele o fora e calcule os pontos para evitar discussao manual de regras.

**Why P1**: Pontuacao automatica e progressao de rodada sao necessarias para uma partida completa.

**Acceptance Criteria**:

1. WHEN a votacao termina THEN o sistema SHALL revelar quem era o jogador fora.
2. WHEN a votacao termina THEN o sistema SHALL determinar maioria como mais da metade dos jogadores.
3. WHEN um jogador dentro votou corretamente no fora THEN o sistema SHALL adicionar 25 pontos a esse jogador.
4. WHEN a maioria dos jogadores votou no fora THEN o sistema SHALL adicionar 100 pontos para todos os jogadores dentro.
5. WHEN a maioria nao votou no fora THEN o sistema SHALL adicionar 50 pontos ao jogador fora.
6. WHEN a maioria votou no fora THEN o sistema SHALL pular a fase de adivinhacao pelo fora.
7. WHEN a maioria nao votou no fora THEN o sistema SHALL abrir a fase de adivinhacao pelo fora.
8. WHEN a rodada termina THEN o sistema SHALL atualizar a pontuacao total acumulada por jogador.

**Independent Test**: Simular uma rodada com 5 jogadores e 3 votos no fora; verificar maioria, pontos dos jogadores dentro e ausencia da fase de adivinhacao.

---

### P1: Adivinhacao condicional pelo fora

**User Story**: Como jogador fora, eu quero tentar adivinhar a palavra quando nao fui descoberto para ganhar pontos adicionais.

**Why P1**: Esta fase e uma regra nao-negociavel do PRD quando o fora escapa da maioria.

**Acceptance Criteria**:

1. WHEN o fora nao for descoberto pela maioria THEN o sistema SHALL exibir a fase de adivinhacao.
2. WHEN a fase de adivinhacao e exibida THEN o sistema SHALL instruir o fora a falar a palavra em voz alta.
3. WHEN a fase de adivinhacao e exibida THEN o sistema SHALL oferecer as acoes `Acertou` e `Errou`.
4. WHEN o grupo marca `Acertou` THEN o sistema SHALL adicionar 125 pontos ao jogador fora.
5. WHEN o grupo marca `Errou` THEN o sistema SHALL nao adicionar os 125 pontos de adivinhacao.
6. WHEN a adivinhacao e resolvida THEN o sistema SHALL concluir a rodada e atualizar o placar total.

**Independent Test**: Simular uma rodada sem maioria contra o fora, marcar `Acertou` e verificar que o fora recebe 50 + 125 pontos.

---

### P1: Progredir rodadas e finalizar partida

**User Story**: Como grupo, eu quero jogar varias rodadas com placar acumulado para concluir uma partida completa e ver o ranking final.

**Why P1**: O PRD define partida completa como multiplas rodadas, padrao de 5.

**Acceptance Criteria**:

1. WHEN uma rodada termina e ainda houver rodadas restantes THEN o sistema SHALL iniciar a proxima rodada mantendo os jogadores e placar acumulado.
2. WHEN uma nova rodada inicia THEN o sistema SHALL sortear um jogador fora para a rodada.
3. WHEN uma nova rodada inicia THEN o sistema SHALL impedir repeticao de palavra secreta ja usada na mesma partida.
4. WHEN a ultima rodada termina THEN o sistema SHALL exibir o ranking final por pontuacao total.
5. WHEN o ranking final e exibido THEN o sistema SHALL oferecer as acoes `Nova partida` e `Voltar ao inicio`.
6. WHEN o usuario escolhe `Nova partida` THEN o sistema SHALL permitir configurar uma nova partida.
7. WHEN o usuario escolhe `Voltar ao inicio` THEN o sistema SHALL retornar para a tela inicial.

**Independent Test**: Configurar partida de 2 rodadas, concluir ambas e verificar ranking final e acoes de saida.

---

### P1: Conteudo local de categorias, palavras e perguntas

**User Story**: Como grupo, eu quero jogar offline com categorias, palavras e perguntas prontas para nao depender de internet.

**Why P1**: O conteudo e requisito tecnico central e sustenta as fases de revelacao e perguntas.

**Acceptance Criteria**:

1. WHEN o app e instalado THEN o sistema SHALL disponibilizar 20 categorias localmente.
2. WHEN uma categoria existe THEN o sistema SHALL conter 30 palavras secretas para essa categoria.
3. WHEN uma palavra secreta existe THEN o sistema SHALL conter entre 3 e 9 perguntas associadas.
4. WHEN uma rodada e criada THEN o sistema SHALL selecionar perguntas suficientes para pelo menos 1 pergunta por jogador.
5. WHEN o app esta sem internet THEN o sistema SHALL permitir configurar e jogar uma partida completa.
6. WHEN o conteudo local for lido THEN o sistema SHALL usar estrutura compativel com `word`, `category` e `questions`.

**Independent Test**: Executar o app sem conexao, iniciar partida e concluir uma rodada usando categorias, palavra e perguntas locais.

---

### P2: Como jogar e regras acessiveis

**User Story**: Como novo jogador, eu quero ler as regras rapidamente para entender o fluxo antes da partida.

**Why P2**: Ajuda onboarding, mas nao bloqueia o fluxo jogavel principal.

**Acceptance Criteria**:

1. WHEN o usuario toca em `Como Jogar` THEN o sistema SHALL explicar objetivo, papeis, perguntas, votacao, maioria, adivinhacao e pontuacao.
2. WHEN o usuario esta na tela de regras THEN o sistema SHALL permitir voltar para a tela inicial.
3. WHEN as regras citam maioria THEN o sistema SHALL definir maioria como mais da metade dos jogadores.

**Independent Test**: Abrir `Como Jogar`, conferir os topicos principais e voltar para o inicio.

---

### P1: Aplicar sistema visual e prototipo mobile

**User Story**: Como jogador, eu quero uma interface consistente, vibrante e legivel para que o jogo pareca divertido, confiavel e facil de conduzir em grupo.

**Why P1**: A experiencia e mobile-first e compartilhada presencialmente; clareza visual, botoes grandes e sigilo das telas fazem parte do gameplay.

**Acceptance Criteria**:

1. WHEN qualquer tela principal e implementada THEN o sistema SHALL usar os tokens e regras de `.agents/DESIGN.md` para cores, tipografia, espacamento, bordas, sombras, foco e touch targets.
2. WHEN uma tela usa fundo principal THEN o sistema SHALL evitar fundo branco puro e usar a estetica escura/noturna definida no design system.
3. WHEN uma acao primaria e exibida THEN o sistema SHALL usar botao grande, arredondado, com estado disabled/pressed/focus consistente com o design system.
4. WHEN uma tela de configuracao/descoberta e exibida THEN o sistema SHALL seguir a composicao mobile validada no Figma, incluindo header, cards e navegacao inferior quando aplicavel.
5. WHEN uma tela de fluxo de jogo e exibida THEN o sistema SHALL priorizar foco na tarefa atual e pode suprimir navegacao inferior conforme o prototipo.
6. WHEN uma tela temporizada e exibida THEN o sistema SHALL dar feedback visual claro usando timer circular ou barra de progresso conforme o contexto.
7. WHEN uma tela permite interacao por toque THEN o sistema SHALL respeitar touch target minimo de `44x44px` e espacamento minimo de `8px`.
8. WHEN houver diferenca entre o Figma e `.agents/DESIGN.md` THEN o sistema SHALL registrar a divergencia e aplicar `.agents/DESIGN.md` como fonte de verdade ate nova decisao.

**Independent Test**: Comparar Home, categoria, cadastro de jogadores, revelacao, pergunta, votacao e resultado contra o Figma e verificar que tokens, hierarquia e interacoes seguem `.agents/DESIGN.md`.

---

### P2: Timer configuravel para perguntas e votacao

**User Story**: Como anfitriao, eu quero controlar o tempo das respostas e votos para manter o ritmo da partida.

**Why P2**: O PRD define timer global configuravel, mas a partida pode funcionar sem bloqueio rigido.

**Acceptance Criteria**:

1. WHEN o timer esta habilitado THEN o sistema SHALL aplicar 30 segundos como padrao por pergunta e votacao.
2. WHEN o timer expira em uma pergunta THEN o sistema SHALL permitir avancar para a proxima pergunta.
3. WHEN o timer expira na votacao THEN o sistema SHALL manter a interface consistente sem registrar voto automaticamente.
4. WHEN o usuario altera a configuracao do timer THEN o sistema SHALL aplicar o novo valor nas proximas fases temporizadas.

**Independent Test**: Habilitar timer curto em ambiente de teste e confirmar expiracao durante pergunta e votacao.

---

### P2: Localizacao de interface e conteudo

**User Story**: Como jogador, eu quero usar o app no meu idioma para entender regras, perguntas e acoes sem traducao externa.

**Why P2**: O PRD exige suporte multil idioma completo, mas o MVP jogavel pode ser validado inicialmente em um idioma antes da carga completa de conteudo.

**Acceptance Criteria**:

1. WHEN o app inicia THEN o sistema SHALL detectar o idioma do sistema operacional.
2. WHEN o idioma detectado nao for suportado THEN o sistema SHALL usar `pt-BR` como fallback.
3. WHEN o usuario altera idioma nas configuracoes THEN o sistema SHALL aplicar a alteracao imediatamente, sem reiniciar o app.
4. WHEN um idioma esta ativo THEN o sistema SHALL localizar textos de interface, mensagens, botoes, categorias, palavras e perguntas.
5. WHEN o app suporta conteudo completo THEN o sistema SHALL disponibilizar 600 palavras por idioma para `pt-BR`, `en`, `es` e `hi`.

**Independent Test**: Alterar idioma para `en`, confirmar textos de interface e conteudo carregados nesse idioma, depois voltar para `pt-BR` sem reiniciar.

---

### P3: Persistencia de configuracoes locais

**User Story**: Como anfitriao frequente, eu quero que preferencias simples sejam lembradas para reduzir configuracao repetitiva.

**Why P3**: Melhora conveniencia, mas nao e requisito essencial para jogar.

**Acceptance Criteria**:

1. WHEN o usuario altera idioma THEN o sistema SHALL persistir a preferencia localmente.
2. WHEN o usuario altera configuracao do timer THEN o sistema SHALL persistir a preferencia localmente.
3. WHEN o app reinicia THEN o sistema SHALL restaurar preferencias locais salvas.

**Independent Test**: Alterar idioma/timer, reiniciar o app e verificar que as preferencias permanecem.

---

## Edge Cases

- WHEN houver exatamente 3 jogadores THEN o sistema SHALL permitir partida e calcular maioria como 2.
- WHEN houver exatamente 9 jogadores THEN o sistema SHALL permitir partida e exibir no maximo 9 perguntas.
- WHEN houver 5 jogadores e 2 votos no fora THEN o sistema SHALL considerar que nao houve maioria.
- WHEN houver empate entre suspeitos sem maioria no fora THEN o sistema SHALL considerar que o fora nao foi descoberto.
- WHEN todos os jogadores dentro votarem corretamente e o fora votar em outro jogador THEN o sistema SHALL conceder +25 apenas para os dentro que votaram no fora e +100 para todos os dentro se houve maioria.
- WHEN a categoria ficar sem palavras nao usadas para as rodadas restantes THEN o sistema SHALL bloquear o inicio da partida ou solicitar ajuste de categoria/rodadas antes de iniciar.
- WHEN uma palavra tiver menos perguntas que jogadores THEN o sistema SHALL nao selecionar essa palavra para uma rodada com esse numero de jogadores.
- WHEN um nome de jogador estiver vazio ou duplicado THEN o sistema SHALL impedir cadastro ou solicitar correcao antes de iniciar.
- WHEN o app estiver offline THEN o sistema SHALL manter todas as funcionalidades de jogo disponiveis.
- WHEN o Figma e `.agents/DESIGN.md` divergirem em tokens, fonte ou cor THEN o sistema SHALL registrar a divergencia na fase de design e aplicar `.agents/DESIGN.md` como fonte de verdade ate decisao contraria.

---

## Requirement Traceability

| Requirement ID | Story | Phase | Status |
| --- | --- | --- | --- |
| OTL-01 | P1: Configurar e iniciar partida MVP | Phase 4 | Verified MVP vertical slice |
| OTL-02 | P1: Revelar papeis com segredo preservado | Phase 4 | Verified MVP vertical slice |
| OTL-03 | P1: Conduzir perguntas publicas | Phase 4 | Verified MVP vertical slice |
| OTL-04 | P1: Coletar votos secretos | Phase 4 | Verified MVP vertical slice |
| OTL-05 | P1: Calcular resultado e pontuacao da rodada | Phase 4 | Verified MVP vertical slice |
| OTL-06 | P1: Adivinhacao condicional pelo fora | Phase 4 | Verified by screen/service tests |
| OTL-07 | P1: Progredir rodadas e finalizar partida | Phase 4 | Verified final leaderboard routing |
| OTL-08 | P1: Conteudo local de categorias, palavras e perguntas | Phase 4 | Partial: offline seed verified; full 20x30 content deferred to T33 |
| OTL-09 | P2: Como jogar e regras acessiveis | Phase 4 | Verified screen and routing |
| OTL-10 | P1: Aplicar sistema visual e prototipo mobile | Phase 4 | Verified by design audit |
| OTL-11 | P2: Timer configuravel para perguntas e votacao | Phase 5 | Partial: UI/service present; integrated configurable behavior deferred to T35 |
| OTL-12 | P2: Localizacao de interface e conteudo | Phase 5 | Partial: scaffold/locales present; full content expansion deferred to T33 |
| OTL-13 | P3: Persistencia de configuracoes locais | Phase 5 | Deferred to T34 |

**Coverage:** 13 total, 10 mapped to MVP validation, 3 deferred or partial for Phase 5.

---

## Success Criteria

- [ ] Um grupo com 3 a 9 jogadores consegue completar uma rodada inteira sem internet.
- [ ] O app impede inicio de partida com menos de 3 jogadores e mais de 9 jogadores.
- [ ] O jogador fora nunca ve a palavra secreta antes da adivinhacao.
- [ ] A pontuacao segue as regras fixas: +25 voto correto, +100 maioria para dentro, +50 fora nao descoberto, +125 adivinhacao correta.
- [ ] A regra de maioria sempre usa mais da metade dos jogadores.
- [ ] Palavras secretas nao se repetem dentro da mesma partida.
- [ ] O ranking final aparece ao terminar a ultima rodada configurada.
- [ ] Conteudo e interface funcionam offline.
- [ ] Textos e conteudo localizados estao disponiveis para os idiomas definidos antes do lancamento completo.
- [ ] A interface final segue `.agents/DESIGN.md` e e validada contra os frames principais do Figma `Out-of-the-loop`.

## Open Questions

- O MVP deve exigir o banco completo de 20 categorias x 30 palavras x 4 idiomas antes do primeiro build jogavel, ou pode iniciar com um subconjunto seed para validar fluxo?
- O sorteio do jogador fora pode repetir o mesmo jogador em rodadas consecutivas, ou deve haver uma regra de balanceamento?
- O timer deve ser apenas visual/ritmo de jogo ou deve bloquear automaticamente avancos apos expirar?
- A tela `PROFILE` da navegacao inferior deve abrir uma tela placeholder/configuracoes no MVP ou ficar desabilitada?
- A divergencia entre fontes/cores do Figma inicial e `.agents/DESIGN.md` deve ser resolvida atualizando o design system ou ajustando o Figma?
