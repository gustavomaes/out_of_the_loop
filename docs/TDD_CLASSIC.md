# TDD_CLASSIC — desenho técnico e plano de entregas

Versão 1.0 · 25/10/2026 · Status: proposta técnica para implementação.

TDD significa **Technical Design Document** neste documento. O plano inclui testes por etapa, sem exigir test-first para toda mudança visual. Nenhuma etapa está implementada ou aprovada para publicação apenas por constar aqui.

## 1. Objetivo e referências

Reconstruir a experiência Classic no projeto Flutter existente: um telefone, 3–20 jogadores, múltiplos impostores, conversa e votação presenciais, partidas gratuitas ilimitadas e assinatura Premium anual/semanal para categorias extras.

Referências:

- [PRD v3](prd/PRD-reformulacao-ios-us.md): requisitos de produto.
- [Monetização e paywalls](prd/monetizacao-e-paywalls.md): assinatura, acesso, catálogo e estados comerciais.
- [Plano anterior](prd/plano-de-desenvolvimento.md): IDs C00–C22 para rastreabilidade.
- [Protótipo Suslo](../prototypes/oddly/index.html) e [limites da demonstração](../prototypes/oddly/README.md): referência visual e de interação; compras e persistência web não são implementação nativa.
- [Avaliação do código](../.notebook/classic-rebuild-assessment.md): limites de reaproveitamento verificados.

A confirmação do proprietário nesta conversa adota a versão com assinatura Premium. A v2 histórica de compra avulsa não orienta novas vendas. Este documento detalha execução técnica; mudanças de produto continuam sendo registradas no PRD. Em conflito, prevalecem instruções posteriores do proprietário e os requisitos específicos de monetização v3 sobre trechos residuais antigos.

## 2. Decisões e limites

### 2.1 Estratégia de reconstrução

- Manter o repositório e os projetos nativos iOS/Android. Criar branch `codex/classic-rebuild` na execução, preservando previamente o trabalho local e uma referência da versão anterior.
- Criar modelos, controlador e telas Classic independentes dos modelos Guided. Não adicionar novas regras Classic ao `GameFlowController` antigo.
- Preservar `com.mathsquirrels.outoftheloop`, registro da loja, configurações de assinatura de distribuição, Firebase e RevenueCat relevantes.
- Manter os dois fluxos apenas durante a construção, com entrada de desenvolvimento explícita. O binário final terá somente Classic acessível.
- Reutilizar dependências atuais quando suficientes; nenhuma troca de gerenciador de estado ou nova infraestrutura é requisito desta reformulação.
- Gameplay e catálogo funcionam offline, sem conta ou backend novo. Rede comercial/analytics não bloqueia a primeira rodada gratuita.
- Não alterar produtos reais, publicar ou apagar configurações de produção como consequência de uma tarefa local de implementação.

### 2.2 Reaproveitamento previsto

| Área | Destino |
| --- | --- |
| `lib/src/app/game_flow_controller.dart`, modelos e serviços de pontuação | Substituir no runtime Classic; remover após a troca definitiva |
| Rotas, setup, revelação, discussão e resultado | Reconstruir para o novo fluxo |
| Projetos `ios/` e `android/` | Preservar e ajustar apenas necessidades verificadas |
| Preferências, áudio, bootstrap Firebase e estrutura l10n | Adaptar; manter chaves compatíveis quando possível |
| Histórico e palavras existentes | Migrar com IDs/mapeamentos explícitos e revisão editorial |
| Parser de conteúdo atual | Substituir por schema Classic sem perguntas obrigatórias |
| Gateway RevenueCat | Reaproveitar conexão/SDK; separar produtos, pacotes e entitlements |
| Componentes visuais | Reutilizar somente quando compatíveis com Coral Social e acessibilidade |
| Testes | Manter os relevantes; substituir expectativas Guided conforme remoção do código |

Baseline conhecida: 58 testes de `test/domain` e `test/data` passaram na avaliação de 25/10/2026. Isso não certifica a suíte completa, o binário publicado ou transações reais.

### 2.3 Fora do P0

Guided, perguntas, votação digital, placar, ranking, login, online, anúncios, conteúdo criado pelo usuário e lançamento Android. Preservar a configuração Android não implica incluí-lo no lançamento inicial. iPad responsivo e cinco idiomas da interface permanecem no P0.

