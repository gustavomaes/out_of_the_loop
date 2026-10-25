> ARQUIVADO — versão 1, substituída pela versão Classic. Não usar para implementação atual. Links relativos deste snapshot referem-se à localização original.

# ASO e lançamento — App Store dos Estados Unidos

Parte do [PRD principal](PRD-reformulacao-ios-us.md). Data: 25/10/2026. Textos abaixo são rascunhos implementáveis, não metadados já publicados. Não há promessa de ranking.

## 1. Estratégia

Concentrar aquisição orgânica na App Store. A página deve explicar imediatamente a mecânica: um telefone, uma palavra, impostores, amigos. Comunicar gratuidade das partidas e diferenciar os pacotes extras. Não depender do conhecimento da marca antiga nem reproduzir a marca concorrente.

Ordem de trabalho: validar relevância dos termos → escolher nome próprio disponível → produzir ícone e screenshots reais → registrar baseline → publicar → acompanhar descoberta e uso → experimentar uma alteração por vez. A coleta de keywords atuais continua pendente; não inventar o campo oculto a partir da descrição pública.

## 2. Nome e identidade — opções propostas

| Candidato de título | Caracteres | Clareza / diferenciação | Risco a verificar |
| --- | --- | --- | --- |
| Imposter Word Party: Oddly | 26 | Mecânica primeiro, marca curta ao final; recomendação provisória | “Oddly” precisa de busca de disponibilidade e conflitos |
| Oddly: Imposter Party Game | 26 | Marca primeiro, leitura mais própria | Menos explícito sobre palavras |
| Imposter: Bluff & Words | 23 | Descreve blefe e palavras | Mais genérico, marca menos memorável |
| Imposter: Secret Word Party | 27 | Proposta direta | Pouca distinção verbal em busca competitiva |

Recomendação provisória: **Oddly** como marca visual e **Imposter Word Party: Oddly** como título US. Não tratar como nome aprovado ou disponível. Antes de fixar: busca exata e por similares na App Store americana, verificação básica de conflitos comerciais e conferência de disponibilidade no App Store Connect. Se indisponível, gerar nova marca mantendo descrição clara; não acrescentar “Who?” para se aproximar do concorrente.

Na primeira atualização, “Previously Out of the Loop” pode aparecer no texto de novidades ou ajuda por uma versão; não consumir o título principal com duas marcas. Manter mesmo Store ID/bundle ID para atualizar a base instalada. Não reiniciar avaliações deliberadamente no rebrand sem motivo documentado.

## 3. Hipóteses de palavras-chave

Os prints fornecidos apresentam posições e índices de uma ferramenta em um recorte específico. Os índices não são volume absoluto e não provam que o mesmo termo trará usuários para este app. Não há ranking próprio validado nesta entrega.

| Grupo | Termos candidatos | Tratamento |
| --- | --- | --- |
| Intenção principal | imposter word game, imposter game, imposter party game | Cobrir conceito em título/subtítulo; medir alcance |
| Variação ortográfica | impostor, imposter | Considerar as duas grafias sem repetir tokens desnecessários |
| Mecânica | secret word, bluff, liar, guessing, social deduction | Relevância alta; testar cobertura e conversão |
| Contexto | party, friends, offline, group, game night | Apoiam promessa de uso presencial |
| Adjacentes | spy, undercover | Validar intenção real e conflitos; não usar marcas de terceiros como atalho |
| Excluídos no P0 | online, multiplayer online, chat, adult | Funcionalidade ausente ou conteúdo não lançado |
| Não usar como marca emprestada | Imposter Who?, nomes completos de concorrentes | Evitar confusão de identidade e metadata enganosa |

Backlog de pesquisa: 15–25 consultas, país US, data, posição do app se encontrado, relevância, índice da ferramenta quando disponível, concorrentes e intenção observada. Se não houver ferramenta de ASO, documentar amostras manuais sem tratá-las como posição universal; resultados podem variar. Não instalar serviço pago como pré-condição.

## 4. Metadados US — conjunto A proposto

