> ARQUIVADO — versão 1, substituída pela versão Classic. Não usar para implementação atual. Links relativos deste snapshot referem-se à localização original.

# PRD — Reformulação do Out of the Loop para iOS / Estados Unidos

Data: 25/10/2026 · Versão: 1.0 · Responsável: desenvolvedor solo com apoio de IA.

Status: especificação para implementação; não representa funcionalidades já entregues. Nome comercial novo ainda depende de escolha e verificação de disponibilidade. Manter o app existente, seu identificador e direitos de compra.

## 1. Como usar este documento

Este é o documento principal de produto. A execução está detalhada no [plano de desenvolvimento](plano-de-desenvolvimento.md); textos, hipóteses e operação de aquisição estão no [plano de ASO](aso-e-lancamento.md).

- **Decisão**: requisito definido pelo proprietário durante a entrevista; não alterar silenciosamente.
- **Proposta**: solução recomendada neste PRD para preencher detalhes não definidos; pode ser ajustada com evidência, registrando a mudança.
- **Pendência**: informação ainda não disponível; possui ação e momento de resolução.
- **P0**: necessário para o lançamento; **P1**: evolução após validação; **P2**: expansão futura.

Os documentos antigos em `docs/` descrevem implementações anteriores. Este PRD prevalece quanto ao comportamento futuro; o código continua sendo a fonte sobre o que existe hoje. Não implementar todo o roadmap numa única alteração.

## 2. Objetivo, público e posicionamento

Transformar o aplicativo em uma opção fácil de encontrar e começar a jogar: um jogo presencial de impostor e palavras, em um único celular, para encontros de amigos nos Estados Unidos. Público principal: jovens adultos; conteúdo básico acessível também a adolescentes e famílias. Isso não significa direcionar o app à categoria infantil.

Proposta de valor: **“One secret word. Someone is bluffing. Start playing in seconds.”**

Prioridades: (1) começar rápido; (2) segredo protegido; (3) palavras reconhecíveis e variadas; (4) repetir sem reconfigurar; (5) página da loja compreensível; (6) venda de conteúdo relevante sem interromper o jogo.

O modo guiado é um diferencial opcional: oferece perguntas e competição para quem prefere estrutura. O produto não precisa reproduzir todos os recursos do concorrente para competir.

Problemas a investigar: baixa descoberta, baixa conversão da página e atrito antes da primeira partida. Há poucos downloads e nenhuma receita relatados pelo proprietário, mas não há dados organizados para atribuir causalidade. Redesign e keywords não garantem posição nem receita.

## 3. Decisões consolidadas

| Área | Decisão para a primeira versão |
| --- | --- |
| Plataforma | iOS, iPhone prioritário; iPad responsivo sem telas exclusivas; manter Flutter |
| Mercado | EUA; aquisição inicial somente pela App Store; sem anúncios pagos, creators ou plano de redes sociais obrigatório |
| Marca | Nome, ícone e visual podem mudar por completo; preferir “Imposter”, com identidade própria |
| Visual | Claro, minimalista, divertido; destaques vibrantes e hierarquia simples |
| Entrada | Abrir na configuração; sem home intermediária nem tutorial obrigatório |
| Modo padrão | Rápido/livre: 3–20 jogadores; discussão e votação fora do celular; sem placar nem adivinhação final |
| Modo alternativo | Guiado: 3–9 jogadores, perguntas, votação e pontuação gratuitas; regras podem ser simplificadas |
| Jogadores | Nomes opcionais, Player 1 etc.; reutilizar último grupo |
| Papéis | Múltiplos impostores no rápido, sugestão automática e ajuste; cada impostor conhece só o próprio papel |
| Sorteios | Reduzir repetições consecutivas sem tornar previsível; qualquer pessoa pode iniciar, inclusive impostores |
| Conteúdo | Mistura gratuita padrão; escolha opcional de uma ou várias categorias; ampliar inglês americano primeiro |
| Segredo | Segurar para ver, soltar para esconder; palavra e categoria para inocentes; dica de categoria opcional para impostores, desligada inicialmente |
| Tempo | Temporizador opcional e desligado inicialmente; duração ajustável |
| Encerramento | Confirmar antes de revelar todos os impostores e a palavra juntos |
| Repetição | Nova palavra e novo sorteio com um toque, mantendo grupo e configurações; ajustes como ação secundária |
| Interrupção | Retomar rodada, com segredos ocultos; alternativa de encerrar e iniciar outra |
| Áudio | Sons e vibrações discretos e desativáveis; sem diferenças entre papéis; música desligada por padrão |
| Idiomas | Interface em en, pt-BR, es, hi, ar; preservar catálogo atual fora do inglês |
| Monetização | Ambos os modos ilimitados e gratuitos; apenas conteúdo extra pago; compra única por pacote e combo; sem assinatura inicial |
| Loja interna | Exemplos antes da compra; sem rodada demo; pacotes ingleses visíveis em outros idiomas, claramente identificados e nunca misturados automaticamente |
| Migração | Preservar acesso equivalente de compradores e restauração, mesmo com renomeação de pacotes |
| Validação | Pessoas próximas no Brasil + IA; validação americana posterior sem bloquear lançamento |
| Feedback | E-mail nas configurações, iniciado pelo usuário |

## 4. Diagnóstico atual e evidência competitiva

### 4.1 Código existente

Entradas: `lib/src/app/app_routes.dart`, `app_router.dart`, `game_flow_controller.dart`.