## 3. Arquitetura proposta

Separar UI, aplicação, domínio e adaptadores de dados. Domínio Classic em Dart sem widgets, Firebase, RevenueCat ou SharedPreferences. Controlador coordena operações; widgets apresentam estado e enviam comandos. Evitar um framework genérico para um único modo.

Estrutura sugerida, a confirmar com as convenções do repositório na etapa 1:

```text
lib/src/
  domain/classic/
    classic_models.dart
    classic_rules.dart
    classic_round_factory.dart
    classic_word_selector.dart
  data/classic/
    classic_content_repository.dart
    classic_session_repository.dart
    classic_legacy_migration.dart
  data/purchases/
    purchase_gateway.dart              # adaptar contrato existente
    premium_access_policy.dart
  features/classic/
    application/classic_controller.dart
    application/classic_state.dart
    presentation/                     # home, sheets, rodada e resultado
  features/premium/                   # paywall, estado e gestão
```

Rotas propostas: home, rodada, resultado, settings e Premium. Nomes, categorias, impostores, duração, ajuda e confirmação final são sheets/dialogs sobre o contexto atual. A rota não transporta palavra, nomes ou papéis em URL/parâmetros públicos. Router consulta o estado antes de admitir uma tela de rodada.

Dependências injetáveis mínimas: RNG, relógio monotônico, repositório de conteúdo, repositório de sessão, gateway de compras e analytics. Usar fakes somente nos testes e na entrada de desenvolvimento.

### 3.1 Contratos principais

| Contrato | Responsabilidade e dados |
| --- | --- |
| `ClassicPlayer` | ID local estável e nome; não usar nome como identidade comercial |
| `ClassicConfig` | Grupo, categorias, idioma de conteúdo, Auto/manual, hint, timer/duração e Troll |
| `ClassicRound` | ID, jogadores/config congelados, palavra/categoria, lista de impostores, iniciador e flag Troll |
| `ClassicProgress` | Fase, índice de revelação, confirmação de visualização e tempo restante |
| `ClassicHistory` | Recência de palavras por idioma/categoria e impostores da última rodada normal |
| `ClassicSnapshot` | Versão de schema, revisão, rodada, progresso e versão do catálogo |
| `PremiumAccess` | Estado derivado do SDK, planos disponíveis e acesso legado mapeado; nunca um bool persistido que concede acesso indefinido |
| `CategorySelectionDraft` | Rascunho isolado, categoria que originou paywall e contexto de retorno |

Comandos de aplicação: atualizar configuração, iniciar, revelar/ocultar, avançar jogador, pausar/retomar discussão, confirmar resultado, jogar novamente, retomar snapshot e encerrar rodada. Operações inválidas retornam resultado controlado; widgets não modificam modelos diretamente.

### 3.2 Estado da rodada e privacidade

```text
home → preparing → revealing → discussion → result
                         ↑          ↑
                       resume (sempre coberto e com timer pausado)
result → preparing (Play again) ou home (Edit game)
```

`preparing` representa a criação de uma única rodada e a tentativa de persistência. A confirmação de revelar é transitória: cancelar mantém discussão; confirmar leva a resultado. Abrir um diálogo não sorteia, não encerra e não salva uma fase fictícia.

Invariantes:

- O segredo visível é estado efêmero da UI; nunca restaurar `isSecretVisible=true`.
- Soltar, cancelar gesto, sair da área, perder foco ou entrar em background oculta imediatamente; cobrir também o preview nativo do app.
- Next exige papel visto e cartão novamente coberto. O gesto não é herdado pelo jogador seguinte.
- Retomar não recria papéis, palavra, Troll ou iniciador. Se o app foi interrompido com cartão aberto, exigir nova visualização segura daquele jogador.
- Resultado mostra todos os impostores e palavra somente após confirmação; timer em zero nunca revela.
- Start e Play again possuem exclusão de operação em andamento; múltiplos toques produzem um único ID de rodada.
- Expiração de Premium não interrompe rodada já criada; revalidar seleção para a próxima.

### 3.3 Regras e seleção

Implementar as regras R01–R08 do PRD como funções testáveis:

