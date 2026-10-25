> ARQUIVADO — versão 1, substituída pela versão Classic. Não usar para implementação atual. Links relativos deste snapshot referem-se à localização original.

# Plano de desenvolvimento e critérios de aceite

Companheiro do [PRD](PRD-reformulacao-ios-us.md) e do [plano de ASO](aso-e-lancamento.md). Data: 25/10/2026.

## 1. Capacidade, sequência e estimativa

Estimativa de planejamento para uma pessoa com apoio de IA: **32–47 dias úteis de trabalho focado**, aproximadamente **7–10 semanas com 5–6 horas por dia**, mais folga de 15–25% conforme achados. Não é data prometida. Revisão da Apple, acesso às contas e falhas de sandbox podem acrescentar espera externa. Trabalho parcial aumenta o calendário proporcionalmente.

Entregar em incrementos revisáveis. Primeira entrega interna: modo rápido com novo visual funcional. Primeira entrega pública: P0 completo, incluindo ASO, direitos de compra e confiabilidade. Não publicar uma versão que prometa retomada ou 20 jogadores antes de validar esses recursos.

| Fase | Estimativa | Entrega / dependência | Gate de saída |
| --- | --- | --- | --- |
| 0 Diagnóstico e decisões operacionais | 2–3 dias | Baseline, inventário de compras/conteúdo, nome provisório, aparelho de referência | Riscos e contratos documentados; nenhuma perda potencial de direito ignorada |
| 1 Design e contratos de domínio | 3–5 dias | Tokens claros, protótipos Flutter de setup/reveal/resultado, estados e esquema v2 | Fluxo compreensível; modelos distinguem quick/guided |
| 2 Modo rápido completo | 7–9 dias | Setup único, 3–20, múltiplos impostores, categorias, reveal, conversa, replay | Fluxo inteiro funcional offline e testado em limites |
| 3 Retomada e modo guiado | 5–7 dias | Persistência, timer lifecycle, guiado simplificado, ranking | Processo pode morrer sem expor segredo ou duplicar resultado |
| 4 Catálogo e comércio | 6–9 dias | Conteúdo revisado, pacotes, combo, migração e sandbox | Direitos preservados, compras reais de teste verificadas |
| 5 Qualidade, pesquisa e instrumentação | 5–7 dias | Cinco idiomas, acessibilidade, testes com grupos, eventos | Nenhum bloqueador de sigilo, compra ou início; métricas funcionais |
| 6 ASO, TestFlight e submissão | 4–7 dias | Nome/ícone finais, screenshots, metadata, políticas e notas | Checklist de lançamento assinado pelo proprietário |
| 7 Observação pós-lançamento | 30 dias corridos | Correções, baseline US, relatório semanal | Próximas prioridades baseadas em evidência, não só downloads |

Produção editorial pode começar após fase 0, em blocos curtos entre tarefas técnicas, mas sua duração já está incluída na fase 4; não supor duas pessoas trabalhando simultaneamente. Se houver pressão de prazo, cortar volume editorial adicional, vídeo e polimento secundário. Não cortar sigilo, restore, acessibilidade básica, instrumentação ou traduções prometidas.

## 2. Backlog executável

Cada tarefa deve virar uma alteração pequena ou conjunto coeso. “Pronto” inclui implementação, testes relevantes e evidência, não só compilação.

