# Etapa 8 — integração final e candidato local

Data: 25/10/2026. **Implementação técnica entregue; em validação.** A entrada
padrão agora é Classic. O aceite de RC/TestFlight continua bloqueado pelos itens
externos abaixo; não houve upload, publicação nem alteração de produtos reais.

**Correção posterior:** o P2 de emojis foi corrigido com assets locais e conferido no simulador. Ver [evidências e validação](EMOJI_FIX.md). A captura e os hashes da validação original abaixo são históricos.

## Integração

- `lib/main.dart` inicializa Classic com experiência, sessão persistida e analytics
  independente do início do jogo. `main_classic.dart` encaminha à mesma entrada.
- `ClassicApp` substitui o shell de desenvolvimento. A galeria fica em
  `lib/previews/classic_gallery.dart`, sem entrada pública na aplicação.
- Removidos controller/router/shell Guided, onboarding, setup antigo,
  perguntas/votação/guess/placar/ranking, packs avulsos, review gate, widgets/tema
  antigos e testes exclusivos desses módulos. A suíte Classic cobre suas regras,
  privacidade, migração, Premium, idiomas e suporte; não mantém expectativas de
  produto aposentadas. Nenhum parâmetro de rota transporta segredo.
- `SupportedLanguage` foi isolado em l10n; modelos de partida Guided removidos.
  Mantidos os nomes de chaves das preferências e `game.session.v1` como fonte de
  migração, mapping de conteúdo e direitos legados auditáveis. Não se apagam dados
  de compras nem a sessão antiga para retirar o runtime Guided.
- Removidos `go_router`, `confetti`, `firebase_crashlytics` e scripts/plugins
  Crashlytics do iOS/Android. Firebase Core/Analytics e RevenueCat permanecem.
- Somente ícone, sons e fonte Plus Jakarta Sans são assets declarados. Catálogo
  Classic é compilado no bundle Dart. Bancos JSON antigos permanecem no Git para
  auditoria/conversão editorial e testes de equivalência, sem empacotamento no app.
  Textos antigos de localização sem consumidor não criam telas/rotas públicas.
- Removido bloqueio portrait do bootstrap; Info.plist permite retrato e paisagem
  nos dois fatores de forma. Proteção nativa de preview permanece ativa.
- Bundle ID, marca nativa e versão `1.2.1+7` preservados. O número de build precisa
  ser reconciliado com App Store Connect antes do upload, sem presumir o último
  build publicado. Não usar este build sem configuração comercial como RC público.

## Validação local

Revisão de implementação: `479c83c` (`feat(classic): make Classic the production app and retire Guided`).

- `flutter pub get`: concluído; removidas quatro dependências resolvidas (incluindo a interface transitiva do Crashlytics), sem atualização dos demais pacotes.
- `flutter analyze --no-fatal-infos`: **No issues found**.
- `flutter test`: **80 testes passaram**, suíte completa remanescente.
- `python3 tool/classic_catalog.py --check`: 120 textos grátis + 800 exclusivos Premium, 959 entradas; revisão humana continua pendente.
- `git diff --check` e `plutil -lint` no Info.plist/projeto Xcode: passaram.
- `flutter build ios --release --no-codesign`: **sucesso**, `build/ios/iphoneos/Runner.app`, 42,4 MB. Sem defines comerciais reais nesta execução.
- `python3 tool/classic_rc_check.py build/ios/iphoneos/Runner.app`: passou; Bundle ID preservado, versão 1.2.1/build 7, iPhoneOS, famílias iPhone/iPad, retrato/paisagem, ícones/áudio e ausência dos assets aposentados/Crashlytics conferidos. Hashes do executável e do código Flutter em [stage8-release-inspection.json](stage8-release-inspection.json). O arquivo é evidência do .app local, não de IPA exportado ou assinatura.
- Build emite o aviso já existente sobre CocoaPods/Swift Packages. Não foi feita migração de infraestrutura.
- `flutter build ios --simulator`: sucesso. Instalado sobre o app existente e aberto via `simctl` no iPhone 17; home Classic em português inspecionada ([captura real](stage8-home-simulator.png)). A captura confirma entrada Classic; não certifica migração sobre a versão publicada nem fluxos comerciais. Os glifos ausentes de emojis decorativos continuam reproduzíveis nesse simulador e permanecem como P2 visual.
- Nenhum iPhone/iPad físico apareceu em `xcrun xctrace list devices`; há iPhone 17 simulado (iOS 26.3). Instalação física e TestFlight não executados.

Comandos reproduzíveis:

```sh
flutter pub get
flutter analyze --no-fatal-infos
flutter test
python3 tool/classic_catalog.py --check
flutter build ios --release --no-codesign
python3 tool/classic_rc_check.py build/ios/iphoneos/Runner.app
flutter build ios --simulator
```

`classic_production_entry_test.dart` chama a entrada de produção com onboarding
antigo incompleto: home Classic aparece, não há rota anterior para voltar e Start
leva diretamente à passagem de papéis. Os testes de 3/20 jogadores cobrem
revelação/ocultação, confirmação, discussão, resultado e replay, inclusive texto
200% em viewport pequeno. Demais evidências estão nas etapas 3–7.

## Matriz de QA

“Automatizado” significa evidência de código/widgets, não aprovação em aparelho.
“Pendente” exige execução e evidência externa; testes anteriores de simulador não
são reaproveitados como certificação do novo binário.

