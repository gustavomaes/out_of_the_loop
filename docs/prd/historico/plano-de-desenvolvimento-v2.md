> Histórico substituído pela versão 3 — não usar como requisito vigente.

# Plano de desenvolvimento — Classic v2

25/10/2026. Este plano substitui a v1. [PRD vigente](PRD-reformulacao-ios-us.md) · [ASO](aso-e-lancamento.md). Guided foi retirado, não apenas adiado.

## 1. Escopo e estimativa

Uma pessoa com IA, Flutter existente, iOS primeiro. **25–37 dias úteis focados (aproximadamente 5–8 semanas a 5–6 h/dia)**, mais 15–25% de folga e espera externa de revisão/sandbox. Proposta de planejamento, não data prometida. A redução em relação à v1 vem da remoção de perguntas/votos/placar; home/sheets, Troll, migração, comércio e QA continuam necessários.

| Fase | Dias | Saída |
| --- | --- | --- |
| 0 Diagnóstico | 2–3 | Metadata/baseline, catálogo, direitos legados, mapping Premium e decisão de review |
| 1 Home/design system | 3–4 | Home Classic, dock transparente, sheets, switches, responsividade |
| 2 Classic | 5–7 | 3–20, múltiplos impostores, Troll, hold/release, timer e replay |
| 3 Persistência | 3–5 | Migração, retomada oculta, erros e lifecycle |
| 4 Conteúdo/comércio | 5–7 | Catálogo revisado, packs/coleção, direitos e sandbox |
| 5 Qualidade/métricas | 4–6 | Idiomas, acessibilidade, instrumentação, usuários e regressões |
| 6 ASO/release | 3–5 | Marca final, screenshots, TestFlight, políticas e submissão |
| 7 Observação | 30 dias corridos | D7/D14/D30, melhorias com base em evidências |

Não publicar promises não implementadas. Se precisar reduzir escopo, adiar volume extra de palavras e polimento secundário; não cortar segredo, restore ou acesso à última ação da home.

## 2. Backlog de implementação

IDs novos C00–C17 evitam confundir tarefas antigas Dxx já substituídas.

| ID | Entrega | Dependência | Aceite |
| --- | --- | --- | --- |
| C00 | Inventário | — | Registrar binário publicado vs fonte, metadata US, pacotes/lifetime e contagens reais |
| C01 | Tokens/corpos | C00 | Coral Social, tipografia, contraste, targets, states; remover seletor de modo |
| C02 | Home/dock | C01 | Impostores, hint, timer e Troll na home; Premium/Start fixos transparentes; footer social alcançável |
| C03 | Sheets | C02 | Edit names 3–20; impostores Auto/manual; timer on abre duração; salvar/fechar mantém scroll |
| C04 | Model Classic | C00 | Lista de impostores, config/snapshot versionados; nenhuma dependência de pergunta/ponto |
| C05 | Conteúdo/sorteio | C04 | Multicategoria, histórico, peso reduzido anterior, iniciador independente e idioma congelado |
| C06 | Troll | C05 | Off nunca ativa; on permite 15% proposto de todos impostores; flag persistida; nenhuma pista antes do resultado |
| C07 | Revelação | C01/C05 | Hold/release/cancel/focus; todos com mesmo tratamento; passagem segura e alternativa acessível |
| C08 | Discussão/final/replay | C06/C07 | Timer opcional, zero não revela, confirmação, todos+palavra, replay idempotente |
| C09 | Persistência/migração | C04/C08 | Restart real; estado oculto; antigo Guided não reinterpretado; grupo e direitos mantidos |
| C10 | Catálogo editorial | C00/C05 | Palavras revisadas por humano; não gerar novas perguntas; manter bancos estrangeiros |
| C11 | Premium/loja | C00/C10 | Bundle/itens; Premium some com coleção completa; partial/lifetime/restore corretos; sem assinatura |
| C12 | Sandbox | C11 | Compra, cancelamento, pending, restore/reinstalação/cache e revogação documentados |
| C13 | Share/feedback/review | C02 | Share explícito e fallback; sugestão com validação/erro; resolver filtragem da seção 12 antes de release |
| C14 | Métricas/privacidade | C08/C11/C13 | Sem segredo, nomes, votos ou texto de feedback; eventos únicos e baseline; dados declarados corretos |
| C15 | Localização/QA | C03/C09/C12 | en/pt-BR/es/hi/ar, RTL, VoiceOver, 200%, iPad/rotação; teclado e dock não bloqueiam ações |
| C16 | Pesquisa/ASO | C10/C15 | Cinco anfitriões, corrigir fricção, screenshots Classic reais, metadata sem Guided |
| C17 | Submissão/observação | Todas P0 | TestFlight físico, build correto, checklist e D7/D14/D30 |

## 3. Critérios testáveis principais

