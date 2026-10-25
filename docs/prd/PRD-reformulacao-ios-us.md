# PRD — Oddly / Classic — reformulação iOS US

Versão **3.0**, 25/10/2026. Responsável: desenvolvedor solo com apoio de IA. Nome Oddly provisório. Este documento define o produto futuro; o Flutter existente ainda não foi alterado. Protótipo navegável: [HTML local](../../prototypes/oddly/index.html).

## 1. Status e precedência

Esta versão 3 substitui v1/v2; assinatura anual/semanal substitui compra avulsa e combo. Categorias agora são selecionadas em bottom sheet. Requisitos detalhados em [Monetização e paywalls](monetizacao-e-paywalls.md).

Mantido da v2: **Guided foi removido; Classic é o único modo**. As decisões novas do proprietário prevalecem sobre a entrevista anterior. A v1 foi preservada apenas em `historico/` para rastreabilidade; não reutilizar suas regras de perguntas, votação digital ou pontuação.

- **Decisão:** requisito explícito do proprietário.
- **Proposta:** detalhe operacional recomendado, ainda ajustável; não confundir com decisão já validada.
- **Pendência:** informação ausente a resolver antes da etapa correspondente.
- **P0:** lançamento; **P1/P2:** evolução futura.

Documentos complementares: [plano de desenvolvimento](plano-de-desenvolvimento.md), [ASO e lançamento](aso-e-lancamento.md). Código atual continua sendo a fonte sobre implementação existente; o mockup demonstra a nova direção.

## 2. Objetivo e público

Um jogo presencial de impostor e palavras fácil de encontrar na App Store americana e rápido de começar. Público principal: jovens adultos em festas e encontros de amigos nos EUA; conteúdo básico adequado também a famílias e adolescentes. Um celular, sem cadastro, partidas gratuitas ilimitadas.

Proposta de valor: **“One secret word. Someone is bluffing. Start playing in seconds.”**

Prioridades: início rápido → segredo protegido → conteúdo reconhecível → repetição fácil → página da loja clara → compra opcional de temas. Poucos downloads e nenhuma receita foram relatados; não há baseline organizado que comprove a causa. Redesign e keywords não garantem ranking.

## 3. Decisões consolidadas e mudanças da v3

| Área | Requisito vigente |
| --- | --- |
| Plataforma | iOS primeiro, iPhone prioritário; iPad responsivo; Flutter reaproveitado; Android depois |
| Mercado/aquisição | EUA; App Store/ASO inicialmente; sem orçamento de anúncios ou creators |
| Marca/design | Nome e ícone livres para mudar; Coral Social da opção 2, com organização compacta da opção 1 |
| Modo | **Classic somente**, 3–20 jogadores; Guided, perguntas, votação digital, pontuação e ranking fora do produto |
| Home | Configuração completa, sem seletor de modo e sem tela separada de Game options |
| Jogadores | Quantidade na home; nomes automáticos opcionais; Edit names abre bottom sheet |
| Impostores | Resumo/quantidade na home; ajuste Auto/manual por bottom sheet |
| Dica | Switch Imposter hint na home, desligado inicialmente; mostra categoria, nunca palavra |
| Timer | Switch on/off na home; desligado inicialmente; com on, tocar no card/texto abre bottom sheet de duração |
| Troll | Switch na home, desligado inicialmente; proposta de dinâmica na seção 6 |
| Ações fixas | Premium quando não premium + Start game fixos na parte inferior; container totalmente transparente; conteúdo rola até o final |
| Apoio | Ao fim do conteúdo rolável, dois botões: Share e Rate us. Interpretação de “compartilhar e avaliar” do pedido; não dois destinos sociais obrigatórios |
| Avaliação no mockup | Perguntar se está gostando; não → sugestão; sim → simulação do prompt nativo. Risco de publicação e alternativa documentados na seção 12 |
| Papéis | Múltiplos impostores; cada um conhece só o próprio papel; segurar revela, soltar esconde |
| Sorteio | Reduzir repetição consecutiva, mantendo aleatoriedade; qualquer jogador pode começar |
| Final | Discussão/voto fora do app; confirmação revela todos os impostores e a palavra juntos |
| Repetição | Play again gera nova rodada mantendo grupo e configurações; ajustes secundários |
| Retomada | Snapshot local; voltar sempre com segredo oculto; permitir encerrar e recomeçar |
| Idiomas | UI final em en, pt-BR, es, hi, ar; conteúdo novo inglês americano; demais bancos preservados |
| Monetização | Assinatura anual ou semanal; 3 categorias grátis e 20 extras enquanto assinante; partidas ilimitadas, sem anúncios |
| Premium | Assinatura ativa, com os mesmos benefícios nos dois planos. Direitos permanentes anteriores preservados separadamente |
| Loja | Paywall fechável; total cobrado e período claros; restore/gestão; preço localizado. Categoria bloqueada abre paywall e volta ao sheet |
| Direitos | Reorganizar/renomear pacotes sem perder acesso equivalente ou restauração |
| Áudio | Sons/haptics discretos e desativáveis, iguais entre papéis; música off inicialmente |
| Testes | Grupos próximos no Brasil + IA; validação cultural americana posterior sem bloquear primeiro lançamento |

