# Etapa 6 — integração Premium

25/10/2026 · Status: em validação. Integração técnica entregue; aceite comercial/sandbox pendente.

## Implementação

Entrada executável: `lib/main_classic.dart`. O host inicializa RevenueCat sem bloquear conteúdo gratuito, atualiza no startup/resume e em eventos de CustomerInfo. Sem chave pública configurada, nenhuma requisição de compras é feita.

- Gateway separa pacote, produto StoreKit e entitlement. Apenas produtos explicitamente configurados são ofertados no Classic; fluxo Guided conserva compatibilidade de compras avulsas até a etapa 8.
- Anual/semanal usam o mesmo entitlement, com preço localizado e período retornados pelo SDK. Sem preço inventado ou trial presumido.
- `PremiumAccess` deriva direitos dos entitlements ativos verificados pelo SDK. Não persiste grant local. Cancelar renovação mantém acesso enquanto o SDK o considera ativo. Cache/grace period seguem o SDK; erro de rede preserva a última leitura, leitura válida sem entitlement revoga.
- Entradas voluntárias na home, categoria, settings e resultado. Settings mantém restore/gestão acessíveis inclusive para assinantes. Nenhuma oferta automática em Start/replay.
- O paywall apresenta compra, pendência, cancelamento, falha, restore vazio/restaurado/erro e gestão via assinaturas Apple. Links legais vêm da configuração. Textos novos em inglês; localização completa pertence à etapa 7.
- Retorno contextual mantém o sheet montado e seu scroll/rascunho. Após validar acesso, adiciona a categoria desejada ao rascunho; Confirm continua obrigatório. Conteúdo da rodada é inglês, anunciado no sheet.
- Expiração não muda rodada congelada. Antes de Start/replay, seleção é revalidada. Se necessário, usa categorias ainda elegíveis ou as três gratuitas, avisa e exige novo toque para prosseguir.
- Reset de histórico/sessão não limpa direitos do SDK.

## Ambientes

Arquivos locais `.env` (produção) e `.env.test` (teste) são ignorados pelo Git. `.env.example` é o modelo versionado. Valores desconhecidos ficam vazios: nenhuma credencial/ID é inventado.

```sh
flutter run -t lib/main_classic.dart --dart-define-from-file=.env.test
flutter build ios --release -t lib/main_classic.dart --dart-define-from-file=.env
```

Preencher as chaves públicas iOS/Android do RevenueCat e os IDs reais de entitlement, produto anual e produto semanal. Associar ambos ao entitlement no offering atual. `CLASSIC_TERMS_URL` e `CLASSIC_PRIVACY_URL` exigem URLs HTTPS aprovadas. Não colocar chave secreta do RevenueCat nesses arquivos: defines são incorporados ao binário. `.env.test` seleciona configuração; o ambiente de cobrança também depende da instalação StoreKit/TestFlight/conta sandbox. O nome do arquivo não transforma uma conta de produção em sandbox.

`CLASSIC_LEGACY_RIGHTS_JSON` recebe objeto JSON de entitlement auditado para lista de IDs Classic. Configuração ausente/inválida não concede acesso. Depois de editar env, recompilar; não são arquivos carregados em runtime nem assets.

## Matriz de direitos legados

| Evidência na fonte antiga | Destino Classic quando confirmado na auditoria | Estado |
| --- | --- | --- |
| `us_backyard` | `us_backyard` | ID de entitlement real/duração pendentes |
| `us_roadtrip` | `us_roadtrip` | ID de entitlement real/duração pendentes |
| `us_holidays` | `us_holidays` | ID de entitlement real/duração pendentes |
| `game_night_collection` | três categorias acima | Promessa comercial e entitlement pendentes |
| Lifetime não identificado | Somente equivalente auditado | Export RevenueCat/App Store pendente |

Não usar nomes de pacote como prova de entitlement. A tabela orienta a auditoria, sem conceder direitos por hipótese. O contrato suporta o mapping confirmado por ambiente; não se apagam produtos/configurações antigos.

## Evidência local

Validação sobre a árvore de trabalho derivada de `5c186b11c9533f3861abd82858772bbcaa671e13`, com gateway/política registrados no commit `3a133df`; integração e evidências no commit subsequente desta entrega.

- `flutter analyze --no-fatal-infos`: sem erros/warnings; dois infos preexistentes em analytics e setup.
- `flutter test test/classic test/data/purchases`: 57 testes passaram.
- Cobertura: mapping anual/semanal/pacotes; sucesso sem direito, cancelamento, pendência e erro; offline/revogação; direitos legados específicos; restore vazio; preço da loja e gestão; retorno contextual com Confirm; rodada congelada após expiração e revalidação do replay; regressões de sessão e jogo.
- `flutter build ios --simulator --debug -t lib/main_classic.dart --dart-define-from-file=.env.test`: compilou `build/ios/iphonesimulator/Runner.app`; configuração comercial vazia, sem transação real.
- Preview isolado sem SDK: `classicPremiumPreview`, tela 320×640 e texto 200%. O build/teste não substitui inspeção física.

## Roteiro reproduzível e aceite externo

1. Preencher `.env.test` com configuração confirmada e registrar offering, pacote → produto → entitlement, preço, build e revisão Git; omitir chaves dos relatórios.
2. Abrir sem rede/chaves e jogar gratuitamente. Sem CTA comercial automático em Start/replay.
3. Tocar categoria bloqueada, comprar plano anual, retornar ao sheet, verificar rascunho/scroll e confirmar. Repetir semanal com usuário sandbox independente; ambos liberam os mesmos extras.
4. Cancelar compra: nenhum grant. Reproduzir pendência/erro e verificar mensagens/ausência de acesso.
5. Restore com conta vazia, com compra e após reinstalação. Verificar gestão disponível ao assinante.
6. Cancelar renovação, trocar plano, renovar, expirar, reproduzir grace period e reembolso. Confirmar direitos pelo SDK/loja; erro de rede isolado não equivale a expiração.
7. Expirar durante rodada e terminar com os mesmos papéis/palavra. Replay ajusta seleção com aviso; segundo toque inicia rodada válida.
8. Validar cada direito legado auditado com conta correspondente e recompilar mapping confirmado.

Todos os cenários StoreKit acima permanecem **pendentes**, incluindo compra, cancelamento real, pendência, restore/reinstalação, troca de plano, renovação, expiração, grace period, reembolso e lifetime. Não há conta sandbox, export de produtos/direitos nem preços/URLs aprovados disponíveis nesta tarefa. Testes com fakes são evidência alternativa do comportamento local, sem certificar transação real. Cenários não reproduzíveis devem receber evidência alternativa e risco antes do aceite; nunca marcar aprovados por inferência.

Sem alteração de schema de sessão. Recuperação: remover/corrigir defines comerciais e recompilar; gratuito e sessão continuam independentes. Não publicar enquanto configuração legal/comercial e auditoria/sandbox estiverem pendentes.