- Grupo 3–20; Auto: 1 para 3–5, 2 para 6–9, 3 para 10–14 e 4 para 15–20. Manual: `min(6, floor((N−1)/2))` como teto, mínimo 1.
- Sorteio ponderado sem reposição: peso 0,5 para impostores da última rodada normal e 1 para demais; iniciador independente entre todos.
- Troll off nunca altera a rodada. Com on, probabilidade proposta de 15%, isolada em regra configurável e testável; não usar amostragem estatística instável para testar limites.
- Rodada Troll não substitui histórico da última rodada normal. Hint mostra somente categoria, congelada na rodada.
- Selecionar entre categorias elegíveis com peso igual e priorizar palavras não vistas; reciclar as menos recentes ao esgotar. Não repetir imediatamente se houver alternativa.
- Considerar histórico no universo selecionado e idioma congelado. Exemplos comerciais ficam fora das primeiras cinco rodadas do pacote quando houver alternativas suficientes.
- Timer 1–10 minutos, default 3 quando habilitado, off inicialmente. Medir tempo por relógio monotônico; callback de UI apenas atualiza apresentação. Background pausa e persiste restante.

### 3.4 Persistência e migração

Proposta: manter SharedPreferences para o volume pequeno, com um envelope JSON versionado por sessão, escritas serializadas e erros observáveis. Não presumir transação entre múltiplas chaves nem garantia de gravação durante encerramento abrupto.

- Chave proposta `classic.session.v1`; manter `game.session.v1` intacta até validar a migração.
- Envelope contém configuração, histórico e snapshot opcional. Gravar transições confirmadas, não cada frame nem cada segundo; persistir tempo ao pausar, sair e mudar de fase.
- Marcar migração concluída somente após leitura/validação do novo envelope salvo. Migração é idempotente e não apaga fonte ao falhar.
- Migrar nomes, idioma, preferências de áudio e palavras vistas. Se IDs mudarem, usar tabela de equivalência; descartar apenas referências sem correspondência com aviso/registro técnico sem dados sensíveis.
- O armazenamento atual não contém rodada ativa completa: não inventar migração de uma partida Guided que não está persistida. Se outra versão instalada trouxer snapshot desconhecido, preservar preferências válidas e oferecer nova rodada.
- Validar versão, limites, IDs, fase, índices e consistência. Schema futuro desconhecido não é reinterpretado como atual.
- Falha de escrita: permitir retry ou continuação explícita com aviso de que retomada pode voltar à última transição salva. A falha não concede direitos nem expõe segredos.
- Proposta para atualização de catálogo: guardar no snapshot a palavra/categoria localizada necessária à rodada, além de IDs e versão, evitando depender da permanência do asset antigo para finalizar. Snapshot local contém segredo; não enviar em logs, crash reports ou backups diagnósticos.
- Reset de grupo/histórico e encerrar rodada não limpam dados do SDK de compras. Validar atualização sobre instalação anterior sem desinstalar.

### 3.5 Assinatura e política de acesso

O gateway atual aceita apenas não assinaturas e pressupõe que ID de pacote coincide com entitlement. Adaptar esses pontos explicitamente.

- Planos anual e semanal são produtos/pacotes distintos concedendo o mesmo entitlement lógico. `premium_categories` é nome proposto, não configuração já criada.
- Gateway retorna produtos com preço/período localizados e estado de direitos do SDK. Controlador não deduz sucesso pelo toque no CTA ou pelo nome do pacote.
- Política de acesso: categorias grátis OU assinatura válida OU direito legado equivalente auditado.
- Cancelar renovação mantém acesso até o fim do período pago. Expiração/revogação afeta próximas rodadas. Grace period e cache offline seguem o estado validado pelo SDK.
- Refresh no startup/resume e eventos do SDK deve atualizar UI sem bloquear gameplay gratuito; erro de rede não deve ser convertido automaticamente em perda de direito válido em cache.
- Sheet tem rascunho independente. Compra contextual retorna ao mesmo sheet; categoria desejada entra no rascunho somente após validação e consentimento de idioma quando necessário. Confirm continua obrigatório.
- Compra pela home não seleciona todo o catálogo. Restore distingue restaurado, nada encontrado e erro. Gestão permanece acessível ao assinante.
- Novas vendas não oferecem packs/combos antigos; mapping e produtos legados não são apagados para simplificar a UI.
- Sem backend novo obrigatório. Receita deve ser reconciliada pelos relatórios da loja/RevenueCat; um futuro webhook exige escopo próprio e deduplicação.

