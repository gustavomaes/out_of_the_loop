# Monetização e paywalls — v3

25/10/2026. Parte normativa do [PRD](PRD-reformulacao-ios-us.md). Pedido aprovado: assinatura anual ou semanal, três categorias gratuitas e vinte extras exclusivas da assinatura. Substitui venda avulsa e combo para novos usuários. Valores e trial não foram definidos pelo proprietário.

## Oferta e catálogo

Os dois planos concedem o mesmo entitlement `premium_categories` (identificador proposto), em um único grupo de assinaturas. Anual selecionado inicialmente, semanal com igual legibilidade. Proposta ilustrativa no HTML: **US$19,99 por ano / US$4,99 por semana**, sem trial. Não são preços aprovados ou produtos cadastrados. Não exibir valor semanal equivalente como se fosse o total anual; não usar desconto fictício nem contagem regressiva. No app, buscar valores/períodos localizados do StoreKit/RevenueCat. Trial de 3 dias no anual é hipótese futura, dependente de aprovação e elegibilidade, nunca promessa padrão.

| Acesso | Categorias propostas |
| --- | --- |
| Grátis (3) | Food, Animals, Sports |
| Premium (20) | Movies & TV; Music & Bands; Countries & Cities; Famous People; Everyday Objects; Brands & Logos; Jobs & Professions; Hobbies & Activities; Places Around Town; Nature & Outdoors; Tech & Gadgets; Fashion & Style; On the Move; School Days; Games & Toys; Backyard & BBQ; Road Trip USA; Holiday Hangouts; Sweet Tooth; Ocean & Beach |

Seleção dos temas é proposta editorial para o público americano, não ranking de popularidade validado. Conteúdo básico seguro para adolescentes/famílias. Adultos ficam para depois. Não usar imagens/logotipos de marcas sem licença. Garantir disjunção entre categorias quando possível; aliases não devem gerar repetições do mesmo conceito em sequência. Os vinte extras iniciais em inglês são identificados quando o idioma atual for outro. Interface final mantém todos os idiomas.

Meta de lançamento: 40 palavras revisadas por categoria, 920 no total. O mockup tem 90 grátis do banco existente e 100 exemplos premium, cinco por tema; é amostra funcional, não catálogo comercial final. Após lançamento, reservar revisão editorial mensal; prometer nova cadência ao cliente apenas quando sustentável. A assinatura precisa de biblioteca relevante e manutenção contínua, não apenas troca de forma de cobrança.

## Seleção simples em bottom sheet

Home → Select categories → S03. Header curto, descrição, lista vertical e Confirm fixo dentro do sheet. Cada linha tem emoji, nome e estado à direita: check quando selecionada, cadeado quando bloqueada, vazio quando disponível e não selecionada. Grátis primeiro; premium logo abaixo, sem segunda loja ou cards de detalhes. Rolagem independente sem cobrir a última categoria pelo botão. VoiceOver anuncia “locked” ou “selected”; não depender só de cor.

Abrir cria rascunho da seleção atual. Confirm aplica; fechar cancela alterações. Confirm fica desabilitado sem categoria. No primeiro uso as três grátis vêm selecionadas. Tocar categoria bloqueada preserva rascunho e scroll, abre paywall contextual. Fechar/cancelar/erro retorna ao mesmo sheet sem selecionar conteúdo pago. Após compra validada, voltar ao sheet com acesso liberado e a categoria desejada selecionada no rascunho; Confirm ainda é necessário. A compra isolada pelo botão Premium não seleciona todas as categorias. Se a categoria desejada é inglesa, pedir consentimento antes de trocar o idioma e limpar seleção incompatível.

No mockup, usuário não assinante com compra legada pode ter exceções de acesso. Isso não transforma compra parcial em assinatura nem autoriza revogar conteúdo comprado.

## Paywall

S17: fechar sempre visível; marca própria Coral Social; benefício concreto “20 extra categories”; inglês explicitado; seleção Anual/Semanal com valor total/período; CTA “Subscribe annually/weekly”; renovação automática; cancelamento/gestão via Apple; Restore, termos e privacidade. Nenhuma cobrança/tela nativa real no HTML. Links legais do HTML abrem aviso de simulação; URLs reais precisam ser preenchidas no Flutter.

Nunca anunciar “unlimited games” como exclusivo pago: todas as rodadas e regras Classic são grátis. O Premium fixo da home desaparece quando assinante; gestão/restore permanecem em Settings. Compra pendente, cancelada ou falha não concede direito. Produto indisponível/offline desabilita checkout, mantém saída e jogo gratuito. “Restore checked” sem assinatura não deve afirmar compra restaurada.

## Pesquisa e pontos de entrada

