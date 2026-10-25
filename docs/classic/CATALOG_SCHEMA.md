# Catálogo Classic — schema 1

Fonte editável: `assets/content/classic_catalog.json`. Bundle offline gerado: `lib/src/data/classic/classic_catalog.g.dart`. O runtime não lê os bancos Guided nem depende de carregamento de assets/rede para iniciar uma rodada.

- `schemaVersion`: inteiro 1; versões desconhecidas são recusadas.
- `catalogVersion`: revisão editorial independente da versão de schema (`classic-1`). Alterar ao publicar mudanças de conteúdo.
- `editorialStatus`: `human-review-pending` nesta entrega; não equivale a aprovação comercial.
- `categories`: IDs únicos, `name`, `emoji`, `premium`, `words` e `paywallExampleIds`.
- `words`: `id` global estável, `value` por idioma e bool `commercialExample`. Inglês obrigatório; traduções opcionais declaradas individualmente. Perguntas não pertencem a este schema. Textos vazios, duplicatas no mesmo idioma/categoria e referências inválidas são recusados.
- `paywallExampleIds`: referências aos exemplos reais; flags correspondentes verificadas pelo checker. Nas 20 categorias Premium, os cinco exemplos correspondem ao protótipo. São excluídos das primeiras cinco rodadas da categoria pelo seletor existente.
- `legacyWordIds`: origem `idioma:categoria:id` → destino `idioma/categoria/idClassic`; todos os 960 valores localizados dos dois bancos antigos estão preservados com texto exato. O conversor remove perguntas e mantém referências. Não cria nem concede entitlements comerciais.

## Atualizar e conferir

```sh
python3 tool/classic_convert_legacy.py > /tmp/classic-legacy.json
python3 tool/classic_catalog.py
python3 tool/classic_catalog.py --check
flutter test test/classic test/data/content test/fixtures
flutter analyze --no-fatal-infos
```

O checker valida metas, traduções gratuitas, equivalência legada, exemplos e sincronização do bundle/relatório. O parser Dart aplica o contrato no runtime. Revisão humana continua necessária para semântica, traduções, faixa etária e adequação cultural.

## Contagens e idiomas

Existem 959 entradas em categorias e 920 textos ingleses distintos (comparação sem diferença entre maiúsculas/minúsculas): 120 grátis e 800 adicionais exclusivos do Premium. Traduções não aumentam a contagem. Reutilizações entre categorias aparecem no relatório e não aumentam o total distinto. Homônimos, como Apple/fruta e Apple/marca, também não aumentam esse total conservador.

As três categorias gratuitas têm 40 entradas em en/pt-BR/es/hi/ar. Movies & TV, Music & Bands e Countries & Cities conservam as 30 traduções legadas em cada idioma, mas seus acréscimos são inglês somente. As outras 17 categorias Premium são inglês somente. A interface Classic continua usando conteúdo inglês por padrão; seleção e consentimento de idioma da oferta pertencem às próximas integrações. Não substituir silenciosamente palavras ausentes por inglês ao pedir outro idioma.

O relatório `catalog-report.json` apresenta cobertura e pendências por categoria. A lista JSON é o roteiro de revisão editorial: conferir valores, ambiguidades, sinônimos, domínio da categoria e familiaridade com público americano. O conteúdo herdado inclui associações amplas (por exemplo, cinema e viagem), que exigem essa revisão.

## Migração e recuperação

A chave de sessão continua `classic.session.v1`, sem apagar `game.session.v1`. O mapping completo vale para instalações migradas a partir desta entrega. Quem já migrou em uma etapa anterior não tem seu histórico reconstruído novamente; a fonte Guided permanece preservada, e referências anteriormente descartadas não são inventadas no histórico.

Snapshots carregados mantêm a versão e o texto congelado da rodada. Ao criar a próxima rodada, o controlador grava a versão atual do catálogo. Não renomear IDs publicados para alterações editoriais; texto congelado permite terminar rodadas mesmo com mudança de catálogo. Se o checker falhar, corrigir a fonte e regenerar; não editar o bundle manualmente.

Direitos de compra continuam sob responsabilidade do gateway/política de acesso da etapa 6. Esta entrega preserva todo o conteúdo antigo e seu mapping; não certifica restore nem auditoria de entitlements reais.