## 4. Sequência de entregas

Cada etapa termina com demonstração ou evidência reproduzível. Desenvolvimento local pode avançar com gateways falsos identificados; isso nunca satisfaz o aceite comercial de release.

| Etapa | Entrega demonstrável | Depende de | IDs anteriores |
| --- | --- | --- | --- |
| 0 | Baseline e inventário de migração | — | C00 |
| 1 | Estrutura Classic e componentes visuais | 0 | C01/C04 |
| 2 | Home configurável com todos os sheets | 1 | C02/C03/C18 |
| 3 | Partida gratuita completa e replay | 2 | C05–C08 |
| 4 | Partida retomável e atualização migrada | 3 | C09 |
| 5 | Catálogo de lançamento validado | 1; integrar após 3 | C10/C21 |
| 6 | Premium integrado e validado em sandbox | 2/4; catálogo final para aceite | C11/C12/C19/C20/C22 |
| 7 | Suporte, métricas, idiomas e acessibilidade | 4/6 | C13–C15 |
| 8 | Release candidate Classic sem legado ativo | 5/6/7 | C16 |
| 9 | Pacote de publicação e acompanhamento | 8 | C17 |

A produção editorial da etapa 5 pode avançar durante as etapas 2–4. Preços/produtos e sandbox devem ser preparados cedo para não bloquear a etapa 6. Essa independência de frentes não exige múltiplos agentes nem desenvolvimento simultâneo.

### Etapa 0 — baseline e preparação

**Evidência da execução (25/10/2026):** [baseline e inventário de migração](classic/BASELINE_STAGE_0.md), com contagens reproduzíveis em [content-inventory.json](classic/baseline/content-inventory.json). Pendências externas da loja e do RevenueCat permanecem identificadas no relatório; não representam aprovação comercial ou de publicação.

**Objetivo:** conhecer o ponto de partida e preservar o que permite atualizar o app existente.

**Entregáveis:** inventário do build publicado versus fonte local; IDs de app/produtos/entitlements; chaves de preferências; contagem de conteúdo por idioma; matriz de reaproveitamento; registro inicial de pendências. Guardar referência Git e instrução de build sem segredos.

**Aceite:** identificador de produção preservado; diferenças entre evidência local e loja claramente marcadas; nenhuma mudança local prévia perdida. Ausência de export da loja fica pendente, sem bloquear código independente.

**Verificação:** baseline de análise/testes e build disponível; registrar comando, revisão, resultado e limitações. Responsável pelo produto confirma dados comerciais que não puderem ser consultados.

### Etapa 1 — base técnica e design system

**Evidência da execução (25/10/2026):** [base Classic, demonstração e validação](classic/STAGE_1.md). Entrada independente em `lib/main_classic.dart`; integração na `main` solicitada pelo proprietário.

**Objetivo:** permitir desenvolvimento Classic sem acoplar o novo jogo ao Guided.

**Entregáveis:** modelos/contratos mínimos, controller inicial, catálogo fixture sem perguntas, injeção de dependências e entrada de desenvolvimento; tokens Coral Social, botões, cards, switches e sheet padrão. Estrutura de localização desde o início.

**Aceite:** entrada Classic abre offline; domínio não importa widgets/SDKs; componentes têm estados normal/desabilitado/loading/erro e tamanhos acessíveis. Nenhum serviço abstrato sem consumidor necessário.

**Verificação:** análise estática, testes de limites de configuração e previews dos componentes em tela pequena/texto ampliado.

### Etapa 2 — home e configuração completas

**Evidência da execução (25/10/2026):** [home Classic, sheets e validação](classic/STAGE_2.md). Demonstração offline em `lib/main_classic.dart`; Start indisponível até a etapa 3 e Premium explicitamente fake.

**Objetivo:** demonstrar todo o preparo de uma partida antes de integrar o sorteio.

**Entregáveis:** S01/S02/S03/S04/S15/S22; nomes 3–20; categorias com rascunho; impostores Auto/manual; hint, timer e Troll; dock transparente; ajuda pelo header. Premium usa gateway fake apenas na demonstração até a etapa 6. Start pode permanecer explicitamente indisponível nesta etapa.