O [replay do concorrente no ScreensDesign](https://screensdesign.com/apps/imposter-who-word-game/?av=3355&flow=69935&ts=17.000&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens) mostra anual US$19,99 com trial de 3 dias e semanal US$4,99, anual pré-selecionado. É uma gravação, não prova de preço atual, conversão ou eficácia; o screenshot fornecido pelo usuário corrobora a apresentação. O fluxo gravado inclui paywall no onboarding, mas não adotaremos esse bloqueio automaticamente.

A [RevenueCat documenta placements](https://www.revenuecat.com/docs/tools/targeting/placements) por contexto, como acesso a uma função restrita e fim do onboarding. Isso permite distinguir resultados por origem e testar ofertas. Não prova que um ponto converte melhor neste jogo. A [Apple orienta assinaturas](https://developer.apple.com/app-store/subscriptions/) com valor contínuo, termos compreensíveis e gestão do acesso. As escolhas abaixo são hipóteses de produto derivadas dessas fontes, a validar com dados próprios.

| Placement | Disparo | Prioridade e guardrail |
| --- | --- | --- |
| locked_category | Toque em categoria com cadeado | P0, maior intenção explícita; explicar categoria desejada e todos os 20 extras; voltar ao rascunho |
| home_premium | Toque no Premium fixo | P0; fechável; não altera a configuração |
| settings | Toque em Explore Premium | P0; para assinantes mostrar gestão, sem segunda compra |
| round_result | Toque em “Try 20 more categories” abaixo de Play again/Edit game | P0; convite secundário só após revelar; nenhum popup automático nem atraso em replay |
| catalog_refresh | Toque em banner de novidades reais no sheet | P1, só quando houver conteúdo novo; não inventar novidade |
| returning_host | Convite discreto após retorno de anfitrião com ≥3 rodadas concluídas | Experimento futuro; no máximo uma exposição por 7 dias, nunca antes de primeira partida; sem paywall automática |
| onboarding_end | Primeira abertura | Não habilitar no P0: conflita com começar imediatamente; só testar mais tarde com métricas de ativação |

Não disparar ao abrir papel, passar celular, ligar timer/hint/Troll, retomar rodada, compartilhar, avaliar ou apertar Start/Play again. Não limitar partidas para fabricar urgência. P0 usa só entradas voluntárias; reabrir por toque explícito pode ocorrer sempre. Não colocar popup automático sobre resultado.

## Estados, legado e recuperação

- Ativa e período já pago: acesso, mesmo com renovação cancelada; não confundir cancelamento futuro com expiração.
- Grace period: respeitar entitlement validado retornado pela loja; billing retry sem entitlement não libera por conta própria.
- Expirada/revogada: bloquear extras para próximas rodadas e avisar; terminar snapshot já iniciado; remover seleção inacessível e oferecer três grátis se vazia.
- Offline: usar estado de entitlement em cache conforme SDK/política de validade; não conceder Premium indefinidamente por booleano local. Sync ao reconectar e antes de nova compra. A demo usa booleano só para ilustrar UI.
- Troca anual↔semanal: mesmo grupo e nível; data efetiva segue StoreKit; mostrar termos reais, não assumir conversão imediata.
- Restore: consultar loja/RevenueCat e reconciliar; nada encontrado é estado explícito. Não redefinir grupo/preferências.
- Compras antigas e lifetime: auditar IDs e promessa vendida, preservar acesso equivalente permanente, restaurável. Não migrar um pacote isolado para todo o catálogo nem retirar lifetime legítimo. Mapear palavras antigas aos temas novos sem perda; acesso legado é exceção documentada à regra de novas vendas.
- Rodada congelada não lê entitlement a cada revelação; segredo nunca exposto em paywall/logs/analytics.

O HTML permite simular assinatura anual/semanal, erro/cancelamento/pendência/sucesso, restore e expiração em Manage Premium. Não há backend, Apple ID, cobrança, renovação temporal real ou recibos.

## Medição e experimentos

Eventos: category_sheet_opened, category_locked_tapped, category_selection_confirmed, paywall_viewed, paywall_dismissed, plan_selected, subscription_purchase_started/pending/cancelled/failed/succeeded, restore_completed, entitlement_changed. Parâmetros: placement, categoria, plano, idioma, offering/versão, estado; nunca nomes, papéis ou texto livre. IDs de transação só no pipeline seguro apropriado; deduplicar receita com webhook da loja/RevenueCat.

Comparar paywall→compra por placement e plano; conversão de instalação a pagante; receita líquida por coorte; retenção D7/D30 do jogo; renovação semanal W1/W4 e anual quando observável; cancelamento, reembolso, duração de assinatura e falhas de restore. Não confundir toque no CTA com receita nem selecionar vencedor anual só pelo caixa inicial. Com baixo volume, mostrar denominadores e entrevistar usuários; não declarar significância.

Primeiro validar compreensão (5 pessoas conseguem identificar valor total, período, renovação, o que é grátis e como fechar). Depois testar preço/trial com uma variável por vez e guardrails de ativação/replay/reembolso. Não copiar métricas do concorrente como previsão.

## Aceite e release

- 23 categorias, exatamente 3 grátis e 20 de assinatura para usuário novo.
- Bloqueio real na seleção e no início de rodada, além do cadeado visual.
- Cancelar paywall preserva rascunho, scroll e grupo; comprar libera sem selecionar tudo.
- Anual e semanal com mesmos direitos, sem dupla assinatura; total cobrado mais claro que qualquer equivalente.
- Sem paywall automática em partida ou replay, sem trial fictício.
- Persistir grupo/configuração e proteger snapshot na expiração; aviso e fallback na próxima partida.
- Sandbox real: compra, cancelamento, Ask to Buy, falha, restore, reinstalação, troca de plano, renovação, expiração, grace period, reembolso e legado.
- Substituir preços ilustrativos/URLs legais, auditar lifetime e revisar as 23 categorias antes de publicar. Nada neste trabalho altera App Store Connect/RevenueCat reais.

### Ações em lote no sheet

Acima da lista: Select all e Clear. Para não assinante, rótulo Select all free e seleção exata das três gratuitas (não incluir extras legados automaticamente). Para assinante, Select all marca as 23. Não abrir paywall ao selecionar todas. Clear esvazia apenas o rascunho e desabilita Confirm; fechar preserva seleção já confirmada. Selecionar todas em outro idioma pede consentimento para inglês antes de incluir categorias premium. Confirm continua necessário.
