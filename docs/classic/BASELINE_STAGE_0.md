# Classic — etapa 0: baseline e inventário de migração

Data: 25/10/2026 (America/Sao_Paulo). Escopo: C00 de [TDD_CLASSIC](../TDD_CLASSIC.md).

Estado: evidência local concluída; confirmação comercial e equivalência com a loja pendentes. Isso permite avançar com código independente, sem aprovar publicação.

## Referência preservada

- Fonte auditada: `2f41cb00667cd8240ad2877142048055db5fc528`.
- Tag de recuperação: `classic-pre-rebuild-2026-10-25`, apontando para essa revisão.
- Branch de referência criada: `codex/classic-rebuild`, inicialmente na mesma revisão. A entrega da etapa 0 vai à `main` por instrução posterior do proprietário.
- `git status --short` inicial vazio: nenhuma alteração local anterior a preservar. Nenhum reset, clean ou descarte executado.
- `origin/main` consultada via `git ls-remote`: mesma revisão inicial. Não representa evidência de versão distribuída.
- Não houve mudança em código de gameplay, assets de conteúdo, identidade nativa ou configuração comercial.

Para consultar a versão anterior sem sobrescrever trabalho atual:

```sh
git show classic-pre-rebuild-2026-10-25:pubspec.yaml
git worktree add --detach /tmp/out-of-the-loop-baseline classic-pre-rebuild-2026-10-25
```

Usar um caminho livre para o worktree. A tag não inclui arquivos ignorados, credenciais, certificados ou dados de um app instalado. Recuperação de dados do usuário exige preservar a instalação e validar migração na etapa 4; checkout Git não restaura preferências do aparelho.

## Fonte local versus build publicado

| Item | Evidência local | Loja/aparelho publicado |
| --- | --- | --- |
| Versão/build | `pubspec.yaml`: `1.2.1+7`; projetos usam versão/número do Flutter | Não consultado; não assumir que 1.2.1 (7) está publicado |
| iOS Bundle ID | `com.mathsquirrels.outoftheloop` nas configurações Debug/Profile/Release de `ios/Runner.xcodeproj/project.pbxproj` | Comparar com App Store Connect e IPA exportado |
| Android applicationId/namespace | Mesmo ID em `android/app/build.gradle.kts` | Play Console não consultado; lançamento Android fora do P0 |
| Assinatura | Team configurada no Xcode; Android lê `key.properties` quando disponível e tem fallback debug | Certificados, profiles e assinatura do binário distribuído não validados |
| Firebase | `lib/firebase_options.dart`: projeto `imposter-math-squirrels`, Bundle ID iOS compatível; bootstrap em `lib/src/app/firebase_bootstrap.dart` | Console, eventos e crashes de produção não consultados |
| Gameplay | Guided/free, 3–9 jogadores, um impostor por rodada nos modelos atuais | Nenhuma instalação anterior inspecionada |
| Catálogo | Dois JSONs schema 1 com perguntas obrigatórias; hashes e contagens no inventário anexo | Assets do binário publicado desconhecidos |
| Compras | Gateway RevenueCat para não assinaturas e catálogo US | Produtos, preços, vendas, direitos e offering reais desconhecidos |

Não há export de App Store Connect, IPA distribuído ou relatório RevenueCat anexado. Ausência de evidência externa não significa ausência de produtos, usuários ou direitos vitalícios. A referência Git preserva fonte local, sem garantir equivalência com a loja.

## IDs comerciais e integrações

Fontes: `lib/src/data/content/us_pack_catalog.dart`, `lib/src/data/purchases/purchase_gateway.dart` e `lib/src/features/packs/packs_controller.dart`.

| ID/contrato | Comprovado na fonte | A confirmar externamente |
| --- | --- | --- |
| `us_backyard` | Categoria e ID esperado de pacote/entitlement individual | Store product ID e entitlement real |
| `us_roadtrip` | Categoria e ID esperado de pacote/entitlement individual | Store product ID e entitlement real |
| `us_holidays` | Categoria e ID esperado de pacote/entitlement individual | Store product ID e entitlement real |
| `game_night_collection` | Entitlement esperado que libera os três packs | Produto/pacote, promessa de duração e direitos legados |
| Offering | Usa `offerings.current`; ID não fixado no código | ID atual e associação de pacotes/produtos |
| Anual/semanal | Não implementados no gateway atual | IDs dos produtos, grupo, períodos, preço, trial e mapeamento |
| `premium_categories` | Apenas proposta no TDD | Nome e configuração final do entitlement compartilhado |

