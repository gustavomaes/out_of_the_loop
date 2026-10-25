# Suslo — protótipo Coral Social

Protótipo navegável do PRD, com visual Coral Social (opção 2) e organização compacta da opção 1. Marca **Suslo**. Não modifica o app Flutter.

## Abrir localmente

Abra `index.html` no navegador, ou, a partir da raiz do repositório:

```sh
python3 -m http.server 8765 --bind 127.0.0.1 --directory prototypes/oddly
```

Acesse http://127.0.0.1:8765. Não exige npm, build, conta, internet ou dependência de CDN. Para encerrar o servidor, Ctrl+C no terminal. Manter a mesma origem/porta preserva o armazenamento do navegador; file:// pode ter comportamento de armazenamento diferente por navegador.

## Três áreas

- **Prototype:** app interativo e galeria de 22 telas/estados (S10–S14 aposentados; novos S22–S26). A galeria gera cenários de exemplo; não é navegação do produto final e substitui a rodada atual.
- **Flows:** mapa clicável dos fluxos Classic, configuração na home, compra, retomada e suporte.
- **Design system:** paleta, tipografia, componentes, estados, ícones, espaçamento, privacidade e acessibilidade.

## Interações implementadas

- Classic como único modo, 3–20 jogadores, nomes em bottom sheet e grupo salvo.
- Home com impostores em bottom sheet, hint e Troll em switches, timer on/off com duração em bottom sheet.
- Premium e Start game fixos sobre fundo transparente; conteúdo rola até o fim.
- Share e Rate us no final da home; feedback e avaliação nativa simulados.
- Troll propõe 15% de rodadas com todos impostores, desligado por padrão.
- Sheet de 23 categorias: 3 grátis (90 palavras traduzidas existentes) + 20 Premium (5 exemplos ingleses por tema, não catálogo final).
- Contagem automática/manual de impostores; sorteio com menor peso para os anteriores; iniciador pode ser qualquer jogador.
- Segurar para revelar; soltar, cancelar, sair da área ou perder foco oculta. Alternativa sem gesto disponível. O mesmo cartão serve para todos os papéis.
- Conversa presencial, timer opcional pausado ao perder foco, confirmação final e replay.
- Snapshot local; recarregue durante uma partida ou use “Simulate interruption”. Volta com segredos cobertos.
- Paywall anual/semanal; 20 categorias com os mesmos benefícios. Compra, restore, gestão e expiração simulados. Preços ilustrativos: US$19,99/ano ou US$4,99/semana, sem trial.
- Ajuda, configurações, reset de grupo/histórico, estados de erro e confirmação.

## Limites intencionais

Mockup para validar layout e fluxo, não aplicação pronta para distribuição. Interface em inglês americano; seletor de conteúdo usa os cinco idiomas do banco atual. Tradução completa da interface/RTL do app final continua prevista no PRD. As vinte categorias têm apenas exemplos funcionais; a expansão/revisão editorial ainda é necessária.

Preços são ilustrativos. Nenhuma conexão à Apple, RevenueCat, Firebase ou envio de e-mail. Restore verifica os direitos de demonstração deste navegador e não simula reinstalação de uma conta Apple. Pagamentos simulados podem ser apagados por “Reset demo”. Suporte real depende do endereço a confirmar.

Controles de som e música demonstram preferências salvas; não reproduzem faixas. Vibração do fim do timer depende do suporte do navegador. Segurança contra screenshots do sistema, persistência nativa, VoiceOver completo, Dynamic Type e transações sandbox devem ser validados na implementação Flutter. Dados locais não são criptografados neste mockup; não usar para informações sensíveis.

A página Design system distingue as medidas compactas do mockup das exigências de acessibilidade do produto final. Este protótipo não substitui a revisão cultural americana do conteúdo existente.

## Arquivos

- `index.html`: entrada local.
- `styles.css`: tokens e componentes responsivos.
- `app.js`: telas, navegação e máquina de estados.
- `content.js`: cópia estática do catálogo atual, para abrir sem servidor/fetch.
- `assets/`: fontes já utilizadas no projeto.
- `tokens.json`: tokens de handoff.
- `test.cjs`: verificações de lógica em Node, sem dependências e sem navegador.

## Validação

```sh
node --check prototypes/oddly/app.js
node prototypes/oddly/test.cjs
```

20 verificações de lógica: telas, fluxos, limites, privacidade, replay, retomada, idiomas, compras, snapshot, timer, Premium, migração, Troll e review. Validação visual complementar no navegador.

O fluxo solicitado de feedback negativo versus avaliação positiva está demonstrado, mas precisa de revisão antes da publicação: a Apple proíbe feedback filtrado. Consulte a seção de avaliação no PRD. HTML não abre StoreKit; nenhum review ou sugestão é enviado.

## V3 — assinatura e paywalls

Compra única/coleção substituídas por assinatura para novos clientes. Premium some com assinatura ativa, não com posse de três packs. Bloqueios abrem paywall; fechar retorna à seleção. Confirm aplica o rascunho. As três categorias grátis e todas as regras continuam ilimitadas. Direitos antigos preservados separadamente no modelo.

Entradas: categoria bloqueada, Premium na home, Explore Premium em Settings e convite secundário no resultado. Nenhum popup automático. Pesquisa e especificação: `docs/prd/monetizacao-e-paywalls.md`.

`subscription-catalog.js` compõe o catálogo v3 sobre a fonte histórica `content.js`. Previews: `preview-v3-categories.png` e `preview-v3-paywall.png`. Arquivos JS/CSS têm versão de cache na entrada HTML.

Refinamento da home: ícones decorativos em jogadores, categorias, impostores, dica, timer e Troll. How to play abre somente pelo ? do header em bottom sheet com seis passos e X para fechar; mantém estado da home.

## Suslo — direção 01 (25/10/2026)

Marca atualizada em todas as telas, paywall e compartilhamento. Home com cartas decorativas, tipografia reforçada e paleta Coral Social. Os tiles de regras (86 px mínimos, padding 20 px) e o botão Premium/dock permanecem iguais. Fluxos e chaves históricas `oddly-prototype-v*` preservados para manter sessões e compras simuladas. Arte: `assets/suslo-cards.png` (ImageGen), sem palavras ou identificação de papéis reais.
