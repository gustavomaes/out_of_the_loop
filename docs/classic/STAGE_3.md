# Etapa 3 — partida Classic gratuita e replay

Status: implementação entregue em 25/10/2026; em validação por depender do aceite em aparelho físico. Base: `232a576` (etapa 2). Código e testes validados no commit `cfb22a1`. O proprietário autorizou commits e push na `main`.

## Artefato e escopo

`flutter run -t lib/main_classic.dart` abre a experiência offline: home → distribuição privada (S05) → discussão (S06) → confirmação (S07) → resultado (S08) → replay ou edição. A entrada pública `lib/main.dart` continua Guided até a etapa 8.

- `ClassicRoundFactory` é Dart puro, com RNG injetável. Congela configuração, palavra, categoria, papéis, iniciador e Troll em uma única criação. Auto/manual seguem os limites existentes; o sorteio normal usa pesos 0,5/1 sem reposição e o iniciador é independente. Troll usa o limite configurável de 15%, nunca é sorteado com toggle off e não substitui o histórico normal.
- Seleção considera somente categorias/idioma solicitados, prioriza palavras inéditas no universo selecionado e depois as menos recentes. Escolhe categoria elegível com peso igual, independentemente da quantidade de palavras. Não repete a última palavra quando há alternativa elegível. Exemplos comerciais ficam fora das primeiras cinco rodadas da categoria quando existem pelo menos cinco alternativas; o catálogo inicial não marca exemplos comerciais.
- Catálogo inicial: 36 palavras em inglês, 12 em cada categoria gratuita (food/animals/sports), sem perguntas. É conteúdo inicial jogável; revisão editorial e catálogo completo permanecem na etapa 5. As categorias Premium ainda são apresentação, sem palavras. Selecionar uma delas no fake retorna aviso controlado ao iniciar, sem substituir silenciosamente a seleção ou consumir histórico.
- Controller impede Start/replay duplicado e alterações de configuração durante a rodada. Next exige visualização e índice atual; a UI exige também cartão coberto. Nenhum widget modifica modelos. Rodada e histórico permanecem somente em memória nesta etapa.
- Segurar revela; soltar, cancelar, sair dos limites ou perder foco oculta. O cartão seguinte nasce coberto, sem herdar o gesto. A alternativa acessível tem ações explícitas de revelar/ocultar e também cobre ao perder foco. Impostores não recebem palavra nem parceiros; hint exibe somente a categoria. Todos usam o mesmo cartão externo.
- Discussão mostra iniciador e instrução de votação presencial. O timer começa após a última distribuição, usa Stopwatch monotônico, permite pausar/retomar e pausa ao perder foco/background. Voltar não retoma automaticamente. Zero mostra aviso visual/acessível e permite continuar conversando; nunca revela resultado nem reproduz áudio à revelia das preferências.
- Reveal exige confirmação; cancelar preserva a discussão. Resultado exibe palavra/categoria e todos os impostores juntos, incluindo indicação de Troll apenas no final. Play again preserva grupo/configuração e atualiza sorteio/histórico. Edit game volta à home. Voltar/encerrar exige confirmação e cobre o cartão antes de abrir o diálogo; cancelar nunca reabre segredo. Abrir a confirmação de saída pausa o timer.
- Background cobre a apresentação, invalida a visualização do jogador atual e preserva a rodada existente. No iOS, `SceneDelegate` coloca uma cobertura opaca nativa antes do snapshot e só a remove após o frame seguro sinalizado por Flutter via `classic/privacy`. O canal só habilita a proteção durante telas de rodada Classic. No Android, `FLAG_SECURE` protege preview/capturas da activity inteira, incluindo a entrada antiga; não houve build/validação Android nesta etapa. No iOS, isso não promete bloquear screenshots feitos pelo sistema.

Os textos novos seguem ARB, com inglês/português; es/hi/ar usam inglês até a tradução integral da etapa 7. Há previews de cartão coberto e discussão em `lib/previews/classic_previews.dart`.

## Evidências de aceite