Os IDs de produtos da loja são lidos em runtime do SDK, sem lista literal na fonte. Não tratar IDs de categoria como IDs confirmados de StoreKit. `load()` filtra `nonSubscription` sem período; `buy()` considera sucesso se entitlement ativo contém o ID do pacote. Esse acoplamento deve mudar na etapa 6, mantendo direitos antigos auditados.

Configuração de build lê `REVENUECAT_IOS_API_KEY` e `REVENUECAT_ANDROID_API_KEY` via `String.fromEnvironment`; sem chave da plataforma não chama o SDK. Valores não são inventariados nem copiados. Não alterar produtos reais nesta etapa. Nenhuma chave ou certificado é necessário no relatório.

## Preferências e dados a preservar

| Chave | Tipo e default | Migração prevista |
| --- | --- | --- |
| `onboarding.completed` | bool, false | Preservar; Classic não deve exigir onboarding legado |
| `settings.language` | String, código reconhecido; fallback pelo locale | Preservar `pt-BR`, `en`, `es`, `hi`, `ar`; distinguir idioma da UI/conteúdo no Classic |
| `settings.music` | bool, false | Preservar preferência de áudio |
| `settings.soundEffects` | bool, true | Preservar preferência de efeitos |
| `game.session.v1` | String JSON schema `version: 1`; defaults abaixo | Manter fonte intacta até leitura/validação da migração |
| `review.rated` | bool, false | Preservar; revisar fluxo de avaliação na etapa 7 |
| `review.declinedAtMillis` | int UTC epoch ms, null | Preservar recusa e cooldown |

Fontes: `preferences_repository.dart`, `session_repository.dart` e `review/app_review_store.dart`, sob `lib/src/data/`.

Envelope legado: `players` (nomes, sem IDs persistidos), `mode` (`guided` default ou `free`), `roundCount` (default 3, clamp 1–5), `questionsPerPlayer` (default 1, clamp 1–3), `words` (até 2000), `questions` (até 8000). Leitura limita grupo a 9, remove nomes vazios/duplicados e recria IDs `saved-N`. JSON inválido/versão desconhecida retorna defaults; não existe snapshot de rodada ativa nesse contrato.

`PlayHistory` (`lib/src/domain/models/play_history.dart`) ordena do mais antigo ao mais recente. Chave de palavra: `idioma:categoria:palavra`. Perguntas podem conter ID ou texto normalizado (`idioma:categoria:text:...`); não enviar histórico a logs/analytics. Preservar recência de palavras com mapping explícito na etapa 5; perguntas e parâmetros Guided não viram regras Classic. Não inventar papéis/tempo de uma rodada que nunca foi salva.

`classic.session.v1` é proposta futura, ainda não criada. Migração da etapa 4 deverá ser idempotente, gravar e reler o novo envelope antes de marcar sucesso, preservar a origem em falhas e lidar com schema futuro. Nenhuma chave própria de direitos comerciais foi encontrada nesses repositórios: direitos vêm do SDK; não migrar para bool Premium nem apagar dados do RevenueCat ao resetar grupo.

## Conteúdo por idioma

Contagem reproduzível em [baseline/content-inventory.json](baseline/content-inventory.json), com SHA-256 dos bytes de cada asset. Gerador: `python3 tool/classic_baseline_inventory.py`. Conta textos não vazios por idioma declarado; não certifica tradução, adequação cultural ou originalidade semântica.

| Asset/categoria | Palavras | Perguntas | Idiomas com esses totais |
| --- | ---: | ---: | --- |
| seed / `food` | 30 | 270 | pt-BR, en, es, hi, ar |
| seed / `movies` | 30 | 270 | pt-BR, en, es, hi, ar |
| seed / `sports` | 30 | 270 | pt-BR, en, es, hi, ar |
| seed / `music` | 30 | 270 | pt-BR, en, es, hi, ar |
| seed / `travel` | 30 | 270 | pt-BR, en, es, hi, ar |
| seed / `animals` | 30 | 270 | pt-BR, en, es, hi, ar |
| US / `us_backyard` | 20 | 180 | en |
| US / `us_roadtrip` | 20 | 180 | en |
| US / `us_holidays` | 20 | 180 | en |