## 4. Evidência e diagnóstico

### Código existente

A base atual possui `app_router.dart`, `game_flow_controller.dart`, serviços de perguntas/votação/placar, limite comum 3–9 e modo guiado padrão. A v3 exige retirar esses fluxos da navegação comercial, e ampliar o modelo de impostores, jogadores e persistência. Não basta esconder o seletor.

Conteúdo existente: seis categorias gratuitas/180 palavras e três pacotes ingleses/60 palavras segundo a auditoria anterior. O protótipo v3 utiliza três categorias gratuitas desse banco e uma amostra premium nova; os temas/volumes novos da seção 9 continuam uma proposta editorial. O banco pode conservar perguntas antigas por compatibilidade, mas Classic não as consome nem anuncia.

A persistência atual do Flutter guarda grupo/configurações/histórico, não toda a rodada. RevenueCat/Firebase e componentes existentes podem ser reaproveitados. `outPlayerId` único precisa evoluir para uma lista de impostores. Histórico de palavras permanece; pontuação não participa do novo fluxo.

### Concorrente

ScreensDesign: Imposter Who? – Word Game, Sokak Technologies, Store ID 6746781192; gravação 3355. O registro mostra configuração centralizada, revelação privada, conversa/temporizador, resultado; também mostra hint, Troll mode, assinatura e online. Adotar a organização útil sem copiar marca ou todos os recursos.