| ID | Entrega | Dependências | Critérios de aceite e evidência |
| --- | --- | --- | --- |
| D00 | Inventário técnico/publicado | Nenhuma | Registrar commit/build local, build publicado, arquivos de catálogo, rotas e divergências; capturas do estado anterior |
| D01 | Inventário comercial e ASO | D00 | Produtos/entitlements, lifetime e regiões anotados; export de metadata/métricas ou ausência explícita; e-mail de suporte confirmado |
| D02 | Tokens e componentes | D00 | Novo tema claro, CTA, cards, sheets e campo de jogador; contraste e 200% de texto em três telas representativas |
| D03 | Contratos por modo | D00 | Quick aceita 3–20 e conjunto de impostores; Guided 3–9 e um impostor; sem transformar votos antigos em múltiplos papéis |
| D04 | Setup unificado | D02/D03 | App abre no setup, Quick padrão, iniciar com nomes automáticos; nenhum tutorial obrigatório; acesso a ajuda e modo alternativo |
| D05 | Grupo e preferências | D04 | Salvar 20 jogadores, nomes opcionais, IDs estáveis, grupos separados por modo; migrar nomes antigos sem truncar rápido |
| D06 | Multicategoria e idiomas | D03/D04 | Mistura gratuita padrão; seleção múltipla; confirmação ao trocar conteúdo para inglês; pacote comprado não entra sozinho |
| D07 | Sorteio e histórico | D03/D06 | Amostragem ponderada sem reposição, chance positiva para todos; iniciador independente; sem palavra repetida se houver alternativa |
| D08 | Revelação segura | D02/D07 | Gesto hold/release, cancel, background e próximo cobertos; todos veem apenas o próprio papel; efeitos indistinguíveis |
| D09 | Conversa e timer | D08 | Voto presencial, 1–10 minutos opcional, pausa em background, zero não revela; confirmação final obrigatória |
| D10 | Resultado e replay | D09 | Todos os impostores + palavra; replay com um toque e mesmo setup; botão duplo não gera rodada dupla |
| D11 | Snapshot e restauração | D03/D05/D10 | Persistir todas as fases; restore oculto; migração v1/v2; JSON corrompido e escrita falha recuperáveis |
| D12 | Guiado simplificado | D03/D06/D08/D11 | 1–5 rodadas, perguntas por capacidade, votação sem autovoto, regra 1/2 pontos, empate definido, ranking com empates |
| D13 | Revisão editorial | D00/D06 | Catálogo gratuito e premium auditados, perguntas revisadas, outros idiomas preservados; contagens reais registradas |
| D14 | Loja e direitos | D01/D06/D13 | Exemplos/idioma/preço claros; restore; combo honesto para comprador parcial; produtos e entitlements antigos preservados |
| D15 | Sandbox físico | D14 | Evidência de compra, cancelamento, restore/reinstalação, offline, pendente quando ambiente permitir e revogação; limitações anotadas |
| D16 | Instrumentação/privacidade | D04/D11/D14 | Eventos únicos em DebugView, sem segredo/nome; reconciliar SDKs e formulários; falha de analytics não bloqueia |
| D17 | Ajuda, configurações e feedback | D02/D12 | Regras por modo, áudio/haptics persistidos, música off, mailto e fallback copiar, restore e links |
| D18 | Localização/acessibilidade | D08/D12/D17 | en/pt-BR/es/hi/ar, RTL, VoiceOver, 200% texto, iPad/rotação, sem segredo acessível coberto |
| D19 | Teste de usabilidade | D10/D12/D14 | Cinco anfitriões, tarefas do PRD, achados e correções; separar validação cultural de usabilidade |
| D20 | Marca/ASO e build final | D01/D13/D15/D18/D19 | Nome validado, ícone próprio, screenshots reais, metadata contada e versão enviada conferida |
| D21 | Lançamento/observação | D16/D20 | Checklist concluído, release identificado nos relatórios, revisões D7/D14/D30 agendadas no plano operacional |

## 3. Mapa de implementação no repositório

| Área | Base existente | Mudança esperada |
| --- | --- | --- |
| Navegação | `lib/src/app/app_router.dart`, `app_routes.dart`, `discovery_shell.dart` | Entrada em setup, remover desvios obrigatórios; mapear rotas antigas sem crash |
| Estado | `lib/src/app/game_flow_controller.dart` | Orquestrar por modo, snapshot e replay idempotente |
| Modelos | `lib/src/domain/models/game_models.dart` | Separar configuração/rodada rápida da guiada; múltiplos IDs de impostores somente onde necessário |
| Regras | `lib/src/domain/services/` | Sorteio ponderado, categorias, limites por modo, pontuação simples e timer testável |
| Sessão | `lib/src/data/session/session_repository.dart` | Esquema novo e migração; salvar rodada além das preferências |
| Conteúdo | `assets/content/`, `local_content_repository.dart`, `us_pack_catalog.dart` | Multicategoria/idioma, catálogo versionado e IDs estáveis |
| UI | `lib/src/features/setup/`, `game/`, `home/`, `onboarding/` | Reaproveitar componentes úteis; retirar home/onboarding do caminho inicial sem deletar ajuda necessária |
| Compras | `lib/src/features/packs/`, gateway existente | Storefront claro e equivalência de direitos; não reimplementar billing |
| Tema | `lib/src/theme/`, `shared/widgets/` | Tema claro e semântica consistente; migração gradual dos nomes “brutalist/neon” |
| Localização | `lib/src/l10n/` e fontes ARB existentes | Editar fontes e gerar arquivos; não editar traduções geradas como fonte de verdade |
| Métricas | `lib/src/data/analytics/` | Mapa compatível de eventos antigos/novos e parâmetros não sensíveis |
| Avaliações | `lib/src/domain/services/app_review_prompt.dart` e gate final | Pedido nativo sem pré-filtro; não interpretar API como review concluído |
| Testes | `test/domain/`, `test/features/`, `test/data/`, previews existentes | Adaptar expectativas à regra nova, preservar cobertura do guiado/compras |