| Cenário | Evidência local | Aceite físico/externo |
| --- | --- | --- |
| Primeira abertura sem onboarding | Teste da entrada padrão | Pendente |
| Atualização, nomes/histórico e retomada coberta | Sessão/migração/host; fonte antiga preservada | Atualização sobre loja pendente |
| Offline, 3 e 20 jogadores, replay | Fluxo completo e regras automatizados | Pendente |
| Timer off/on/zero e Troll | RNG/clock controlados e widgets | Pendente |
| Hold/release/cancel/foco/rotação/background | Widgets e canais nativos preservados | Preview, lock e kill em aparelho pendentes |
| Falha de escrita/corrupção/schema futuro | Repositório/host automatizados | Pendente |
| iPhone pequeno e iPad, texto 200% | Widgets 320×640 e 1024×768 | Dispositivos físicos pendentes |
| en/pt-BR/es/hi/ar, RTL e troca de idioma | Contratos ARB e widgets nos cinco idiomas | Revisão linguística/VoiceOver pendentes |
| Paisagem | Info.plist + widgets de rotação | Pendente |
| Preço, compra, cancelamento, restore, expiração, legado | Fakes controlados de gateway/política | Sandbox/auditoria pendentes |
| Share cancelado, feedback/review, áudio/haptics | Contratos e widgets | Integrações/hardware pendentes |
| Telemetria sem nomes/palavras/papéis | Allowlist e testes de eventos | DebugView real pendente |
| Catálogo e migração de IDs | Checker: 120 grátis + 800 Premium; equivalências | Revisão editorial/cultural pendente |
| Bundle ID, assets e orientações | Inspeção do .app local | IPA assinado/TestFlight pendentes |
| Cinco anfitriões, pelo menos dois grupos | Protocolo abaixo | Não realizado |

## Problemas priorizados e bloqueadores

| Prioridade | Item | Evidência necessária para encerrar |
| --- | --- | --- |
| P0 — bloqueia RC | Produtos/entitlement/preços reais e auditoria de direitos legados | Cenários sandbox da etapa 6 no build identificado; sem compra sem acesso/perda de direito |
| P0 — bloqueia RC | Privacidade e retomada em aparelho/atualização real | Gravação/registro de preview, background, interrupção/kill e upgrade, sem exposição ou alteração da rodada |
| P1 — bloqueia aceite | Revisão editorial/traduções/cultural | Aprovação humana do catálogo e dos cinco idiomas |
| P1 — bloqueia distribuição | Marca, URLs legais, contato e build único | Valores confirmados, versão conciliada com a loja e conferência dos links no candidato |
| P1 — bloqueia aceite | Teste com pessoas e QA físico | Cinco anfitriões em dois grupos, VoiceOver/iPad/áudio/share e resolução de fricção crítica |
| P1 — bloqueia TestFlight | Assinatura/export/upload e instalação do candidato | IPA, hash, versão/build, processamento TestFlight e instalação física |
| P2 — corrigido | Emojis decorativos agora usam imagens locais | [Home/categorias conferidas e testes de escala/RTL](EMOJI_FIX.md) |

Não foi detectado defeito crítico nos cenários automatizados executados. Isso não
comprova ausência de defeitos nos cenários pendentes nem satisfaz o aceite
comercial das etapas 5/6/7.

## Protocolo de usabilidade e demonstração

1. Instalar o candidato identificado; registrar dispositivo/iOS/idioma/orientação,
   build, configuração comercial usada e se é primeira instalação ou atualização.
2. Convidar cinco anfitriões distribuídos em pelo menos dois grupos. Pedir a cada
   um que prepare, inicie, termine e repita uma partida, sem instruções adicionais.
3. Cronometrar abertura→primeira passagem de papel e resultado→nova rodada.
   Registrar intervenções, dúvidas, toques incorretos e bloqueios, sem guardar
   nomes/papéis/palavras dos participantes em logs/analytics.
4. Meta proposta: pelo menos 4/5 iniciam e repetem sem ajuda. Corrigir fricção
   crítica e repetir o cenário afetado; registrar resultado observado.
5. Executar a matriz física/comercial no mesmo candidato. Conferir IPA exportado
   e instalação via TestFlight, não apenas o fonte ou o .app sem assinatura.

| Anfitrião anônimo | Grupo | Dispositivo/build | Inicia sem ajuda | Repete sem ajuda | Tempos observados | Fricção/issue |
| --- | --- | --- | --- | --- | --- | --- |
| A | A definir | Pendente | Não observado | Não observado | Não medidos | Não observado |
| B | A definir | Pendente | Não observado | Não observado | Não medidos | Não observado |
| C | A definir | Pendente | Não observado | Não observado | Não medidos | Não observado |
| D | A definir | Pendente | Não observado | Não observado | Não medidos | Não observado |
| E | A definir | Pendente | Não observado | Não observado | Não medidos | Não observado |

## Recuperação

Antes de distribuição, preservar uma referência da revisão anterior (a integração
parte de `44c7d2f`) e os dados locais. Recuperação de código via Git não é rollback
instantâneo da loja. A etapa não muda schema nem apaga preferências/direitos;
versões futuras de sessão continuam protegidas. Não desinstalar para validar
migração. Publicação e pacote de submissão pertencem à etapa 9.