Fontes: [home gravada](https://screensdesign.com/apps/imposter-who-word-game/?vs=291010&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens), [rodada](https://screensdesign.com/apps/imposter-who-word-game/?av=3355&flow=46089&ts=101.000&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens), [app](https://screensdesign.com/apps/imposter-who-word-game/?utm_source=screensdesign&utm_medium=mcp&utm_content=app_detail). Gravação não comprova todas as versões nem causalidade do ranking. Índices dos prints não são volume absoluto de busca.

Pendências: metadados reais US, exports de tráfego e build publicado. A página pública consultada anunciava 20+ jogadores, divergindo da base local: nova comunicação deve dizer precisamente **3–20**. Manter mesmo Store ID/bundle ID.

## 5. Arquitetura de informação e fluxos

### Home Classic

Ordem: marca/ajuda/configurações → título compacto → Your crew/contador/Edit names → categorias → Imposters → Imposter hint → Discussion timer → Troll mode → Share/Rate us → rodapé editorial. How to play fica somente no ícone “?” do header, com rótulo acessível; abre um bottom sheet sobre a home, com seis passos numerados, nota de hint/Troll e X para fechar. Não repetir o acesso no final da home. Fechar preserva grupo, configurações e scroll.

Sobre o conteúdo: dock fixo com Premium (quando aplicável) e Start game. Não há barra de navegação inferior, modo alternativo, onboarding obrigatório, perguntas, voto digital ou ranking.

As configurações de nomes, categorias, impostores e duração são sheets sobre a home. Ajuda também abre em bottom sheet; settings e assinatura são destinos opcionais de suporte; depois de Start, as telas obrigatórias pertencem à rodada.

### Rodada principal

Abrir → home pronta com 3 nomes e mistura gratuita → Start game → jogador 1 segura/revela/solta → Next player → repetir → discussão com iniciador sorteado → voto presencial → Reveal → confirmar → todos os impostores + palavra → Play again ou Edit game.

### Bottom sheets

- Select categories → lista de 23, seleção/check ou cadeado → Confirm; cadeado abre paywall e retorna ao mesmo rascunho.
- Edit names → lista rolável e contador → Save names ou fechar → mesma home/posição de scroll.
- Imposters → Auto recomendado ou número → Done → resumo atualizado na home.
- Timer off → tocar switch liga com última duração válida (3 min inicialmente), sem abrir sheet automaticamente. Timer on → tocar texto/card abre duração → Done. Switch sempre alterna apenas on/off; não dispara o card junto.
- Hint/Troll → alternância imediata, sem sheet adicional.

### Premium

Botão Premium da home (não assinante), categoria bloqueada, convite opcional no resultado e configurações → S17 paywall anual/semanal → checkout → retorno ao contexto original. S16 mostra status/gestão. Nunca bloquear Start, revelação, discussão ou Play again. Ver regras, pesquisa e limites em [Monetização e paywalls](monetizacao-e-paywalls.md).

### Compartilhamento/avaliação

Share → share sheet do sistema, com fallback copiar link. Rate us → pergunta solicitada → não: sugestão → confirmação; sim: pedido nativo de avaliação (no HTML, apenas simulado). Nenhuma abertura automática durante a partida; ver seção 12 antes de implementar esse encaminhamento na versão de loja.

### Retomada

Abrir com snapshot válido → Resume ou End game. Resume retorna à fase confirmada com papel escondido e timer pausado. End game confirma descarte só da rodada, mantendo grupo/configuração/direitos.

## 6. Regras do Classic

### R01 — padrões e grupo

Classic único; 3–20 jogadores, default 3. Player 1 etc. quando nome vazio. Guardar IDs locais e nomes para reuso, diferenciar duplicados com aviso. Diminuir grupo recalcula sugestão e limita escolha manual com feedback. Nenhum registro de conta obrigatório.

### R02 — impostores normais

| Jogadores | Auto sugerido | Máximo manual |
| --- | --- | --- |
| 3–5 | 1 | floor((N−1)/2), mínimo 1 |
| 6–9 | 2 | floor((N−1)/2) |
| 10–14 | 3 | min(6, floor((N−1)/2)) |
| 15–20 | 4 | min(6, floor((N−1)/2)) |

Regra proposta mantida da v1: mínimo 1; impostores normais em minoria. Auto adapta a N; manual mantém escolha se válida. Sheet indica a seleção atual e quantos são recomendados.

### R03 — sorteio e sigilo

Amostragem ponderada sem reposição: peso 1 para quem não foi impostor na última rodada normal; 0,5 para quem foi. Todos mantêm chance positiva. Sorteio independente do iniciador entre todos. Não exibir pesos/histórico nem identificar parceiros impostores.

Todos os inocentes recebem mesma palavra e categoria. Impostor recebe só seu papel; com hint ligado, recebe categoria. Usar mesmo tamanho de cartão externo, duração, som/haptic e gesto para todos. Não incluir segredo/nome/papel em logs, analytics ou mensagens de erro.

### R04 — Troll mode (proposta operacional)

Switch disponível gratuitamente e off por padrão. Quando on, **15% de chance por rodada** de todos serem impostores; nos demais casos, respeitar Auto/manual. A probabilidade é uma proposta ajustável após testes, não uma escolha explícita do proprietário. Não criar outra configuração na home.

Determinar uma única vez ao iniciar e persistir o resultado. Cada pessoa vê “You’re an impostor”, sem aviso de Troll nem informação sobre outras. Com hint ligado, todos recebem a mesma categoria. A palavra existe para revelação final, mas ninguém a vê durante distribuição. No resultado, mostrar “Troll round — everyone!” junto da palavra e nomes. Timer, votação presencial e replay continuam iguais. Rodada Troll não substitui o histórico ponderado de impostores da última rodada normal.

Aceite: toggle off nunca gera todos impostores; on permite rodada normal e Troll; retomada não sorteia novamente; nenhum tratamento visual/sonoro revela Troll antes do final. É uma exceção intencional ao teto normal de impostores, não erro de validação.

### R05 — conteúdo

Mistura inicial só de categorias gratuitas do idioma escolhido. Escolha múltipla opcional. Priorizar palavras não vistas; categoria elegível com peso igual e palavra pouco recente. Evitar repetição até esgotar conjunto, depois reciclar as menos recentes sem limite artificial de partidas. Se houver alternativa, replay não repete a palavra imediatamente anterior.

Não selecionar todas as categorias automaticamente ao assinar. Selecionar inglês com conteúdo de outro idioma pede confirmação e limpa a seleção incompatível, mantendo UI no idioma escolhido. Uma rodada tem um idioma de conteúdo congelado. Exemplos comerciais não devem aparecer nas primeiras cinco rodadas do pacote quando houver alternativas suficientes.

### R06 — revelação

Segurar revela; soltar/cancelar/sair do cartão/perder foco/background esconde. Next só habilita após olhar e esconder; próximo cartão coberto e sem herdar gesto pressionado. Repetir gesto antes de avançar é permitido. Alternativa acessível explícita de revelar/ocultar. Ao background, cobrir preview do app; não prometer impedir fotos/screenshots do sistema.

### R07 — timer

Off inicialmente; on usa 3 min inicialmente e última duração depois. Sheet oferece 1–10 min em passos de um. Iniciar contagem após última revelação. Pausar/retomar durante discussão; background pausa e persiste restante. Zero dá sinal discreto segundo preferências, mas nunca revela. Grupo pode seguir conversando. Alterações de configuração não alteram uma rodada ativa silenciosamente.

### R08 — final/repetição

Confirmar antes de revelar todos os impostores e palavra juntos, incluindo categoria. Sem adivinhação extra, vencedor calculado, voto no app ou placar. Play again cria uma única rodada, mesmo com duplo toque, mantendo preferências/grupo. Novo sorteio não significa garantir troca de papel individual. Edit game volta à home.

### R09 — snapshot/migração

Guardar versão, grupo/IDs, configurações, idioma/content version, palavra, lista de impostores, flag Troll, hint congelado, fase, índice do jogador, timer restante e ID da rodada. Persistir cada transição confirmada. Nunca restaurar cartão aberto. Escrita falha permite retry ou continuação com aviso da limitação de retomada.

Migrar preferências, nomes, palavras vistas e direitos. Remover dependência de pontuação/perguntas do runtime Classic. Snapshot antigo Guided não deve ser reinterpretado como Classic: encerrar com explicação legível ou oferecer início novo, preservando grupo/compras. Snapshot antigo livre compatível pode ser migrado. Validar schema e recuperar corrupção sem expor segredo. Conteúdo versionado deve resolver IDs usados pela partida existente.

## 7. Inventário de telas e componentes

Preservar IDs para rastreabilidade. **S10–S14 foram aposentados**; não reutilizá-los para telas novas. S02 e S04 agora são bottom sheets, não páginas.

| ID | Superfície | Conteúdo / critérios de aceite |
| --- | --- | --- |
| S00 | Inicialização | Marca discreta; não esperar rede; home ou retomada |
| S01 | Home Classic | Todos os controles definidos na seção 5; dock transparente e independente do scroll; Start válido com defaults; Premium só quando aplicável |
| S02 | Edit names sheet | Contador 3–20, nomes opcionais, lista rolável, salvar/fechar; retorna à mesma posição da home; teclado não encobre ação |
| S03 | Bottom sheet de categorias | Lista simples de 23 opções; emoji, nome, check ou cadeado à direita; multisseleção e Confirm fixo |
| S04 | Imposters sheet | Auto + escolhas válidas; indicação atual; Done; atualiza resumo da home |
| S05 | Revelação privada | Nome/posição, hold/release, ocultar e passar; mesmo tratamento entre papéis |
| S06 | Discussão | Iniciador, instrução de voto presencial, timer se ativo, Reveal; sem turnos obrigatórios |
| S07 | Confirmar revelação | Cancel mantém rodada; Reveal encerra e mostra segredo |
| S08 | Resultado Classic | Nomes dos impostores, palavra/categoria, estado Troll, Play again e Edit game; sem score |
| S09 | Retomada | Resume/End game, sem segredo; preservar preferências ao encerrar |
| S10–S14 | Removidos | Setup Guided, perguntas, voto digital, pontos e ranking não aparecem em navegação ou marketing |
| S15 | Bottom sheet Como jogar | Seis passos numerados, nota de hint/Troll, fechar com X sem reset; acesso pelo ? do header |
| S16 | Estado Premium | Plano ativo, restauração e acesso à gestão nativa; não é loja de pacotes |
| S17 | Paywall | Anual/semanal, mesmos 20 extras, preço total, recorrência, fechar, restore e links legais |
| S18 | Compra/restore | Sucesso, cancelamento, pendência, erro e restauração sem inventar direito |
| S19 | Settings | Idioma, áudio, haptics, restore, suporte, privacidade/termos, reset; controles comerciais continuam disponíveis para premium |
| S20 | Saída/reset | Explicar o que será apagado; não apagar direitos |
| S21 | Recuperação | Snapshot/conteúdo/gravação inválidos; retry e nova rodada sem perder direitos |
| S22 | Timer sheet | Acessível só com timer on na home; duração selecionada; 1–10 minutos; fechar preserva última escolha |
| S23 | Compartilhar | Share sheet nativa ou copiar link; cancelamento sem erro; link do app publicado |
| S24 | Gostando do jogo? | No mockup: sim → S26, não → S25, depois/fechar → home |
| S25 | Sugestão | Campo, cancelar/enviar, envio/erro/confirmação; nada enviado sem ação explícita; HTML simula confirmação |
| S26 | Avaliação nativa | StoreKit na implementação futura elegível; HTML representa estado visual sem avaliação real; não afirmar que avaliou pela chamada da API |

## 8. Layout, design system e acessibilidade

Direção aprovada: Coral Social + organização enxuta. Canvas #FFF9F3, surface #FFFDFB, ink #38221D, ação coral #C84232, peach #FAE8DD, gold #F7C862 e sucesso #346C53. Rubik nos títulos e Plus Jakarta Sans no corpo, fontes locais. Nome/ícone final ainda depende de disponibilidade.

Home compacta, cartões com bordas leves; seções de opções semelhantes à referência fornecida. Imposters usa botão de valor/chevron; Hint/Troll apenas switch. Timer tem área de texto/card clicável quando ligado e switch independente. Nenhum botão abre tela de Game options.

**Dock:** fixo à viewport do app (à moldura do telefone no mockup), Premium acima de Start game. Background do container transparente, sem painel opaco ou gradiente; botões têm preenchimento próprio. Z-order acima do conteúdo e abaixo de sheets. Áreas vazias não capturam scroll/toque. Conteúdo recebe padding inferior de pelo menos altura real do dock + safe area + folga; última ação deve subir completamente acima dele. Quando Premium some, recalcular reserva. Testar texto ampliado e orientação; não fixar uma altura que corte labels.

**Sheets:** handle/fechar, foco acessível, backdrop, Escape no HTML; nomes com região interna rolável e ação acessível com teclado aberto; altura limitada ao espaço útil. Fechar devolve contexto e posição de scroll da home. Não perder alterações de nome ao tocar Done diretamente.

**Targets e contraste:** pelo menos 44×44 no app final; texto 200%, VoiceOver, focus, RTL e movimento reduzido. Não depender só de cor/gesto/som. O protótipo inglês é artefato de design; tradução integral da UI e validação nativa permanecem gates de lançamento.

## 9. Catálogo e monetização

**Modelo aprovado: assinatura anual ou semanal, com os mesmos benefícios.** Três categorias gratuitas (Food, Animals, Sports) e vinte premium. Todos os recursos e rodadas Classic continuam gratuitos. Compras avulsas e combo saem da oferta para novos clientes; direitos já adquiridos precisam de migração e restauração equivalentes.

O catálogo proposto, preços ilustrativos, estados de assinatura, fluxo do sheet, fontes pesquisadas, gatilhos de paywall, métricas e critérios completos estão em [Monetização e paywalls](monetizacao-e-paywalls.md), parte normativa deste PRD.

Meta editorial proposta: 40 palavras por categoria (120 grátis + 800 premium), todas revisadas, sem perguntas guiadas. O mockup usa 90 palavras gratuitas existentes traduzidas e apenas 5 exemplos em inglês por categoria premium (100 exemplos); não confundir com catálogo pronto para lançamento. Priorizar revisão de ambiguidade, duplicatas, referências americanas e idade. Preservar os bancos anteriores como fonte e direitos, sem apagar conteúdo já comprado. O aumento para 20 categorias exige nova estimativa de conteúdo no plano.

## 10. Instrumentação e sucesso

Métrica inicial principal: aparelhos nos EUA que iniciam e concluem uma rodada por semana. Um aparelho representa um anfitrião/grupo, não N usuários adquiridos. Não há meta de receita ou ranking validada.

| Evento | Momento / parâmetros permitidos |
| --- | --- |
| setup_viewed | Entrada real; entry_point, first_use; mode constante classic |
| setup_option_changed | Controle confirmado; option e valor não sensível; não registrar nome |
| round_started | Snapshot confirmado; round_id, player_count, imposter_count, hint_enabled, timer_enabled, troll_enabled, content_language/version |
| roles_completed / discussion_started | Último papel; duração ativa; não incluir quem é impostor, palavra ou nomes |
| round_revealed | Confirmação final; duração; proxy de conclusão, não prova de diversão ou voto real |
| round_resumed / abandoned | Retomada ou saída explícita; fase; ausência de evento não prova abandono |
| rematch_started | IDs de rodada anterior/nova para deduplicação |
| paywall_viewed / plan_selected / paywall_dismissed | placement, category_id quando aplicável, plan, offering/version; deduplicar impressões |
| subscription_purchase_* / entitlement_changed / restore_completed | Plano, status, erro normalizado; receita/renovação/refundo reconciliados com loja |
| share_requested / share_completed | Ação; cancelamento quando API informa; não registrar destinatários |
| feedback_opened / submitted | Apenas estado, nunca texto da sugestão |
| review_requested | Tentativa de chamada, não avaliação efetivamente feita; não registrar nota como review real |

Medir: impressões únicas US Search/Browse, downloads iniciais e conversão conforme [definição Apple](https://developer.apple.com/help/app-store-connect-analytics/reference/metrics-definitions/); ativação first round/first opens; mediana/P75 até começar; tempo de distribuição por grupo; replay; D7/D30 e retorno em janelas separadas; paywall→assinatura por placement/plano; receita líquida, renovação, churn, reembolso e retenção do jogo; crashes e falhas de retomada. País de uso, storefront, idioma e moeda são dimensões diferentes.

14 dias para baseline/coleta. Revisões D7/D14/D30. Com pouco tráfego, mostrar contagens e evitar declarar significância de A/B. Com menos de 100 primeiros acessos por coorte, tratar taxas como exploratórias (regra de comunicação, não cálculo de poder). Prioridade diagnóstica: qualidade → descoberta → conversão → ativação → replay → monetização.

Metas propostas de usabilidade: 4/5 anfitriões iniciam sem ajuda; mediana ≤20s no primeiro uso/defaults e ≤10s no retorno; zero exposição involuntária observada; 4/5 entendem timer/sheets e repetem sem orientação.

## 11. Persistência, operação e testes

P0 sem backend novo para gameplay. Models/serviços do Classic separados da lógica antiga; catálogo embutido; analytics não bloqueia jogo. Snapshot versionado e escrita idempotente. Salvar nomes localmente, sem enviá-los a compras/analytics.

Reaproveitar Flutter, gateway RevenueCat, locale, conteúdo, áudio e previews. Atualizar rotas para excluir Guided/perguntas/votos/score; adicionar sheets e dock. Remover dependência de capacidade de perguntas para jogar qualquer palavra.

Testes: 3/20 pessoas; Auto/manual em todos os limites; mudança de contagem; Troll normal/todos; hint congelado; timer off/on/zero/background; release/cancel/focus; restart real do processo; dados corrompidos; compras/restore/cache/revogação; nome salvo ao tocar Done; scroll da última ação acima do dock; teclado com 20 nomes; empty selection; idioma misto; 5 idiomas, RTL, texto ampliado, iPad e rotação. Unitários com RNG injetado; widgets para interação; aparelho físico para lifecycle/StoreKit.

Pesquisa: dois grupos de 3–6 pessoas próximas, cinco anfitriões; tarefas sem ensinar: iniciar, editar nomes, impostores, timer, rolar até Share/Rate, revelar/passagem, replay, interrupção, entender Premium. Registrar dúvidas, tempos, falhas de toque e palavras desconhecidas. IA não conta como participante. Validação posterior com 5–8 anfitriões americanos avalia cultura e proposta; não bloqueia P0.

## 12. Compartilhamento, feedback e avaliação — ressalva de publicação

### Comportamento solicitado e representado

Rate us na home abre “Enjoying Oddly?”; Yes abre preview do prompt nativo; Not quite abre formulário de sugestão. Cancelar qualquer etapa volta à home sem perder grupo/scroll. Campo vazio não envia; após envio mostrar confirmação ou erro com retry. Nenhum incentivo, pacote ou Troll desbloqueado por avaliação. No HTML, confirmação de feedback e estrelas são simulações; nada é enviado.

Compartilhar utiliza ação explícita e link público do app atual enquanto marca provisória. Web Share com fallback copiar; em iOS usar share sheet. Não registrar contatos ou concluir que usuário compartilhou quando cancelou. E-mail real de suporte ainda precisa ser confirmado. No app futuro abrir compositor editável ou implementar envio aprovado separadamente; não enviar automaticamente logs/segredos.

### Risco conhecido

Encaminhar apenas respostas positivas à loja caracteriza filtragem de feedback e pode contrariar as diretrizes da Apple sobre avaliações e prompts customizados. O fluxo pedido está **documentado e demonstrado**, mas **não está validado para publicação**. Fonte oficial consultada em 25/10/2026: [App Review Guidelines, seção 5.6](https://developer.apple.com/app-store/review/guidelines/).

Recomendação antes do release: “Avaliar” acessível a todos com API nativa, e “Enviar sugestão” independente, sem ramificar por satisfação. Isso preserva os dois canais e elimina a filtragem. A decisão de publicação deve resolver esta divergência; não declarar silenciosamente o fluxo simulado como aprovado pela loja. A API nativa pode não mostrar o pedido; jamais marcar “avaliou” só por chamá-la. Não abrir solicitação durante uma rodada.

## 13. Privacidade, riscos e pendências

Auditar declarações de Firebase/RevenueCat e política: página pública consultada dizia não coletar dados, o que deve refletir instrumentação real. Não adicionar tracking publicitário ou ATT sem finalidade real. Classificação etária depende do conteúdo efetivo. Suporte/links/termos precisam corresponder à marca e vendedor.

| Pendência/risco | Ação / gate |
| --- | --- |
| Dados e metadata US ausentes | Export antes da mudança da loja; ausência não bloqueia código local |
| Nome Oddly provisório | Verificar disponibilidade/conflitos antes dos assets finais |
| Probabilidade de Troll | 15% proposta do mockup; confirmar equilíbrio com teste local |
| Definição de Premium | Coleção atual como proposta; validar mapping de lifetime/legados antes de release |
| Fluxo de review filtrado | Resolver conforme seção 12 antes de publicação |
| Sem revisão cultural americana | Revisão humana apoiada por IA + avaliação futura; não anunciar validação inexistente |
| Rodapé encobre fim da home | Padding dinâmico/safe area, scroll e testes com texto ampliado |
| Persistência/compra | Testes físicos/sandbox e migração antes da submissão |
| Endereço de feedback | Confirmar contato e estados reais de envio |

## 14. Fases futuras

P1: validação americana e expansão editorial; Android; conteúdo próprio; pacotes adultos identificados/fora da mistura; demo de pacote; refinamento iPad. P2: online por link, aquisição paga ; expansão de catálogo sustenta o valor recorrente da assinatura já prevista no P0. Guided não está no roadmap atual. Nenhum login/chat/ads/notificação obrigatório no P0.

## 15. Critérios globais de aceite

- [ ] Classic único; nenhuma tela/ASO oferece Guided, perguntas, voto digital ou ranking.
- [ ] Home contém todos os controles e começa com defaults; 3–20 funciona.
- [ ] Nomes/impostores/duração em sheets; fechar preserva contexto e alterações confirmadas.
- [ ] Timer off não abre duração; on permite abrir; switches não provocam navegação involuntária.
- [ ] Troll off padrão; rodada especial persistida e oculta até resultado.
- [ ] Premium e Start fixos, container transparente; fim da home alcançável e clicável acima do dock.
- [ ] Premium some com assinatura ativa; compras legadas, lifetime e restore respeitados.
- [ ] Share e Rate no fim da home; sugestão com cancelamento/validação; simulação distinguida de API real.
- [ ] Decisão sobre filtragem de avaliações resolvida antes de publicação.
- [ ] Segredos ocultos na passagem, interrupção e retomada; resultado só após confirmação.
- [ ] Replay sem reconfiguração; gameplay ilimitado e offline; nenhum paywall forçado.
- [ ] Conteúdo e contagens reais consistentes com screenshots/metadata.
- [ ] Cinco idiomas e acessibilidade nativa verificados na versão Flutter final.
- [ ] Métricas/coleta, privacidade, compra/restore e TestFlight validados.

## 16. Referências de implementação

`lib/src/app/app_router.dart`, `app_routes.dart`, `game_flow_controller.dart`; `domain/models/game_models.dart`; `data/session/session_repository.dart`; `data/content/us_pack_catalog.dart`; `features/setup/`, `features/game/`, `features/packs/`; `domain/services/app_review_prompt.dart`.

[Auditoria editorial anterior](../content-audit-2026-10-20.md), [compras existentes](../us-release-and-monetization.md), [sandbox](../sandbox-setup-status.md). Esses registros descrevem a base antiga e não substituem as decisões Classic desta versão.

## 17. Critérios adicionais v3 — assinatura e categorias

- [ ] 3 grátis + 20 premium na mesma lista, com check ou cadeado à direita; sem grid de detalhes.
- [ ] Seleção em rascunho; Confirm aplica; fechar cancela; ao menos uma categoria.
- [ ] Categoria bloqueada abre paywall; fechar volta ao sheet com seleção intacta.
- [ ] Compra validada retorna ao sheet, libera acesso e permite confirmar a categoria desejada; conteúdo inglês exige consentimento de idioma.
- [ ] Anual/semanal concedem mesmo entitlement, sem trial ou descontos inventados.
- [ ] Premium some só com acesso de assinatura ativo (e eventual lifetime equivalente auditado); restore e gestão continuam disponíveis.
- [ ] Nenhuma paywall automática no meio da rodada, no primeiro Start ou ao tocar Play again.
- [ ] Expiração/revogação afeta a próxima rodada; snapshot atual permanece jogável. Seleção sem acesso é retirada com aviso e fallback grátis.
- [ ] Preço real, renovação, troca de plano, restore, grace period e legado testados em sandbox antes do lançamento.

### Refinamento visual — ícones e ajuda contextual

Your crew recebe 👥; Categories recebe 🗂️; Imposters recebe 🥷; Imposter hint, 💡; Discussion timer, ⏱️; Troll mode, 😈. Os seis usam emojis coloridos com tamanho e alinhamento uniformes, no mesmo estilo das categorias selecionadas. Ícones decorativos acompanham rótulos, sem substituir texto nem criar novos controles. S15 é bottom sheet, não página separada: seis passos adaptados ao Classic (3–20, segurar/soltar, pistas, blefe, voto presencial e revelação), X acessível, rolagem interna e fundo inerte; Escape fecha no HTML. Galeria do protótipo continua mostrando S15 como atalho de revisão.

### Resumo das categorias na home

O card Categories exibe etiquetas com emoji e nome de cada categoria selecionada, no idioma do conteúdo, com quebra de linha. Se todas as 23 categorias estiverem selecionadas, substituir as etiquetas por uma única “All”. Todas as três gratuitas não equivalem a All: seus nomes continuam visíveis. Card inteiro abre S03; Confirm atualiza o resumo e fechar sem confirmar mantém as etiquetas anteriores.

No S03, oferecer Select all / Clear acima da lista. Select all free para não assinantes seleciona somente três gratuitas; assinante seleciona 23, mediante confirmação de idioma quando necessário. Clear limpa o rascunho; Confirm desabilitado vazio; fechar não apaga a seleção salva.