Totais: inglês 240 palavras/2160 perguntas; cada um dos outros quatro idiomas 180/1620. São 240 entradas de palavra na biblioteca, sem somar traduções como conceitos novos. Base: 6 categorias/180 palavras; US: 3 categorias/60 palavras (`contentVersion: us-1`). Não correspondem às futuras 3 categorias grátis + 20 Premium nem à meta de 920 palavras Classic. Conversão/editoria e equivalência de IDs pertencem à etapa 5.

## Matriz de reaproveitamento

| Área/fonte | Destino | Condição/verificação futura |
| --- | --- | --- |
| `ios/`, `android/`, Firebase | Preservar identidade e integração | Comparar candidato exportado com registro da loja; não recriar projeto nativo |
| `data/preferences/`, áudio, l10n | Adaptar e preservar chaves/idiomas | Testar preferências, RTL, texto ampliado e iPad |
| `data/session/`, `domain/models/play_history.dart` | Migrar nomes e histórico | Fixtures, falha de escrita e atualização sem reinstalar na etapa 4 |
| `data/content/`, assets JSON | Converter palavras com mapping; novo parser | Schema atual exige perguntas; validar tradução/editoria na etapa 5 |
| `data/purchases/`, `features/packs/` | Reusar SDK; substituir contratos comerciais | Separar produto/pacote/entitlement e auditar legado na etapa 6 |
| `app/game_flow_controller.dart`, modelos/serviços Guided | Manter só durante construção; substituir para Classic | Novo domínio/controlador independente; remoção definitiva na etapa 8 |
| Rotas e telas de setup/reveal/discussão/resultado | Reconstruir conforme Classic | Sem voto/placar/perguntas digitais no fluxo final |
| `shared/widgets/`, tema e previews | Reutilizar somente componentes compatíveis | Coral Social, acessibilidade, tamanhos e estados na etapa 1 |
| `data/analytics/`, review/suporte | Adaptar sem dados sensíveis | Contratos de eventos e decisão de review na etapa 7 |
| Testes existentes | Baseline de regressão; preservar os aplicáveis | Substituir expectativas Guided ao remover o fluxo |

## Verificação executada

Revisão de runtime e assets: `2f41cb00667cd8240ad2877142048055db5fc528`. Documentação e gerador adicionados nesta entrega. Ambiente: Flutter 3.47.7 stable (`abaf9c5237`), Dart 3.13.5, Xcode 26.3 (`17C529`), macOS. A primeira tentativa de Flutter no sandbox não pôde escrever no cache do SDK; validações repetidas com acesso autorizado ao cache.

| Comando | Resultado em 25/10/2026 | Limitação |
| --- | --- | --- |
| `flutter analyze --no-fatal-infos` | Exit 0; dois infos preexistentes | `unnecessary_import` em `analytics_service.dart:3`; `unnecessary_underscores` em `setup_screens_test.dart:170` |
| `flutter test --no-pub` | Exit 0; **152 testes passaram** | Testes locais, sem StoreKit/aparelho físico |
| `python3 tool/audit_content.py --check` | Exit 0; 0 erros estruturais e 0 grupos de prompts repetidos entre palavras | Não substitui revisão humana |
| `python3 tool/classic_baseline_inventory.py` | Inventário determinístico com hashes e contagens | Não lê dados instalados nem loja |
| `flutter build ios --release --no-codesign --no-pub` | Exit 0; Runner.app gerado (46,2 MB), Xcode em 129,3 s | Sem assinatura, export IPA ou instalação |