**Aceite:** defaults válidos; salvar último nome com teclado aberto funciona; timer off não abre duração; switch não dispara card; Clear desabilita Confirm; fechar categorias cancela rascunho; Select all free escolhe três; All aparece somente com 23. Scroll alcança últimas ações acima do dock em ambos os estados Premium.

**Verificação:** testes de widgets para interação/foco, retorno de sheets e geometria do dock, com 20 nomes e texto 200%. Demonstração gravada ou roteiro reproduzível.

### Etapa 3 — primeiro jogo completo

**Evidência da execução (25/10/2026):** [partida gratuita, replay e validação](classic/STAGE_3.md). Implementação disponível em `lib/main_classic.dart`, com testes automatizados e build/inspeção em simulador iOS; aceite em aparelho físico permanece pendente. Persistência pertence à etapa 4.

**Objetivo:** entregar uma versão jogável gratuita do início ao replay.

**Entregáveis:** sorteio, seleção multicategoria, S05–S08, timer, Troll, confirmação final, alternativa acessível para revelar e Play again. Catálogo inicial real mínimo; catálogo completo chega na etapa 5.

**Aceite:** iniciar com defaults → passar 3 ou 20 papéis → discussão → confirmar → resultado → nova rodada. Todos os invariantes da seção 3.2 são respeitados. Sem pergunta/voto/placar digital. Encerrar ou voltar nunca revela incidentalmente.

**Verificação:** testes unitários com RNG/clock controlados para limites e histórico; widgets para hold/release/cancel/Next; duplo Start/replay produz uma rodada. Teste físico inicial de background e proteção do preview. Timer off/on/zero e Troll normal/todos têm cenários separados.

### Etapa 4 — persistência, migração e retomada

**Evidência da execução (25/10/2026):** [persistência, migração, retomada e validação](classic/STAGE_4.md). Código e testes entregues em `lib/main_classic.dart`; atualização e reinício de processo verificados no simulador. Etapa em validação: atualização de versão publicada e aceite em aparelho físico permanecem pendentes.

**Objetivo:** não perder ou alterar silenciosamente uma rodada em interrupções.

**Entregáveis:** envelope versionado, fila de gravação, migração, S09/S20/S21 e tratamento de lifecycle; relatório de atualização sobre instalação anterior.

**Aceite:** matar e reabrir processo em cada fase restaura a última transição confirmada, mesmos papéis/palavra e timer pausado; cartão nunca abre sozinho. Configuração e histórico migram uma vez. Erro/corrupção oferece recuperação sem apagar preferências válidas ou direitos.

**Verificação:** fixtures antigas/corrompidas/versão futura; falha de escrita injetada; escritas em sequência; testes em aparelho com app atualizado sem reinstalar. Verificar reset, fim de rodada e retomada após mudança de catálogo.

### Etapa 5 — conteúdo pronto para comercialização

**Objetivo:** substituir amostras por biblioteca coerente com a oferta.

**Entregáveis:** schema Classic, conversor/mapping de IDs antigos, catálogo versionado, validador e relatório editorial por categoria/idioma. Meta proposta do PRD: 120 palavras gratuitas + 800 Premium, com revisão humana; não contar tradução como palavra nova.

**Aceite:** 3 categorias grátis e 20 Premium para novos usuários; nenhuma pergunta obrigatória; IDs únicos, ausência de entradas vazias, contagens comerciais verificáveis e idioma correto. Palavras compradas antigas continuam acessíveis pelo mapping. Exemplos da paywall e regras de recência têm correspondência real.

**Verificação:** checker de schema/IDs/referências/duplicatas e testes do parser; revisão humana de ambiguidade, adequação etária e referências culturais. Registrar idiomas com tradução disponível e os extras somente em inglês. Não anunciar validação americana que não ocorreu.

**Dependência de produto:** eventual redução da meta editorial exige ajuste explícito de escopo e comunicação, não publicação silenciosa dos cinco exemplos por categoria.

### Etapa 6 — Premium real

**Objetivo:** validar pagamento e acesso completo, além do layout do paywall.

**Entregáveis:** gateway adaptado; `PremiumAccess`; S16–S18; entradas voluntárias por categoria/home/settings/resultado; restore e gestão; matriz de direitos legados; evidências sandbox com revisão do build/produtos usados.