Antes de editar, verificar AGENTS.md aplicável, skills relevantes e estado do Git. Não apagar trabalho preexistente nem renomear todos os componentes só para eliminar nomenclatura histórica. Não acrescentar dependências sem necessidade demonstrada.

## 4. Cenários de aceite detalhados

### A01 — iniciar sem preparação

Dado app recém-instalado e sem rede, ao abrir vejo Quick, três jogadores automáticos e mistura gratuita. Ao tocar Start game, aparece o primeiro cartão coberto. Não há cadastro, compra, tutorial obrigatório nem necessidade de editar nomes.

### A02 — limites e troca de modo

Com 20 jogadores, rápido inicia e todos recebem um papel. Ao selecionar guiado, o app pede reduzir/selecionar participantes, preservando grupo rápido. Dois jogadores não podem iniciar. Sugestão automática muda conforme a tabela; configuração manual inválida é corrigida com aviso.

### A03 — nenhum vazamento na passagem

Ao segurar, vejo meu papel; ao soltar ou minimizar, ele some. Ao avançar, o próximo não recebe conteúdo revelado. Repetir em todos os papéis, VoiceOver, rotação, notificação, app switcher e arrastar dedo para fora. Não usar foto/screenshot como promessa de prevenção absoluta.

### A04 — encerramento rápido

O grupo pode discutir sem tocar no celular. Voto não é exigido no app. Cancelar Reveal mantém rodada. Confirmar revela palavra e todos os impostores juntos, sem pontos ou palpite. Timer zerado não revela automaticamente.

### A05 — repetição

Após resultado, Play again cria uma única rodada, com o mesmo setup, nova amostra de papéis e palavra diferente quando possível. Testar duplo toque e erro de gravação. Não exigir que cada impostor mude de papel.

### A06 — interrupção real

Encerrar processo durante revelação, conversa, voto e resultado. Abrir apresenta retomada sem segredo. Retomar restaura progresso confirmado, timer pausado e score sem duplicação. Snapshot inválido permite nova partida sem perder grupo ou compras. Teste de restart do processo, não apenas rebuild de widget.

### A07 — inglês em interface estrangeira

Com UI portuguesa e catálogo português, pacote inglês aparece identificado. Compra não muda idioma. Seleção explícita pede confirmação para conteúdo inglês; a rodada usa um idioma só, UI continua portuguesa. Repetir com árabe e texto bidirecional.

### A08 — direitos e falhas de compra

Comprador antigo restaura pacote renomeado equivalente. Combo concede exatamente os três pacotes definidos. Cancelamento não concede nem bloqueia jogo. Pendência não aparece como sucesso. Direito confirmado/cacheado funciona offline; revogação impede novos usos pagos após atualização do direito. Não reaproveitar uma flag local de protótipo.

### A09 — guiado e pontos

3 e 9 pessoas completam rodada com perguntas suficientes. Todos votam sem autovoto; contagens só no final. Maioria estrita, empate e placar seguem R08. Resultado reaplicado por retomada não duplica pontos. Voltar à configuração não mistura estado guiado no rápido.

### A10 — telemetria

Uma rodada/replay produz uma sequência única de eventos esperados. Background não aumenta tempo ativo. Nenhum payload inclui nome, palavra, papel individual ou voto. Quando SDK está indisponível, todos os fluxos seguem funcionando. Receita customizada não duplica receita padrão.

## 5. Estratégia de testes