| Critério | Evidência |
| --- | --- |
| Rodada de 3/20 jogadores até resultado, replay e edição | `test/classic/classic_game_flow_test.dart`: ambos os tamanhos em 320×640 com texto 200% |
| Auto/manual, pesos, iniciador independente, Troll normal/todos | `test/classic/classic_round_test.dart`: RNG controlado, todos os tamanhos de grupo, fronteiras de peso e probabilidade |
| Seleção multicategoria, recência e partidas ilimitadas | Testes determinísticos: 36 inéditas e 80 rodadas sem repetição imediata; categoria independente do tamanho; idioma/categoria ausente rejeitados |
| Hold/release/cancel/saída e passagem coberta | Widgets verificam remoção do segredo, Next e novo cartão sem visualização herdada |
| Alternativa acessível e foco | Widgets verificam revelar/ocultar, Next desabilitado com cartão aberto e perda de foco do controle/window |
| Duplo Start/replay/Next | Widgets verificam uma rodada por duplo toque; domínio rejeita índice obsoleto de Next |
| Timer off/on/pause/background/zero | Relógio monotônico controlado no domínio e widgets; fase continua discussion em zero |
| Cancelamento e saída seguros | Widgets exercitam confirmação cancelada, botão de encerrar e back do sistema |
| Preview iOS e retorno de background | Inspeção no iPhone 17, iOS 26.3 **simulador**: papel aberto → seletor de apps com preview opaco → retorno com cartão coberto e Next desabilitado → nova visualização habilita passagem |
| Teste físico inicial de background/preview | **Pendente**: nenhum aparelho físico conectado. Simulador não substitui este aceite |

## Roteiro reproduzível

1. Executar `flutter run -t lib/main_classic.dart`. Manter as três categorias gratuitas e tocar Start game duas vezes: somente uma rodada é criada.
2. No primeiro jogador, segurar o cartão, soltar, cancelar um gesto e arrastar para fora. Esperado: segredo sempre oculto ao interromper; Next só fica disponível após visualizar e cobrir.
3. Usar Reveal role/Hide role. Com papel aberto, enviar o app ao background e abrir o seletor de apps. Esperado no iOS: preview opaco. Voltar: mesmo jogador/rodada, cartão coberto e nova visualização exigida. Repetir em aparelho físico antes de encerrar o aceite.
4. Passar os 3 papéis; repetir com 20 jogadores e texto 200%. Esperado: mesmo segredo para inocentes, somente papel para impostores e discussão após o último cartão.
5. Na discussão, tocar Reveal result e cancelar: discussão mantida, sem segredo. Confirmar: palavra, categoria e todos os impostores aparecem juntos. Play again duas vezes cria uma única rodada; Edit game preserva configuração.
6. Ativar timer (1 minuto para teste), iniciar e passar todos os papéis. Pausar/retomar; ir ao background e voltar. Esperado: restante preservado e timer pausado; zero não revela. Timer off não mostra contagem.
7. Ativar hint/Troll e repetir. Troll tem chance de 15%, portanto não exigir sua ocorrência por amostragem manual. Os testes determinísticos forçam rodada normal e todos impostores. Antes do resultado, nenhuma indicação de Troll; hint mostra a mesma categoria para todos os impostores.
8. Habilitar Premium fake, selecionar categoria ainda sem conteúdo e iniciar: aviso controlado. Voltar às categorias grátis permite jogar normalmente.

## Validação e limites

- `flutter gen-l10n`: passou.
- `flutter analyze --no-fatal-infos`: passou com os dois infos preexistentes em analytics/setup, fora do escopo.
- `flutter test test/classic test/domain test/data test/l10n`: 94 testes passaram.
- `flutter build ios --simulator --debug -t lib/main_classic.dart`: passou; Bundle ID preservado.
- `git diff --check`: passou.

Não há persistência de sessão/histórico/tempo após encerramento do processo: etapa 4. Não foram realizados teste físico, VoiceOver nativo, build Android, build de distribuição, compra real, auditoria editorial completa ou a suíte integral do legado. A validação visual nativa foi no simulador, com a proteção de preview observada durante papel aberto; o contrato completo de release permanece nas etapas posteriores.

Sem mudança de schema salvo, migração, produto comercial, assinatura ou identificação do app. Recuperação: executar `lib/main.dart` para a entrada anterior; esta demonstração não grava sessão nem altera configurações de loja. A proteção Android é nativa e permanece também nessa entrada.

Referências de API consultadas: [lifecycle Flutter](https://api.flutter.dev/flutter/widgets/AppLifecycleListener-class.html), [PopScope](https://api.flutter.dev/flutter/widgets/PopScope-class.html), [ViewFocusEvent](https://api.flutter.dev/flutter/dart-ui/ViewFocusEvent-class.html) e [background no UIKit](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-background).