**Aceite:** anual/semanal concedem mesmos extras; preço vem da loja; pendência/cancelamento/erro não liberam acesso; renovar cancelado não significa expirado; Premium some quando aplicável; compra contextual preserva rascunho/scroll. Rodada em curso termina mesmo com expiração; próxima usa seleção válida e aviso. Não existe oferta automática em Start ou replay.

**Verificação:** testes do mapeamento pacote→produto→entitlement, estado offline e revogação; widgets dos estados de compra; sandbox em aparelho para compra, cancelamento, pendência quando reproduzível, restore/reinstalação, troca de plano, renovação, expiração, grace period e reembolso. Cenários não reproduzíveis ficam identificados com evidência alternativa e risco, nunca marcados como aprovados.

**Dependências externas:** preços finais, produtos/grupo/entitlement, configuração do RevenueCat, conta sandbox, termos/privacidade e auditoria de lifetime. Relato de zero vendas reduz volume esperado; não comprova ausência de direitos legados.

### Etapa 7 — experiência completa e observabilidade

**Objetivo:** tornar a versão utilizável e diagnosticável no público-alvo.

**Entregáveis:** S19/S23 e suporte/avaliação conforme decisão de produto; en/pt-BR/es/hi/ar; áudio/haptics; analytics com lista permitida de parâmetros; documentação de coleta e painel/roteiro de leitura de métricas.

**Aceite:** UI traduzida, RTL e texto 200%; VoiceOver permite revelar/ocultar sem hold; iPad e rotação não expõem segredo nem bloqueiam ações. Share cancelado não é sucesso; abrir compositor de feedback não equivale a mensagem enviada; tentativa de review não equivale a avaliação. Nomes/papéis/palavras/texto de feedback ausentes de eventos e erros.

**Verificação:** testes de contrato l10n; widgets representativos nos cinco idiomas; inspeção de eventos; aparelho com VoiceOver, movimento reduzido, áudio off e rede indisponível. Eventos não são duplicados por rebuild/retomada. Rodada continuada após erro de persistência deve ter diagnóstico distinto do início duravelmente salvo.

**Pendência:** resolver a bifurcação de review do mockup antes da implementação de produção. Proposta: avaliação disponível a todos e feedback independente. Não copiar a filtragem como requisito já liberado para publicação.

### Etapa 8 — integração final e release candidate

**Objetivo:** produzir um binário Classic consistente e verificável.

**Entregáveis:** troca definitiva da entrada/rotas; remoção de Guided e dependências sem uso; suíte atualizada; matriz de QA preenchida; teste com cinco anfitriões em pelo menos dois grupos; build TestFlight candidato e lista de problemas priorizados.

**Aceite:** nenhum caminho público leva a perguntas/votação/guess/ranking/onboarding obrigatório; conteúdo e preço apresentados são reais. Zero defeito conhecido de exposição de segredo, perda de direito, compra sem acesso ou bloqueio do fluxo principal. Metas propostas de usabilidade: 4/5 iniciam e repetem sem ajuda; registrar tempos observados e corrigir fricção crítica.

**Verificação:** suíte completa, análise estática, build de release e instalação física. Testar primeira abertura, atualização, offline, 3/20 jogadores, iPhone pequeno/padrão e iPad, retrato/paisagem, idiomas/RTL e estados comerciais. Conferir assets e identidade do binário exportado; não inferir do código que o IPA está correto.

### Etapa 9 — publicação e leitura dos resultados

**Objetivo:** deixar a atualização pronta e acompanhar o efeito do novo produto.

**Entregáveis:** checklist de submissão, screenshots reais, metadata coerente, notas de revisão sobre assinatura, versão/build identificados, plano de hotfix e relatório D7/D14/D30 após lançamento.

**Aceite:** mesmo app/Bundle ID; políticas/contatos válidos; versão e build adequados à atualização; todos os bloqueadores de release encerrados; pacote concreto disponível para revisão do proprietário antes da publicação. Publicar é uma ação posterior, não consequência da criação deste documento.

**Verificação:** conferir distribuição/restore e links no candidato; observar crashes, retomada, primeira rodada, replay e funil Premium por origem/plano. Registrar denominadores: baixo tráfego não sustenta conclusões fortes de conversão. Não prometer rollback instantâneo; preservar fontes/catálogo/mapping para hotfix.

## 5. Contrato de conclusão de cada etapa

Uma etapa só passa de **pendente → em execução → em validação → concluída** quando tiver:

- Artefato utilizável: código executável, catálogo validado, relatório ou binário, conforme a etapa.
- Cenário de demonstração descrito em passos, com resultado esperado.
- Critérios de aceite marcados com evidência; requisito externo não verificado permanece pendente.
- Comandos de validação, resultado, revisão Git e limitações registrados.
- Alterações de schema/configuração e instrução de recuperação, quando aplicável.
- Nenhum defeito crítico introduzido nem alteração fora do escopo necessária para revisar a entrega.

Cada entrega deve ser pequena o suficiente para revisão própria. Não acumular todas as telas e o billing em uma única mudança. Testes acompanham a etapa: não deixar privacidade, migração e entitlement para um bloco final de QA.

Comandos-base existentes: `flutter analyze --no-fatal-infos` e `flutter test`. Executar subconjuntos relevantes por tarefa e a suíte completa na etapa 8. Se o ambiente impedir a execução, registrar a limitação e o comando pendente; não confundir código escrito com aceite concluído.

## 6. Marcos e ordem recomendada

| Marco | Etapas concluídas | O que deve ser possível demonstrar |
| --- | --- | --- |
| M1 — configuração | 0–2 | Preparar grupo e regras no visual final |
| M2 — jogo | 3 | Jogar e repetir offline, sem monetização obrigatória |
| M3 — confiabilidade | 4 | Atualizar/fechar/reabrir sem mudar a rodada |
| M4 — comercialização | 5–6 | Biblioteca final, compra e restore reais |
| M5 — candidato | 7–8 | App localizado, acessível e testado com pessoas |
| M6 — lançamento | 9 | Pacote revisável, publicação autorizada e métricas posteriores |

Não fixar datas neste TDD. O plano anterior contém estimativas preliminares; reestimar depois da etapa 0 e de M2, separando esforço de implementação, revisão editorial e espera de serviços externos. A biblioteca Premium e o sandbox podem determinar o prazo mesmo quando as telas estiverem prontas.

## 7. Pendências e decisões antes do lançamento

| Tema | Situação atual | Quando resolver |
| --- | --- | --- |
| Marca | Protótipo usa Suslo; PRD ainda menciona Oddly provisório | Antes de ícone/screenshots/metadados finais |
| Preços/trial | Valores do HTML ilustrativos; trial não aprovado | Antes de configurar oferta final da etapa 6 |
| Troll | 15% é proposta operacional | Validar em testes de jogo antes do RC |
| Catálogo | 40 palavras/categoria é meta; amostras insuficientes para venda final | Etapa 5 |
| IDs e lifetime | Mapping real precisa de auditoria | Iniciar em 0; concluir antes do aceite de 6 |
| Review | Mockup filtra feedback; alternativa de produção ainda precisa ser consolidada | Antes do fluxo de produção da etapa 7 |
| Contatos/links legais | Confirmar endereço e URLs da marca | Etapas 6–7 |
| Build publicado | Fonte local não garante equivalência com versão instalada | Etapas 0 e 8 |
| Texto residual no PRD | Seção de riscos ainda cita Premium como coleção | Usar monetização v3; reconciliar PRD na próxima revisão documental |

Essas pendências não bloqueiam trabalho independente. Nenhuma é resolvida implicitamente por implementar o comportamento do HTML.

## 8. Checklist de liberação

- [ ] Classic único, 3–20, sorteio, Troll e replay verificados.
- [ ] Segredo protegido em gesto, navegação, background, preview e retomada.
- [ ] Snapshot/migração testados com atualização real e falhas de gravação.
- [ ] Catálogo revisado; contagens e idiomas correspondem à oferta.
- [ ] Assinatura/restore/expiração/legado validados; preços reais.
- [ ] Home/sheets utilizáveis com teclado, VoiceOver, RTL e texto ampliado.
- [ ] Cinco idiomas, iPad e rotação verificados.
- [ ] Analytics e crash reports sem conteúdo sensível da rodada.
- [ ] Fluxo de review, contato e documentos legais resolvidos.
- [ ] Guided removido de navegação, assets comerciais e expectativas de teste aposentadas.
- [ ] IPA correto, mesmo Bundle ID, versão/build e TestFlight conferidos.
- [ ] Evidências de QA e teste humano anexadas; falhas críticas encerradas.
- [ ] Pacote de submissão revisado e publicação autorizada separadamente.