Fluxo atual: onboarding → home → categoria → configuração → jogadores → papéis → preparação → perguntas/pistas → votação → resultado → eventual palpite → ranking.

Há modo guiado padrão, limite comum de 3–9 jogadores, seis categorias gratuitas/180 palavras, cinco idiomas e catálogo adicional americano de três pacotes/60 palavras. Os totais vêm da documentação técnica existente e devem ser recontados na auditoria da fase 0. RevenueCat, Firebase, histórico local e componentes de UI já existem. A persistência atual salva grupo/configurações/histórico, não um snapshot completo da rodada.

O modo livre atual ainda conduz turnos e usa votação/placar. Portanto, trocar apenas o layout ou a flag padrão não atende ao novo produto. `FreeClueScreen` também impede que o impostor comece: remover essa regra no novo rápido.

O modelo `RoundState` contém um único `outPlayerId`; será necessário representar vários impostores no rápido sem quebrar o guiado. A pontuação atual de 25/100/50/125 será substituída pela proposta mais simples da seção 8 somente nas partidas novas da reformulação.

### 4.2 Concorrente validado no ScreensDesign

App: Imposter Who? – Word Game, Sokak Technologies, Store ID 6746781192. Biblioteca 2516, gravação 3355, 47 telas registradas.

| Evidência registrada | Implicação para este produto |
| --- | --- |
| Configuração central com jogadores, categorias e impostores | Reduzir navegação obrigatória; concentrar decisões comuns |
| Revelação → conversa/temporizador → revelação final | O rápido deve apoiar a conversa presencial sem administrar cada fala |
| Dicas, múltiplos impostores, tempo opcional | Adotar somente controles úteis e progressivos, com bons padrões |
| Assinatura no onboarding | Não adotar: nossa decisão é entrada direta e compras de conteúdo |
| Online com link e uso de chamadas externas | Evolução futura; não anunciar multiplayer online no lançamento |