Artefato local: `build/ios/iphoneos/Runner.app` (ignorado pelo Git). `Info.plist` do build confirma `CFBundleIdentifier=com.mathsquirrels.outoftheloop`, `CFBundleShortVersionString=1.2.1` e `CFBundleVersion=7`. SHA-256 do executável `Runner`: `7eab4d79b0168934c3c5c42bf67c7c19e79bc667ae925318d1532e6e5db14ea8` (identifica esta execução; não se exige hash idêntico entre builds). Sem assinatura/IPA, não instalável diretamente como candidato de distribuição. O Flutter sugeriu migração manual de CocoaPods para Swift Package Manager pelo Podfile existente; a sugestão não impediu o build e nenhuma migração foi feita. Android não foi compilado nesta etapa.

## Build reproduzível e demonstração

Em checkout limpo da referência, com Flutter/Xcode compatíveis instalados:

```sh
flutter pub get
flutter analyze --no-fatal-infos
flutter test --no-pub
python3 tool/audit_content.py --check
python3 tool/classic_baseline_inventory.py > /tmp/classic-content-inventory.json
diff -u docs/classic/baseline/content-inventory.json /tmp/classic-content-inventory.json
flutter build ios --release --no-codesign --no-pub
```

O arquivo esperado e o gerador pertencem ao commit da etapa 0, não à tag anterior. Para reproduzir o build anterior, usar os quatro comandos Flutter sem depender desses arquivos novos. Dependências podem exigir rede; caches locais não são entregáveis. O build diagnóstico omite chaves RevenueCat e não comprova compra. Para build comercial posterior, obter os defines públicos por canal autorizado e usar configuração de assinatura existente; não versionar arquivos com segredos. Não seguir sugestões automáticas de remover Pods ou trocar assinatura como parte desta baseline.

Demonstração da entrega: abrir este relatório, conferir a tag com `git rev-parse classic-pre-rebuild-2026-10-25`, regenerar e comparar o inventário, repetir análise/testes/build e verificar Bundle ID/versão no `.app` gerado. Resultado esperado: inventário sem diferenças, identidade preservada e limitações comerciais explícitas. Não é demonstração de Classic jogável, que começa nas etapas seguintes.

## Pendências iniciais e responsáveis

| ID | Pendência/evidência necessária | Responsável | Limite |
| --- | --- | --- | --- |
| P0-01 | Export da loja: versão/build vigente, Bundle ID, arquivo distribuído e revisão de origem se disponível | Produto | Comparação inicial quando disponível; obrigatória no RC |
| P0-02 | Export RevenueCat/App Store: produtos, offering, pacotes→produtos→entitlements, preços, períodos e estado das vendas | Produto/comercial | Antes do aceite da etapa 6 |
| P0-03 | Auditar lifetime/coleção/packs e promessas a compradores; relato de zero vendas não elimina direitos | Produto/comercial | Antes de remover oferta/acesso legado |
| P0-04 | Confirmar marca, contatos/URLs legais, preços/trial e decisão de review | Produto | Etapas 6–7 e metadata final |
| P0-05 | Mapping dos IDs e revisão do catálogo Classic; validar idiomas extras em inglês | Engenharia/editoria | Etapa 5 |
| P0-06 | Atualização física sobre versão anterior, preferências e restore sem reinstalar | Engenharia/QA com build anterior | Etapas 4/6/8 |
| P0-07 | Assinatura, export IPA, instalação, sandbox e TestFlight | Engenharia/produto | RC e aceite comercial |

Produto deve confirmar P0-01 a P0-04 com evidência externa. Essas pendências permanecem abertas e não bloqueiam a estrutura Classic independente.

## Aceite da etapa 0

- [x] Identificador de produção preservado na fonte; nenhum projeto nativo recriado.
- [x] Árvore inicial limpa e referência Git anterior preservada.
- [x] Inventário de identidade, contratos comerciais, preferências, conteúdo e reaproveitamento entregue.
- [x] Análise/testes executados com revisão, resultados e limitações registrados.
- [x] Build iOS release local sem assinatura concluído; Bundle ID e versão conferidos no artefato.
- [x] Diferença entre evidência local e loja explicitada; ausência de export permanece pendente.
- [x] Instruções de build/recuperação e roteiro reproduzível sem segredos.

Nenhuma mudança de schema ou migração foi executada. Não há dados locais a reverter por esta entrega documental. Não autoriza publicação nem certifica a distribuição atual.
