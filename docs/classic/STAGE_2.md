# Etapa 2 — home e configuração Classic

Status: concluída em 25/10/2026 com evidência automatizada e roteiro reproduzível. Base: `fe4e451` (etapa 1). Código validado no commit `26762f7`; documentação registrada em commit separado.

## Artefato

`flutter run -t lib/main_classic.dart` abre a home Classic offline, sem Firebase, persistência ou billing real. A entrada pública `lib/main.dart` continua Guided até a etapa 8. O proprietário solicitou commits e push na `main`.

- S01: home Coral Social, header com ajuda/settings, grupo, etiquetas de categorias com quebra de linha, impostores, hint, timer, Troll e dock transparente fora do scroll. A altura do dock acompanha texto e SafeArea; Premium desaparece no estado de acesso fake ativo.
- S02: nomes como rascunho, contador 3–20, adicionar/remover, IDs preservados, nomes vazios recebem nome padrão localizado. Save lê os TextEditingControllers diretamente, inclusive com teclado aberto. Fechar cancela. Reduzir grupo limita a seleção manual ao novo teto.
- S03: 23 categorias de apresentação (3 grátis: food/animals/sports; 20 Premium), rascunho isolado, Select all free/Select all, Clear, Confirm fixo e desabilitado se vazio. Fechar cancela. A home mostra All somente com 23; três gratuitas mantêm etiquetas individuais.
- S04: Auto recomendado e valores manuais até o teto permitido. Done confirma; fechar cancela.
- S15: ajuda somente no header, seis passos e nota de hint/Troll, sheet rolável com X acessível. Home/configuração/scroll permanecem montados sob os sheets.
- S22: switch liga com 3 minutos inicialmente e não abre sheet; desligado, a área de duração não abre nada. Ligado, a área abre opções 1–10 e Done. Escolher duração atualiza imediatamente; fechar mantém a última escolha. Desligar/religar lembra a duração.
- Hint/Troll alternam imediatamente e começam desligados. Start permanece desabilitado, com a etapa 3 indicada no aviso da demonstração.

`ClassicDemoPremium` é um gateway fake local à demonstração. Abrir categoria bloqueada mostra aviso e CTA explícito para habilitar a simulação. Retorna ao mesmo sheet/rascunho/scroll; habilitar o fake não seleciona categorias. Um toque explícito e Confirm ainda são necessários. Compra pela home também não altera a seleção. Não há cobrança, preço inventado, direito persistido ou integração com produção.

O controlador valida IDs do catálogo de apresentação e idioma inglês, sem exigir palavras nas categorias Premium nesta etapa de preparo. Apenas as três categorias grátis têm uma palavra fixture cada. A geração de rodada deverá exigir conteúdo real na etapa 3; catálogo completo e acesso real pertencem às etapas 5/6.

## Aceite e evidências

| Critério | Evidência |
| --- | --- |
| Defaults válidos, 3–20 e Auto/manual | `classic_foundation_test.dart` verifica todos os limites; `classic_home_test.dart` cobre nomes opcionais, limites dos botões e retorno a Auto |
| Salvar último nome com teclado aberto | Matriz 20 nomes × texto 100%/200% × gratuito/Premium em 320×640; Save acima do inset simulado e nome salvo |
| Timer off não abre duração; switch independente | Teste off → on sem sheet → 7 minutos → off/on mantém 7 |
| Clear desabilita Confirm; fechar cancela | Teste verifica callback desabilitado e seleção anterior preservada |
| Select all free seleciona três; All só com 23 | Testes de seleção gratuita e retorno do gateway fake com seleção total |
| Scroll alcança últimas ações acima do dock | Matriz verifica geometria da última ação Share/Rate acima do dock em ambos os estados Premium |
| Hint/Troll e cancelamento de nomes | Teste de alternância sem sheet e rascunho de 20 nomes descartado ao fechar |
| Ajuda e sheets preservam contexto | Testes de abrir/fechar ajuda e retorno de nomes/categorias sem substituir home |

## Roteiro reproduzível

1. Executar `flutter run -t lib/main_classic.dart`. Esperado: 3 jogadores, três etiquetas grátis, Auto, hint/timer/Troll off, Start desabilitado e Premium demo disponível.
2. Abrir o grupo, adicionar até 20, rolar até o último nome, editar mantendo teclado aberto e tocar Save names. Esperado: nome atual salvo; nenhuma ação coberta pelo teclado. Reabrir, remover ou editar e fechar por X: rascunho descartado.
3. Abrir Categories e tocar Clear. Confirm fica desabilitado. Fechar e reabrir: seleção original continua. Select all free + Confirm mantém três etiquetas, sem All.
4. Tocar uma categoria bloqueada. Fechar o aviso: rascunho/scroll preservados. Reabrir e habilitar Premium demo: mesmo sheet continua, sem seleção automática. Select all + Confirm mostra All; dock perde o CTA Premium.
5. Abrir Imposters, escolher manual e Done. Reduzir o grupo e salvar: teto é respeitado. Selecionar Auto e Done restaura o cálculo automático.
6. Timer off: tocar texto não abre. Ligar pelo switch: 3 minutos sem sheet. Tocar texto, escolher 7 e Done, desligar/religar: 7 minutos. Hint/Troll alternam sem abrir sheets.
7. Abrir `?`, ler seis passos e fechar por X. Configuração e posição da home continuam. Rolar até Share/Rate e rodapé, com Premium demo desabilitado e habilitado, incluindo texto do sistema a 200%.
8. Previews em `lib/previews/classic_previews.dart`: home 320×640, home texto 200% e galeria de componentes da etapa 1.

## Validação e limites

- `flutter gen-l10n`: passou.
- `flutter analyze --no-fatal-infos`: passou, com os dois infos preexistentes de analytics/setup fora do escopo.
- `flutter test test/classic test/domain test/data test/l10n`: 78 testes passaram.
- `git diff --check`: passou.

Textos novos seguem ARB e têm inglês/português; es/hi/ar usam os textos novos em inglês até a tradução integral da etapa 7. Idioma do conteúdo é explicitamente inglês nesta fixture, portanto não existe troca silenciosa de idioma ao selecionar extras. Share/Rate ficam explicitamente indisponíveis até a etapa 7. Settings demonstra somente o contexto de desenvolvimento.

Não houve teste em aparelho físico, teclado nativo, VoiceOver, inspeção manual do previewer, build de distribuição ou transação real. A evidência de teclado/geometria é de widgets com insets simulados. A suíte completa permanece no aceite da etapa 8. Nenhuma mudança de schema persistido, configuração nativa ou produtos comerciais. Recuperação: executar a entrada anterior `lib/main.dart`; nada é migrado ou gravado por esta demonstração.