Fontes: [configuração gravada](https://screensdesign.com/apps/imposter-who-word-game/?vs=291010&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens), [rodada gravada](https://screensdesign.com/apps/imposter-who-word-game/?av=3355&flow=46089&ts=101.000&utm_source=screensdesign&utm_medium=mcp&utm_content=app_screens), [visão geral](https://screensdesign.com/apps/imposter-who-word-game/?utm_source=screensdesign&utm_medium=mcp&utm_content=app_detail).

A gravação não prova o funcionamento de todas as versões nem a causa do ranking. Valores de mercado do fornecedor são estimativas e não metas deste projeto. Os prints fornecidos são evidências históricas de palavras-chave, não uma pesquisa atual de volume.

### 4.3 Lacunas de diagnóstico

Coletar título, subtítulo, keywords, screenshots e métricas atuais no App Store Connect. A [página pública consultada](https://apps.apple.com/us/app/imposter-spy-out-of-the-loop/id6771190067) anuncia 20+ jogadores, divergindo do código atual; a nova versão deverá comunicar precisamente 3–20 no rápido e 3–9 no guiado. Não assumir que o código local é o binário publicado. Conferir versão/build enviado e funcionalidades realmente disponíveis.

## 5. Escopo e arquitetura de informação

P0 inclui os dois modos, redesign, catálogo, loja de pacotes, restauração, retomada, instrumentação, acessibilidade, localização, feedback e ASO. Loja fica acessível pela seleção de categorias e configurações, sem paywall de abertura ou pop-up comercial durante a partida.

Navegação principal: **configuração da partida** com seletor Quick / Guided, acesso a categorias, ajuda e configurações. Não há necessidade de barra inferior no P0. “Packs” é uma área secundária, não o destino padrão.

P1: expansão editorial, validação americana, refinamento iPad, teste de demonstração de pacotes, palavras próprias, pacotes adultos separados e Android. P2: online por link, assinatura somente com catálogo e cadência que justifiquem, aquisição paga após sinais de retenção/conversão. Não incluir login, chat, notificações, anúncios, ranking global ou conteúdo gerado em tempo real no P0.

## 6. Fluxos completos

### 6.1 Primeiro uso rápido

Abrir → configuração com Quick, 3 jogadores automáticos e mistura gratuita → Start game → Player 1 segura para ver → solta para ocultar → Next player → repetir → tela de conversa com jogador inicial → grupo discute e vota verbalmente → Reveal → confirmação → impostores + palavra → Play again.

Há um único CTA para iniciar usando os padrões. O processo de ver os papéis exige participação individual; não contabilizar esse tempo como configuração. Não solicitar review, compra ou permissões nessa entrada.

### 6.2 Personalização e repetição

Configuração → editar quantidade/nomes OU categorias OU opções → voltar ao mesmo formulário → iniciar. Seleção e grupo persistem. No resultado: Play again gera a próxima rodada diretamente; Edit game retorna à configuração; volta/fechar permite sair sem sorteio acidental.

### 6.3 Guiado

Configuração → Guided → grupo 3–9 + categorias + quantidade de rodadas → revelação privada → perguntas sequenciais → votação individual oculta → resultado e pontos → próxima rodada → ranking final → nova partida ou ajustes.

### 6.4 Compra

Categorias → Explore packs → detalhe do pacote (idioma, exemplos, conteúdo e preço) → compra nativa → confirmação de direito → retorno à seleção. Compra não inicia rodada nem altera seleção automaticamente. Falha/cancelamento mantém catálogo gratuito disponível.

### 6.5 Retomada

Abrir com snapshot válido → “Game in progress” → Resume ou End game. Resume retorna à fase persistida, com qualquer segredo oculto. End game pede confirmação, descarta só a rodada e retorna ao setup preservado. Não exibir nomes de impostores, palavra ou miniatura revelada nesse ponto.

## 7. Inventário de telas e estados

Os IDs são estáveis para tarefas, analytics e testes. Sheets/dialogs contam como superfícies; não criar rotas separadas sem necessidade.

| ID / superfície | Conteúdo e ações | Estados e critérios de aceite |
| --- | --- | --- |
| S00 Inicialização | Marca discreta enquanto carrega dados locais | Não bloquear por rede/analytics; erro local recuperável; ir a S01 ou S09 |
| S01 Configuração | Quick/Guided; quantidade; resumo de nomes; categorias; opções recolhidas; Start game; ajuda e ajustes | Quick inicial; 3 nomes automáticos; início sem cadastro; um CTA principal; campos inválidos explicados inline |
| S02 Jogadores | Contador e lista editável; adicionar/remover; Done | 3–20 rápido, 3–9 guiado; nomes em branco viram nomes automáticos; nomes duplicados diferenciados por número, com aviso; preservar IDs na edição |
| S03 Categorias | Mistura padrão; multisseleção; idioma de conteúdo; grátis/adquirido/bloqueado; Explore packs | Nenhuma seleção: orientar e impedir iniciar; itens pagos levam a detalhe, nunca selecionam sem direito; categorias inglesas separadas |
| S04 Opções rápidas | Impostores Auto/manual; dica; tempo e duração | Auto visível com quantidade resultante; dica/tempo inicialmente off; não mostrar perguntas/pontuação aqui |
| S05 Revelação privada | Nome/posição; cartão coberto; Hold to reveal; instrução de passar; Next player | Segurar revela papel; soltar, cancelar gesto, perder foco ou pausar oculta; Next só habilita após revelar e soltar; identidade visual/efeito idênticos entre papéis |
| S06 Conversa rápida | Quem começa; instrução para pistas e voto verbal; timer se ativo; Reveal; sair | Nenhum turno obrigatório no app; nenhum voto digital; término do tempo não revela segredo automaticamente |
| S07 Confirmar revelação | Aviso de encerramento da rodada; Cancel / Reveal | Cancel retorna sem alterar tempo/papéis; confirmação única evita toques duplicados |
| S08 Resultado rápido | Todos os impostores; palavra + categoria; Play again; Edit game | Sem vencedores inventados ou placar; nomes longos e 6 impostores cabem; nova rodada não reutiliza a palavra anterior se houver alternativa |
| S09 Retomar | “Game in progress”; Resume; End game | Sem segredo na prévia; valida snapshot; fechamento exige confirmação; dados incompatíveis têm recuperação legível |
| S10 Configuração guiada | Dentro de S01: explicação breve; grupo; categorias; 1–5 rodadas | Um impostor; proposta: 3 rodadas padrão e perguntas por jogador automáticas; mudança de modo preserva configurações separadas |
| S11 Perguntas guiadas | Jogador atual; pergunta; progresso; Next | Não contém palavra/papel; ordem sorteada entre todos; retomar no turno salvo; ajuda acessível sem reset |
| S12 Votação guiada | Passar para eleitor; candidatos; seleção; Confirm vote | Um voto por eleitor; sem autovoto; seleções anteriores ocultas; retomar voto ainda não confirmado; não mostrar contagens parciais |
| S13 Resultado guiado | Impostor; palavra; resultado coletivo; pontos individuais; Next round | Resolver exatamente uma vez; explicar pontos em linguagem simples; última rodada direciona a ranking |
| S14 Ranking final | Ordem por pontos; empates explícitos; Play again / Edit game | Empates compartilham colocação; nova partida zera pontos; nenhum placar no rápido |
| S15 Como jogar | Abas Quick/Guided; exemplo fictício curto; regras e limites | Acessível do setup e jogo; preservar estado; não revelar palavra real da rodada |
| S16 Catálogo de pacotes | Cards por tema, idioma e conteúdo; combo; Restore purchases | Loading, disponível, owned, indisponível/offline; preços da loja; não impedir retorno ao jogo |
| S17 Detalhe de pacote/combo | Proposta, quantidade real, exemplos, idioma, compra única, preço; comprar/restaurar | Exemplos fora da amostragem inicial do pacote para evitar spoiler; aviso de inglês em todos os idiomas; sem promessa de conteúdo futuro |
| S18 Estado de compra | Sheet nativo e retorno com confirmação/erro | Sucesso, cancelado, pendente, falhou, já adquirido; bloquear compras simultâneas; não conceder acesso só pelo clique |
| S19 Configurações | Idioma, sons, vibração, música se mantida, feedback, restaurar, privacidade, termos, versão, limpar histórico/esquecer grupo | Mudanças persistem; ações destrutivas confirmadas; música inicia off; falha ao abrir e-mail oferece copiar endereço |
| S20 Confirmações de saída/reset | Sair da rodada, esquecer grupo, apagar histórico | Descrever o que será apagado; compras nunca são apagadas por reset de preferências |
| S21 Falha recuperável | Conteúdo ausente, snapshot inválido, gravação local falhou | Mensagem curta com tentar de novo/voltar; não fabricar palavra ou direito pago; nenhum segredo exposto |

Transições: S05 do último jogador → S06 rápido ou S11 guiado; não inserir tela obrigatória “pronto” adicional. Em VoiceOver, oferecer ação equivalente acessível para revelar/ocultar, com orientação privada; nunca tornar o segredo automaticamente focável quando coberto.

## 8. Regras e critérios funcionais

### R01 Configuração e defaults

Quick é o padrão na primeira abertura e ao voltar à tela principal sem partida ativa. A preferência de parâmetros de cada modo é salva separadamente; retomar guiado não muda seu modo. Proposta: lembrar o último grupo, mas exigir seleção explícita de Guided para partidas novas. Migrar o antigo default guided sem sobrepor uma partida em andamento.

Ao mudar de rápido com mais de 9 pessoas para guiado, pedir seleção de 3–9 participantes; não apagar nem cortar silenciosamente o grupo rápido. Mudar idioma de interface não muda palavra nem idioma de uma rodada ativa.

### R02 Quantidade de impostores — proposta inicial

| Jogadores | Sugestão Auto | Máximo manual |
| --- | --- | --- |
| 3–5 | 1 | floor((N−1)/2), mínimo 1 |
| 6–9 | 2 | floor((N−1)/2) |
| 10–14 | 3 | floor((N−1)/2) |
| 15–20 | 4 | min(6, floor((N−1)/2)) |

Mínimo manual 1. O teto mantém impostores em minoria, com limite de seis para legibilidade. Auto recalcula ao mudar N; manual conserva valor se válido e avisa ao reduzi-lo. Guiado permanece com um impostor. Testar limites 3/5/6/9/10/14/15/20 e todas as transições.

### R03 Sorteio e sigilo

Proposta: amostragem ponderada sem reposição; peso 1 para quem não foi impostor na rodada anterior e 0,5 para quem foi. Todos mantêm chance positiva, não há rotação obrigatória nem promessa de troca de papel para cada pessoa. Histórico ligado a IDs locais; novos jogadores começam com peso 1. Não exibir pesos ou histórico de papéis.

Sortear iniciador uniformemente entre todos, independentemente do papel. Os inocentes veem palavra e categoria; impostores veem apenas seu papel e, se ativada, categoria. Nunca mostrar outros impostores durante revelação. Mesmos sons, vibrações, durações, tamanho de cartão e cor externa para todos. Não gravar segredos em logs, analytics ou relatório automático de erro.

### R04 Seleção de palavras

Mistura inicial contém apenas categorias gratuitas gerais do idioma de conteúdo. Pacotes adquiridos não entram automaticamente. Proposta: escolher categoria elegível com peso igual, depois palavra pouco recente; evitar repetição dentro da sessão até esgotar o conjunto. Deduplicar por ID e texto normalizado entre pacotes.

Se o conjunto acabar, avisar discretamente e reciclar as menos recentes; nunca bloquear partidas gratuitas por limite artificial. Se restar uma única palavra, orientar a adicionar categorias e permitir continuar com repetição explícita. Exemplos da loja são excluídos das primeiras cinco rodadas do pacote, quando houver conteúdo suficiente.

Cada rodada usa um único idioma. Selecionar pacote inglês com catálogo de outro idioma apresenta confirmação para trocar o idioma de conteúdo e limpa seleções incompatíveis, preservando-as como preferência do idioma anterior. A interface pode continuar em português, espanhol, hindi ou árabe.

### R05 Revelação e passagem

Somente a área do cartão aceita o gesto; proposta de atraso inicial 150–250 ms, ajustado em teste. Soltar fora do cartão e pointer-cancel ocultam também. Ao avançar, novo cartão nasce coberto; impedir que um dedo ainda pressionado revele o próximo. Não permitir voltar ao papel anterior. Para rever o próprio papel antes de avançar, segurar novamente.

Cobrir conteúdo na transição para background/app switcher. O requisito reduz exposição acidental; não prometer impedir fotografias ou screenshots do sistema. Ao retomar, papel oculto e timer em estado definido em R06.

### R06 Temporizador e encerramento rápido

Proposta: durações de 1–10 minutos em passos de um; seleção inicial de 3 minutos quando ativado. Inicia após a última revelação. Pausar/retomar disponíveis. Ao entrar em background, pausa automaticamente e persiste tempo restante; ao retornar continua pausado até ação explícita. Relógio monotônico durante foreground evita saltos por mudança do relógio do aparelho.

Ao zerar, som/vibração conforme preferências, texto “Time’s up — vote together”; discussão pode continuar. Somente confirmação do usuário revela. Sem cronômetro, S06 funciona indefinidamente. Reveal conclui a rodada sem declarar vencedor, pois o app não conhece o voto presencial.

### R07 Nova rodada e grupos

Play again guarda a rodada concluída e cria outra de forma atômica, com novos sorteios; duplo toque não cria duas. Preservar grupo, categorias, idioma de conteúdo, dica e tempo. Palavra diferente se houver alternativa; “novos impostores” significa novo sorteio, não proibição de repetição individual. Edit game não inicia sorteio.

### R08 Guiado simplificado — proposta

Manter perguntas e competição, remover o palpite final e reduzir escala de pontos. Um impostor, 3–9 jogadores e 1–5 rodadas, padrão 3. Perguntas automáticas: duas por pessoa para 3–4 participantes e uma para 5–9, somente se o banco tiver capacidade; explicar no resumo. Cada palavra elegível exige perguntas únicas suficientes.

Todos votam uma vez, sem autovoto. Impostor é encontrado se receber mais de metade dos votos de todos os participantes. Empate ou pluralidade sem maioria absoluta significa que escapou. Cada inocente que acerta recebe 1 ponto; se a maioria encontra o impostor, todos os inocentes recebem mais 1; se escapa, impostor recebe 2. Impostor encontrado recebe 0. Máximo individual por rodada: 2. Exemplo N=5: três votos no impostor o encontram; dois votos não bastam.

Antes da partida, resumo de três regras; resultado mostra motivos dos pontos. Ranking permite empate. Testar empate, voto incorreto, maioria exata, maioria insuficiente e retomada sem pontuar duas vezes. Essa proposta altera a regra antiga e deverá ser validada em teste de compreensão; não mantê-la escondida apenas no código.

### R09 Persistência e migração

Salvar snapshot versionado em cada transição confirmada: modo, grupo/IDs, configurações, idioma/content version, palavra e papéis locais, fase, jogador/turno, votos confirmados, placar, tempo restante e ID de resolução. Estado visual revelado nunca é restaurado. Concluir escrita antes de confirmar avanço; em falha permitir tentar novamente ou continuar com aviso explícito de que a retomada pode perder o último passo.

Snapshot deve sobreviver a encerramento do processo e funcionar offline. Guardar dados somente no aparelho, em armazenamento privado da aplicação; não sincronizar nomes ou segredos. Manter uma versão anterior válida para recuperar escrita incompleta. Ao atualizar catálogo, resolver por IDs estáveis ou dados necessários do snapshot; se incompatível, explicar e oferecer nova partida sem afetar compras.

Migrar `game.session.v1` preservando nomes e histórico; não transformar um flag local em direito pago. Não migrar partida antiga guiada pela nova regra de pontuação sem esquema compatível: finalizar no esquema antigo se suportado ou oferecer reinício explicado. Persistência de grupo rápido deve aceitar 20 pessoas, sem o truncamento atual em 9.

## 9. Conteúdo editorial

### 9.1 Catálogo gratuito americano — proposta

Meta P0: **240 palavras inglesas revisadas**, seis categorias com 40 cada. Reutilizar palavras boas existentes; quantidade não substitui qualidade. Se revisão exigir mais tempo, lançar com pelo menos as 180 atuais revisadas e informar apenas o total real. Não reduzir o acervo dos outros idiomas para igualar contagens.

| Categoria | Exemplos propostos | Critério |
| --- | --- | --- |
| Food & Drinks | popcorn, taco, pancake, lemonade | Cotidiano reconhecível, sem foco em álcool |
| Everyday Things | backpack, headphones, umbrella, toothbrush | Objetos concretos e bons para pistas |
| Animals & Nature | raccoon, dolphin, cactus, thunderstorm | Variedade sem termos científicos obscuros |
| Places & Outings | movie theater, airport, bowling alley, beach | Contextos comuns nos EUA |
| Sports & Hobbies | basketball, camping, karaoke, skateboarding | Não depender só de uma liga ou geração |
| Movies & Pop Culture | superhero, sitcom, red carpet, game show | Começar por conceitos amplos; nomes próprios só após revisão |

Conteúdo em inglês americano: movie theater, soccer etc. Evitar dependência excessiva de celebridades passageiras, respostas ambíguas, palavras muito parecidas no mesmo conjunto e referências que exijam um estado específico. Não usar imagens/logos de marcas sem necessidade. Palavras não devem carregar promessas de parceria.

### 9.2 Pacotes pagos e migração — proposta

Preservar os três direitos existentes e ampliar valor, em vez de criar vários SKUs novos de imediato.

| Direito existente | Nome comercial proposto | Diferencial / meta editorial |
| --- | --- | --- |
| us_backyard | Backyard & BBQ | Encontros, churrasco, jogos ao ar livre; 60 palavras revisadas |
| us_roadtrip | Road Trip USA | Estrada, paradas, viagens e pontos reconhecíveis; 60 palavras |
| us_holidays | Holiday Hangouts | Tradições e festas americanas, sem pressupor religião única; 60 palavras |
| game_night_collection | Game Night Collection | Os três pacotes explicitamente listados; sem promessa de todos os futuros |

Os direitos e product IDs não mudam apenas porque o rótulo mudou. Auditar SKU legado `otl_pro_lifetime` e seus compradores antes de qualquer remoção ou reinterpretação; conservar no mínimo o acesso originalmente vendido. Se os pacotes não atingirem revisão suficiente, manter o conteúdo equivalente atual e adiar expansão, sem fazer marketing do total proposto.

### 9.3 Processo editorial solo + IA

1. Inventariar IDs, traduções, categorias, duplicatas, exemplos e direitos.
2. IA propõe lotes de 20 palavras; proprietário revisa cada palavra antes de entrar no catálogo.
3. Gerar/revisar nove perguntas distintas por palavra elegível no guiado; perguntas não contêm a resposta nem a tornam óbvia.
4. Validar IDs únicos, campos obrigatórios, idioma, duplicatas normalizadas, capacidade do guiado e vazamento literal; depois revisar semântica manualmente.
5. Embaralhar amostra e testar se as pessoas conseguem dar pistas; registrar termos desconhecidos e perguntas que entregam a palavra.
6. Versionar conteúdo e documentar exclusões. Tradução de interface passa por revisão de comprimento, variáveis, pluralização e RTL; IA não certifica naturalidade cultural.

Pacotes adultos, palavras próprias e demos ficam fora do P0. Nenhum conteúdo adulto deve aparecer na mistura geral, screenshots iniciais ou exemplos gratuitos.

## 10. Design e acessibilidade

Proposta visual: fundo off-white, texto quase preto, cartões brancos com bordas leves; azul-cobalto para ação principal, coral e amarelo para detalhes. Exemplos de tokens exploratórios: fundo #F7F8FC, texto #172033, primária #3154D5, acento #FF806A. Validar contraste antes de fixar tokens; amarelo/coral não recebem texto branco por padrão.

Identidade do ícone: símbolo simples de dois balões/cartões, um com um detalhe ausente; sem reproduzir o quadrado verde e tipografia do concorrente. Evitar nome inteiro dentro do ícone. Produzir duas propostas e avaliar reconhecimento em tamanho pequeno; nenhuma imagem está sendo produzida por este PRD.

Usar fontes já empacotadas e reduzir variedade: uma família principal com pesos distintos. Grid de 8, padding base 16–24, cantos moderados e um CTA dominante por tela. Cores de papel só podem aparecer no conteúdo privado; preferir mesmo tratamento visual para evitar pistas laterais. Nome/palavra têm precedência sobre ilustração.

Critérios: alvos de toque mínimos de 44×44 pontos lógicos; textos escaláveis até 200% sem cortar ações; contraste WCAG AA como referência; VoiceOver com ordem e rótulos; não depender de cor, gesto longo ou som como único canal. Respeitar movimento reduzido; animações de transição curtas, sem confete obrigatório. Interface árabe em RTL; números, nomes e palavras inglesas em direção apropriada.

iPad: largura de leitura limitada, modal adaptado, nenhuma informação secreta aparecendo em painel lateral. Testar iPhone pequeno, padrão, grande, iPad e rotação; preservar fluxo ao mudar orientação. Botões essenciais permanecem acessíveis com teclado e safe area.

## 11. Monetização e experiência comercial

Decisão: não cobrar por partidas, jogadores, modo guiado, votação, placar ou retomada. Não usar anúncios ou interrupções comerciais como alternativa de receita no P0. Oferta aparece por intenção do usuário na área de conteúdo.

| Modelo | Avaliação | Decisão |
| --- | --- | --- |
| Compra por pacote | Valor temático claro; menor compromisso; receita depende de variedade | P0 |
| Combo de pacotes conhecidos | Maior cesta e desconto verificável | P0 |
| Compra única de tudo, inclusive futuro | Fácil de explicar, mas obrigação editorial indefinida | Não usar essa promessa |
| Assinatura | Exige valor recorrente e cadência que o projeto ainda não tem | Avaliar somente no futuro |
| Anúncios/limite de partidas | Contraria a experiência acordada | Fora do escopo |

Hipótese inicial EUA: US$1,99 por pacote e US$3,99 pelo combo dos três, alinhada ao setup documentado, sujeita a confirmação no App Store Connect. Exibir sempre preço retornado pela loja. O desconto do combo só é anunciado quando calculado dos preços realmente disponíveis; nunca hardcoded em todos os países.

Sem upgrade proporcional automático no P0. Se a pessoa já possui pacotes, mostrar quais estão inclusos e quanto custam os que faltam; não destacar combo se custar mais do que comprar os restantes. Se possui os três, considerar coleção completa e remover CTA redundante. Não criar assinatura sob IDs de não consumíveis.

Restaurar em loja e configurações, explicar conta Apple e necessidade de conexão. Tratar cancelamento sem mensagem alarmante; pendente não concede acesso; erro oferece tentar novamente; compra confirmada atualiza biblioteca. Conteúdo comprado funciona offline quando o direito estiver confirmado/cacheado. Reembolso/revogação afeta novas partidas; uma rodada já iniciada pode terminar. Não afirmar que a restauração foi testada antes do sandbox real. A Apple exige mecanismo de restauração para compras restauráveis: [referência](https://developer.apple.com/in-app-purchase/).

## 12. Métricas, instrumentação e diagnóstico

Objetivo principal inicial: aumentar o número semanal de aparelhos nos EUA que começam e concluem pelo menos uma rodada. Um aparelho representa um grupo anfitrião, não a quantidade de pessoas que jogaram. Não multiplicar instalações pelo número de jogadores como se fossem usuários adquiridos.

| Métrica | Definição operacional | Fonte / frequência |
| --- | --- | --- |
| Descoberta | Impressões únicas e downloads iniciais por território e origem Search/Browse | App Store Connect, semanal |
| Conversão da loja | Métrica oficial exportada, com definição e filtros registrados; não confundir impressões com visitas da página | App Store Connect, semanal |
| Ativação | Aparelhos com primeiro round_started / aparelhos com first_open na coorte | Firebase/GA4, semanal |
| Tempo de configuração | Mediana e P75 entre setup_viewed e round_started, separado primeiro uso/retorno | Eventos, semanal |
| Tempo até conversa | Intervalo de round_started até discussion_started, por tamanho do grupo | Eventos, semanal |
| Conclusão rápida | round_revealed / discussion_started por IDs de rodada | Eventos, semanal; proxy, não prova de diversão ou voto |
| Repetição | Sessões com ao menos duas rodadas iniciadas / sessões com uma concluída | Eventos, semanal |
| Retenção | Coortes D7/D30 e retorno em até 7/30 dias, reportados separadamente | Firebase, mensal; somente coortes maduras |
| Oferta | pack_detail_viewed → purchase_started → entitlement_confirmed | Eventos + RevenueCat |
| Receita | Receita líquida, compradores e reembolsos por país/produto; reconciliar com loja | RevenueCat e relatórios Apple |
| Qualidade | Crash-free users, falhas de retomada, falhas de compra e relatos de segredo exposto | Crashlytics/feedback, por release |

As [definições oficiais de métricas Apple](https://developer.apple.com/help/app-store-connect-analytics/reference/metrics-definitions/) devem acompanhar os exports; não reconstruir uma “conversão” misturando universos de pessoas e downloads. Storefront, idioma, moeda e país de uso são dimensões diferentes. Não atribuir keyword individual a uma instalação sem dado que permita isso.

### 12.1 Contrato mínimo de eventos

| Evento | Quando emitir | Parâmetros permitidos |
| --- | --- | --- |
| setup_viewed | Ao entrar no setup, não a cada rebuild | entry_point, first_use, mode |
| mode_selected | Alteração explícita | mode |
| round_started | Snapshot inicial confirmado | round_id, session_id, mode, player_count, imposter_count, content_language, content_version, category_count, hint_enabled, timer_enabled |
| roles_completed | Último jogador terminou | round_id, duration_ms |
| discussion_started | Entrada no rápido após papéis | round_id, starter_randomized=true |
| round_revealed | Confirmação da revelação final | round_id, elapsed_ms |
| round_abandoned | Encerrar explicitamente | round_id, phase; ausência de evento não prova abandono |
| round_resumed | Retomada efetiva | round_id, phase |
| rematch_started | Nova rodada pelo resultado | previous_round_id, round_id, mode |
| guided_round_completed | Resultado aplicado uma vez | round_id, majority_found; sem candidatos/votos individuais |
| pack_detail_viewed | Detalhe exibido | pack_id, content_language, owned |
| pack_purchase_* | Started/completed/pending/cancelled/failed | pack_id, erro normalizado; manter nomes existentes quando possível |
| restore_completed | Restauração termina | result, entitlement_count |
| feedback_opened | Abre compositor por ação explícita | app_version; não registrar corpo do e-mail |

IDs de rodada/sessão aleatórios locais, sem nome/papel/palavra; não usar como dimensão de alta cardinalidade em relatórios agregados. Deduplicar conclusão/purchase, inclusive ao retomar. Não duplicar evento padrão de receita com evento customizado. Eventos de duração excluem background no tempo ativo. Reusar eventos existentes ou mapear versão antiga/nova antes de trocar nomes.

### 12.2 Metas e rotina

Metas de usabilidade propostas: 4 de 5 anfitriões iniciam sem ajuda; mediana de configuração ≤20s com defaults e ≤10s no retorno; zero exposição involuntária observada; 4 de 5 repetem sem explicação. São gates de pesquisa local, não benchmarks americanos.

Primeiros 14 dias: validar coleta e construir baseline. Revisões em D7, D14 e D30: qualidade → descoberta → ativação → repetição → receita. Não impor meta de receita nem ranking sem base. Se menos de 100 first_opens por coorte, mostrar contagens e tratar percentuais como exploratórios, sem declarar vitória estatística. Esse número é regra de comunicação, não cálculo de poder estatístico.

Se impressões não crescem, revisar relevância e cobertura ASO; se impressões crescem e downloads não, revisar criativos/proposta; se download cresce mas ativação não, observar setup; se repetição cai, revisar palavras, sigilo e duração; se há uso e nenhum acesso à loja, revisar descobribilidade dos pacotes. Não forçar paywall para compensar aquisição fraca.

## 13. Validação com usuários

Plano inicial: duas sessões com grupos de 3–6 pessoas próximas no Brasil; cinco anfitriões no total, alternando quem configura. Não substituir americanos por essas pessoas nas conclusões culturais. IA ajuda a revisar textos e preparar tarefas, não conta como participante.

Roteiro sem ensinar: (1) “Comecem uma rodada”; (2) adicionar jogador e selecionar duas categorias; (3) descobrir papel e passar; (4) discutir e revelar; (5) jogar novamente; (6) interromper e retomar; (7) encontrar o conteúdo de um pacote e explicar o que seria comprado; (8) experimentar guiado e explicar pontos. Testar inglês com quem entende e interface portuguesa para isolar usabilidade.

Registrar tempo, ajuda, toques errados, interpretação do papel, vazamentos, palavras desconhecidas e perguntas de pontuação. Perguntar o que esperavam antes de explicar. Consentimento simples para observação; não gravar por padrão. Corrigir bloqueios, repetir tarefas afetadas e salvar achados numa tabela problema/evidência/gravidade/ação.

Validação futura: recrutar 5–8 anfitriões nos EUA quando viável, incluindo grupos com diferentes repertórios; revisar termos, atratividade de temas, preço e texto da loja. Não bloquear P0 por ausência desse recrutamento, mas manter risco cultural explícito.

## 14. Requisitos técnicos, privacidade e operação

Reaproveitar camadas UI/domínio/dados. Introduzir modelos distintos ou união explícita para QuickRound e GuidedRound; evitar adaptar toda pontuação a múltiplos impostores desnecessariamente. Reusar geração de conteúdo/histórico e gateway de compras. Remover dependência do rápido em perguntas prontas; guiado filtra capacidade.

Serviços previstos: configuração por modo; seleção multicategoria; sorteio de papéis; persistência versionada; timer; compra; analytics. Nenhum backend novo é necessário no P0. Catálogo embutido e gameplay offline após instalação. Compras/restauração exigem conexão quando não houver estado cacheado suficiente; indisponibilidade de analytics não bloqueia o jogo.

Meta técnica proposta: setup interativo em até 2s em build release no aparelho de referência escolhido na fase 0; gesto de revelar sem travamento perceptível; nenhum bloqueio de UI por parsing/compra. Medir antes de declarar cumprimento.

Auditar declarações de privacidade e SDKs Firebase/RevenueCat contra comportamento real: a página pública consultada dizia não coletar dados, o que precisa ser reconciliado com a instrumentação. Não transportar consentimento de uma finalidade para outra. Não introduzir tracking publicitário ou ATT sem necessidade real. Política, contato e suporte devem corresponder à nova marca e ao vendedor existente. Preencher classificação etária com conteúdo efetivo, sem prometer faixa antes do questionário.

Review: solicitar avaliação nativa em momento após uso significativo, nunca em troca de conteúdo. Proposta: após pelo menos cinco rodadas concluídas e duas sessões, na volta ao setup; cooldown local de 120 dias por tentativa. Sistema decide se mostra; não afirmar que o usuário avaliou só porque a API foi chamada. Substituir o pré-dialog atual por pedido nativo sem filtro por satisfação. [Orientação Apple](https://developer.apple.com/app-store/ratings-and-reviews/) e [diretrizes](https://developer.apple.com/app-store/review/guidelines/).

Feedback: endereço de suporte confirmado antes de publicar; e-mail com assunto marca/versão e corpo editável vazio ou instrução curta. Não anexar nomes, papéis ou logs automaticamente.

## 15. Riscos e pendências

| Item | Tratamento | Momento |
| --- | --- | --- |
| Sem metadados/métricas atuais | Exportar snapshots de loja e período disponível, sem bloquear desenvolvimento offline | Fase 0 / antes de mudança ASO |
| Disponibilidade do novo nome | Buscar App Store e verificar conflitos antes de produzir marca final | Fase 0 |
| Compras antigas e lifetime | Inventariar direitos e testar matriz de equivalência | Antes de merge comercial |
| Conteúdo americano sem revisor nativo | Revisão humana apoiada por IA + validação futura; não alegar validação cultural concluída | Editorial/P1 |
| Retomada revela papel ou duplica pontos | Snapshot versionado e testes de lifecycle/process death | Gate P0 |
| Pouco tráfego | Medir contagens; evitar A/B inconclusivo e mudanças simultâneas sucessivas | Pós-lançamento |
| Expansão editorial grande para uma pessoa | Preservar mínimo revisado, adiar volume adicional, comunicar contagem real | Fase editorial |
| Estado da compra/sandbox desconhecido | Executar compra, restauração, cancelamento, pendência e offline em dispositivo | Gate de publicação |
| E-mail e políticas da nova marca | Confirmar destino funcional e atualizar conteúdo | Antes de submissão |

## 16. Critérios globais de conclusão

- [ ] Todos os requisitos P0 e gates do plano atendidos, com evidência por tarefa.
- [ ] Rápido inicia com um CTA usando defaults; 3 e 20 jogadores testados.
- [ ] Nenhuma etapa de pergunta, voto digital, placar ou palpite final no rápido.
- [ ] Papéis protegidos ao soltar, passar, interromper e retomar; iniciador pode ser impostor.
- [ ] Guiado 3–9 com regras legíveis, empate correto e resolução idempotente.
- [ ] Ambos os modos ilimitados e gratuitos, sem anúncio/paywall durante o jogo.
- [ ] Compras/restauração e direitos antigos validados; combo não induz recompra desvantajosa.
- [ ] Cinco idiomas funcionais, RTL e acessibilidade verificados; inglês não entra em mistura estrangeira sem escolha.
- [ ] Catálogo auditado; contagens de loja correspondem ao binário.
- [ ] Eventos validados, baseline registrada e privacidade reconciliada.
- [ ] App Store US recebe assets/textos finais consistentes; dados de disponibilidade do nome resolvidos.
- [ ] Testes locais de usabilidade documentados; sem defeitos críticos abertos de sigilo, perda de compra ou fluxo.

## 17. Referências e rastreabilidade

Pesquisa e entrevista: esta conversa, prints fornecidos e `.notebook/competitive-discovery.md`. Fontes externas consultadas em 25/10/2026; gravações e páginas podem refletir versões anteriores.

Código: `lib/src/domain/models/game_models.dart`, `domain/services/vote_scoring_service.dart`, `match_setup_service.dart`, `match_progression_service.dart`; `data/session/session_repository.dart`; `data/content/us_pack_catalog.dart`; `features/game/free_clue_screen.dart`; `domain/services/app_review_prompt.dart`.

Documentação anterior: [fluxo](../../.notebook/flutter-game-flow.md), [monetização existente](../us-release-and-monetization.md), [auditoria editorial](../content-audit-2026-10-20.md), [sandbox](../sandbox-setup-status.md). Revalidar instruções antigas antes de usá-las em release.