Os limites de nome/subtítulo, keywords e texto promocional devem ser conferidos no formulário antes do envio. Referências: [informações do app](https://developer.apple.com/help/app-store-connect/reference/app-information/app-information) e [página de produto](https://developer.apple.com/app-store/product-page/). Nome e subtítulo têm até 30 caracteres; o conjunto ASCII abaixo mantém keywords abaixo de 100 caracteres/bytes e promocional abaixo de 170. Sem nomes de concorrentes nem repetição de tokens já usados no conjunto.

**Título — 26 caracteres:**

```text
Imposter Word Party: Oddly
```

**Subtítulo — 28 caracteres:**

```text
Find the Liar. Play Offline.
```

**Keywords — 73 caracteres; rascunho a validar por relevância/loja:**

```text
impostor,bluff,secret,guessing,friends,group,deduction,hidden,roles,clues
```

Não preencher espaço apenas para atingir 100. “Game” é omitido como termo genérico da categoria; “spy/undercover” permanecem pesquisa, não obrigação de uso. Substituir termos conforme evidência em vez de empilhar sinônimos.

**Texto promocional — 146 caracteres:**

```text
One phone. One secret word. Someone is bluffing. Play unlimited free rounds with 3-20 friends, or try Guided mode for questions, votes and scores.
```

O promocional comunica benefícios; não tratá-lo como substituto do campo de keywords. Não inserir preço fixo em descrição, para não contradizer preços regionais.

**Descrição proposta:**

```text
Everyone knows the secret word. Except the imposters.

Pass one phone around, share clues, and decide who is bluffing. Oddly brings a quick word game to your next hangout, game night, or family gathering.

START FAST
Choose how many people are playing and start. Player names are optional, and a ready-to-play mix of free categories gets you going without extra setup.

QUICK MODE: 3-20 PLAYERS
Hold to see your secret role, then release to hide it before passing the phone. Talk and vote together, away from the screen. When your group is ready, reveal the imposters and the word. Play again with the same group in one tap.

MAKE IT YOUR GAME
Choose one or more categories, adjust the number of imposters, or turn on an optional hint or discussion timer. Keep things simple or customize your next round.

GUIDED MODE: 3-9 PLAYERS
Want more structure? Answer guided questions, vote in the app, and compete for points across rounds.

FREE TO KEEP PLAYING
Both modes include unlimited free rounds. Optional themed word packs are available as one-time purchases. No subscription is required.

ONE PHONE. NO WI-FI NEEDED TO PLAY.
Play the included content offline. Purchases and restoration may require an internet connection.

The interface is available in English, Portuguese, Spanish, Hindi, and Arabic. Extra packs are clearly labeled when their content is in English.

Gather your friends. Give a clue. Find the imposters.
```

Publicar somente se todas as afirmações passarem nos critérios P0. O nome Oddly é placeholder até verificação. Não anunciar catálogo inteiro como gratuito, nem conteúdo novo americano como disponível em todos os idiomas. Não usar “best”, rankings fictícios, reviews inventadas ou números de downloads não comprovados.

**Novidades da atualização — rascunho:**

```text
Out of the Loop has a fresh look and a faster way to play.

- Start Quick mode with 3-20 players and optional names.
- Discuss and vote together, then reveal the imposters and the word.
- Hold to reveal your role and release to hide it.
- Keep your group and settings for the next round.
- Try Guided mode for questions, in-app votes and scores.
- Explore clearly labeled, one-time word packs.

Existing eligible purchases remain available. You can restore purchases in Settings.
```

## 5. Página visual e screenshots

Produzir capturas do build real, com conteúdo fictício de exemplo e sem dados de pessoas. Priorizar telas iPhone; usar os tamanhos exigidos pelo App Store Connect no momento do envio, não esticar imagens para preencher resolução. Capturas iPad devem mostrar layout real quando exigidas. Localizar headline e interface nos outros idiomas, preservando identidade.

| Ordem | Headline US | Captura / composição | O que comprova |
| --- | --- | --- | --- |
| 1 | One word. Someone is bluffing. | Dois cartões ilustrando palavra e papel, com UI real e marca própria | Mecânica entendida antes de ler a descrição |
| 2 | Ready for your next hangout | Setup com 6 pessoas, Quick, mistura gratuita e Start game | Início simples; 3–20 players em apoio |
| 3 | Hold. Peek. Pass. | Papel coberto/revelado em sequência visual curta | Privacidade e uso de um celular |
| 4 | Talk together. Find the imposters. | Tela de conversa e revelação final | Jogo acontece entre amigos, não num chat |
| 5 | More themes. More game nights. | Categorias gratuitas + área de extras claramente identificada | Variedade; “Optional paid packs” legível |
| 6 | Want questions and scores? | Tela guiada e placar | Guided mode como diferencial gratuito |
| 7 opcional | Another round. One tap. | Resultado com Play again | Repetição fácil; remover se sequência ficar redundante |

Primeiras três imagens devem funcionar como narrativa autossuficiente. Uma mensagem por imagem, texto curto, legível na miniatura; não cobrir o CTA principal com marketing. Não usar a estética verde-limão + wordmark do concorrente como sistema de identidade.

Ícone: duas alternativas de símbolo próprio; avaliar silhueta, contraste, reconhecimento a 32/60 px e diferenciação nos resultados de busca. App preview em vídeo é P1, não bloqueia lançamento. Não usar screenshots promocionais como se fossem validação de fluxo funcional.

## 6. Categorias, localização e avaliações

Proposta: manter Games > Word e avaliar Family como segunda categoria se disponível e representativa no cadastro atual. Confirmar campos efetivos no App Store Connect; não mudar para Entertainment só porque o fornecedor classifica assim o concorrente.

P0: inglês US como conteúdo comercial principal; demais storefronts mantêm páginas corretas e traduzidas, sem anúncios de catálogo expandido inexistente. Não explorar localizações estrangeiras apenas para empilhar keywords inglesas. Storefront, idioma de UI e idioma de conteúdo têm finalidades distintas.

Avaliações: pedido nativo após uso significativo, sem prêmio e sem perguntar se a pessoa gostou antes de decidir quem pode avaliar. Não copiar desbloqueio por review observado no concorrente. Responder relatos úteis com contexto e correção, sem solicitar nota maior. [Orientação oficial](https://developer.apple.com/app-store/ratings-and-reviews/).

## 7. Experimentos e acompanhamento

Antes: salvar metadados, screenshots, versão, contagens disponíveis de impressões/downloads/receita, período e filtros. Uma reformulação muda produto e marca ao mesmo tempo; a comparação antes/depois é observacional e não identifica sozinha o efeito de cada mudança.

Após lançamento: manter conjunto inicial por 2–4 semanas, salvo erro factual, rejeição ou quebra. Sem volume suficiente, usar leitura qualitativa e contagens, não declarar um vencedor em A/B. Conferir [Product Page Optimization](https://developer.apple.com/help/app-store-connect-analytics/acquisition/product-page-optimization/) para os elementos e recursos disponíveis na conta.

| Experimento futuro | Hipótese | Variável / avaliação |
| --- | --- | --- |
| Primeira screenshot: mecânica vs ocasião | Mostrar segredo/impostor explica melhor que mostrar festa | Só primeira imagem; conversão da ferramenta e intervalos |
| Ícone: cartão vs balões | Símbolo é reconhecido mais facilmente em tamanho reduzido | Só ícone; checar requisitos de build da Apple |
| Metadata B | “Party game” descreve melhor que “offline” para a aquisição desejada | Próxima revisão de metadata, sem alegar teste simultâneo se não houver suporte |

A cada semana: exportar App Store US Search/Browse, comparar janelas equivalentes, registrar release e alterações. Verificar ativação/repetição para não otimizar downloads de pessoas que esperavam online. Meta de crescimento será definida após baseline; não prometer top 10, número de downloads nem receita estimada.

## 8. Checklist de publicação

- [ ] Nome escolhido, disponível e sem conflito conhecido; bundle/Store ID preservados.
- [ ] Contagens de caracteres verificadas; todos os campos revisados no formulário real.
- [ ] Metadata atual exportada antes da substituição; ausência de dados registrada.
- [ ] Screenshots reais, textos corretos e sem conteúdo pago apresentado como gratuito.
- [ ] Contato de suporte, política e links funcionais; nova marca consistente.
- [ ] Classificação etária e privacidade atualizadas conforme conteúdo e SDKs reais.
- [ ] Produtos e combo disponíveis nas regiões pretendidas; preço exibido pela loja.
- [ ] Direitos antigos, compra e restauração verificados no sandbox.
- [ ] Build enviado corresponde ao código e contém catálogo premium e configuração RevenueCat.
- [ ] Notas de revisão explicam modo rápido/guiado, compra única, conteúdo inglês e caminho de restore.
- [ ] TestFlight instalado em aparelho físico; teste offline, 20 jogadores, retomada e idiomas concluído.
- [ ] Publicação executada pelo proprietário como tarefa separada; este documento não altera a loja.

## 9. Fontes

Além das fontes citadas no texto: [App Store Search](https://developer.apple.com/app-store/search/), [página de produto](https://developer.apple.com/app-store/product-page/), [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/). Consultar novamente na submissão, pois ferramentas e políticas podem mudar. Pesquisa ScreensDesign e limitações estão no PRD principal.