1. Primeira abertura offline: home Classic, 3 nomes, mix gratuito, switches off, Start habilitado; nenhum tutorial ou oferta obrigatória.
2. Edit names abre sheet, permite 20 e scroll/teclado; preencher último input e tocar Save sem sair do campo preserva nome.
3. Imposters abre sheet, escolha atual/Auto e limites coerentes; mudar N limita valor inválido com aviso.
4. Timer off: card não abre sheet. Ligar não abre automaticamente; tocar card com on abre duração. Switch não dispara card por bubbling.
5. Hint/Troll mudam sem navegar e persistem. Troll especial permite todos apesar do teto normal, sem vazar estado antes do final.
6. Dock permanece no mesmo local ao rolar; background computado transparente; Share/Rate/rodapé ficam totalmente visíveis acima do dock no scroll máximo. Premium owned remove apenas seu botão.
7. Hold/release e accessible alternative ocultam antes de Next; retomada não sorteia nem revela novamente de forma automática.
8. Resultado contém nomes/palavra/categoria, estado Troll quando aplicável, sem ranking/pontos; replay não exige setup.
9. Rating mock: sim→preview, não→form, ambos canceláveis; vazio não “envia”; confirmação deixa claro que é simulação. Produção precisa de decisão de compliance registrada.
10. Compra partial vs bundle: não recomendar recompra mais cara; successful é único estado que concede; restored respeita mapping; free play nunca limitado.
11. Localização e estado sobrevivem à mudança de idioma sem alterar rodada ativa; pacotes ingleses precisam de escolha explícita.
12. Sem Guided em navegação, eventos novos de jogo, screenshots ou descrição comercial.

## 4. Mapa técnico Flutter

- `app_router.dart` / `app_routes.dart`: Classic home e jogo; aposentar rotas de perguntas/votos/guess/final ranking e onboarding obrigatório. Sheets em vez de push para nomes/opções.
- `game_flow_controller.dart` / models: estado Classic e impostores múltiplos; RNG e timer injetáveis; eliminar acoplamento de partida ao placar.
- `session_repository.dart`: schema versionado; aceitar 20 nomes; snapshot e migração. Não apagar compras durante reset.
- `features/setup/`: home com lista de opções, controles e overlay fixo; calcular reserva pelo tamanho do dock/safe area; modal sheet com lista/keyboard inset.
- `features/game/`: reveal, conversa, confirmação, resultado e replay; UI única sem variação pública por papel.
- `features/packs/`: derivar Premium de entitlements, não preferências; congelar acesso necessário da rodada ativa.
- `domain/services/app_review_prompt.dart`: revisar encaminhamento solicitado vs política Apple antes da implementação de produção; API não garante exibição.
- `l10n/` / theme / shared: atualizar strings e tokens; fontes ARB como fonte, não editar gerados.
- Dados antigos de perguntas podem permanecer para migração, mas não são requisito de novas palavras Classic.

## 5. Estratégia de QA

Unitários: limites, Auto/manual, RNG determinístico, Troll 0/normal/todos, deduplicação palavra, migração, entitlements, timer e snapshot idempotente. Widgets: switches/sheets/focus, último campo salvo, scroll até footer, dock premium vs free, loading/erro. Integração/aparelho: hold/background, process death, teclado e StoreKit.

Matriz: 3/20 jogadores, tela pequena/padrão/grande/iPad, retrato/paisagem, cinco idiomas, 1×/2× texto, offline, conta sem/parcial/coleção/lifetime, snapshot compatível/corrompido. Reusar testes úteis; remover expectativas Guided aposentadas somente quando a implementação correspondente for removida.

`flutter test` e `flutter analyze --no-fatal-infos` conforme projeto; rodar checks direcionados por tarefa e suíte completa ao release. No mockup: `node --check prototypes/oddly/app.js` e `node prototypes/oddly/test.cjs`. Navegador não substitui teste iOS.

## 6. Orientação para IA

```text
Implemente somente Cxx do plano Classic v2.
Leia PRD vigente, instruções aplicáveis e código/testes atuais.
Não implementar Guided, perguntas, pontuação nem telas antigas da v1 arquivada.
Preserve o trabalho local, cinco idiomas e direitos pagos.
Separe decisões, propostas (Premium/Troll) e pendências reais.
Valide os critérios observáveis e reporte arquivos, testes e limitações.
Não publique ou altere produtos reais como parte de uma tarefa local de código.
```

Bloqueadores de lançamento: segredo exposto; perda de direito; compra sem acesso; restore quebrado; final da home inalcançável; crash de rodada; catálogo/metadata enganoso; divergência de política de review não resolvida. Folga/espera externa e cultura americana não validada devem ficar explícitas.

Guardar build/catálogo/mapping anterior e preparar hotfix; não há rollback instantâneo garantido de app publicado. Observar D7/D14/D30; não alterar múltiplas variáveis de ASO sem volume suficiente. Nenhuma automação, envio ou publicação foi criada por este plano.