Unitários: limites por modo, sugestão/teto, amostragem sem reposição com RNG injetado, independência do iniciador, seleção de palavras, pontuação, migração e resolução idempotente. Para aleatoriedade, testar propriedades com seeds fixas e cenários controlados; evitar teste flakey de frequência exata.

Widgets: setup sem teclado obrigatório, sheets de opções, estados de compra, gesto hold/cancel, nomes longos, categorias pagas, idioma, erro e CTA habilitado. Reusar testes/preview existentes quando fizer sentido; o objetivo é comportamento observável, não duplicar o código em asserts.

Integração/aparelho: lifecycle, morte de processo, áudio/haptics, timer, reinstalação/restore e pagamento real de sandbox. Testes com gateway fake não substituem StoreKit/RevenueCat reais.

Matriz mínima: iPhone pequeno/normal/grande; iPad; retrato/paisagem; cinco idiomas; texto 1×/2×; Quick 3/20, Guided 3/9; offline; conta sem/um/todos os pacotes; snapshot novo/antigo/corrompido. Fazer matriz ampla em telas críticas e smoke nos demais, em vez de todas as combinações cartesianas.

Executar testes direcionados por tarefa; ao fechar release, suíte completa e análise estática. Comandos existentes de referência: `flutter test` e `flutter analyze --no-fatal-infos`; usar SDK/configuração do projeto, sem atualizar dependências indiscriminadamente. Capturas de preview não provam comportamento em release físico.

## 6. Instrução reutilizável para implementação com IA

```text
Implemente somente a tarefa Dxx do docs/prd/plano-de-desenvolvimento.md.
Leia o PRD principal, as regras referenciadas e as instruções aplicáveis do repositório.
Antes de editar, verifique código e testes atuais, diferenças locais e dependências da tarefa.
Preserve decisões da entrevista, direitos de compra e os cinco idiomas.
Identifique propostas e pendências; não invente dados de loja, chaves ou resultado de testes.
Faça a menor alteração coesa, com testes dos critérios observáveis da tarefa.
Ao terminar, informe arquivos alterados, validação executada, limitações e próximos passos.
Não publique, altere produtos reais ou envie metadata como parte desta tarefa de código.
```

Formato do registro de entrega: tarefa, commit/versão, critérios aprovados, comandos/resultados, capturas pertinentes, pendências e impacto sobre outras tarefas. Uma tarefa bloqueada por loja não deve impedir trabalho independente de UI/domínio.

## 7. Gates de lançamento e resposta a problemas

Bloqueadores: vazamento acidental de segredo; perda de compra; restore quebrado; corrupção recorrente; compra cobrada sem acesso; crash no fluxo principal; promessa da página sem implementação; ausência de idioma anunciado. Corrigir antes de publicar.

Problemas menores: ajuste cosmético, categoria adicional, animação secundária e quantidade acima do mínimo editorial podem ir ao backlog. Não usar ausência de revisão americana como afirmação de qualidade comprovada; documentar a limitação.

Preservar tag/build anterior e backup dos catálogos e mapping de entitlements. Atualização de app não tem rollback instantâneo garantido: preparar hotfix; não apagar produtos/direitos como mitigação. Separar problemas de metadata, catálogo e código. Uma opção comercial indisponível deve ser ocultada/desabilitada sem afetar partida gratuita.

## 8. Próximas fases após observar resultados

| Prioridade futura | Condição para começar |
| --- | --- |
| Revisão cultural americana e expansão editorial | Relatos ou dados de repetição justificam; buscar anfitriões americanos |
| Android | P0 estabilizado e capacidade para billing/testes próprios da plataforma |
| Personalização de palavras/categorias | Demanda recorrente observada, com plano de persistência e moderação se houver compartilhamento |
| Pacotes adultos | Revisão editorial/classificação e isolamento da mistura geral definidos |
| Demo de pacote | Necessidade de reduzir dúvida de compra sem criar fricção ou exploração |
| iPad dedicado | Uso relevante ou problemas observados no layout responsivo |
| Online por link | Retenção presencial validada e capacidade para backend, expiração, abuso e privacidade |
| Assinatura | Catálogo e lançamentos frequentes; preservar compras perpétuas existentes |
| Aquisição paga | Funil e receita mensuráveis; orçamento específico aprovado posteriormente |

Não há automação criada nem publicação agendada por este documento. Os checkpoints são instruções de operação para o proprietário.
