# Etapa 5 — catálogo Classic

25/10/2026 · **em validação** · base Git `4067199` · implementação `07e45be` · entrada `lib/main_classic.dart`.

Implementação técnica entregue; revisão humana editorial/traduções e validação cultural americana permanecem pendentes. Esta entrega não autoriza comercialização nem certifica compras reais.

## Artefatos e aceite

| Critério | Evidência | Estado |
| --- | --- | --- |
| 3 categorias grátis e 20 Premium | Fonte JSON, parser e testes; mínimo de 40 entradas por categoria | Implementado |
| Meta de 120 grátis + 800 Premium | 920 textos ingleses distintos; 959 entradas em categorias; traduções e repetições entre categorias não aumentam a meta | Verificado automaticamente |
| Schema sem perguntas, IDs únicos, valores não vazios | `classic_catalog_parser.dart`, checker e casos negativos | Verificado automaticamente |
| Mapping/conversão antigos | 240 conceitos legados / 960 referências localizadas preservadas, incluindo todos os 60 conceitos dos packs US | Verificado automaticamente |
| Exemplos comerciais reais | Cinco exemplos por categoria Premium conferidos contra `subscription-catalog.js`; flags excluídas das primeiras cinco rodadas por categoria | Verificado automaticamente |
| Recência e reciclagem | Testes percorrem todas as palavras de cada categoria sem repetição, depois reciclam sem repetição imediata | Verificado automaticamente |
| Cobertura de idiomas | 120 grátis nos cinco idiomas; tradução legada parcial em movies/music/travel; demais Premium somente inglês | Inventariada no relatório |
| Acesso a conteúdo comprado | Conteúdo e equivalências preservados; entitlement, restore e política efetiva de compra são etapa 6 | Aceite comercial pendente |
| Ambiguidade, adequação etária e referências culturais | Roteiro por categoria no relatório; nenhum revisor humano ou grupo americano foi consultado nesta execução | Pendente |

A contagem de 920 usa textos ingleses distintos, sem diferenciar maiúsculas/minúsculas. Isso evita inflar o total com traduções, homônimos ou repetições literais entre categorias, mas não certifica equivalência semântica. Sinônimos e associações amplas herdadas precisam de revisão humana. Não apresentar o catálogo como validado com público americano.

## Verificação executada

- `python3 tool/classic_catalog.py --check`: passou; bundle e relatório correspondem à fonte, metas, idiomas, mapping, exemplos e referências válidos.
- `python3 tool/classic_convert_legacy.py > /tmp/classic-legacy.json`: passou; conversão sem perguntas.
- `flutter test test/classic test/data/content test/fixtures`: **56 testes passaram** antes da ampliação final para não contar repetições entre categorias.
- `flutter test test/classic test/l10n`: **52 testes passaram** com o catálogo final ampliado e os textos da galeria atualizados.
- `flutter analyze --no-fatal-infos`: passou, sem erros/warnings; dois infos preexistentes em `analytics_service.dart` e `setup_screens_test.dart`. Executado novamente após os ajustes finais.
- `git diff --check`: passou.

Os bancos Guided não foram alterados. Não houve build/distribuição nativa, transação de compra, teste físico ou revisão editorial humana nesta etapa. O Premium da entrada de desenvolvimento continua fake e identificado.

## Demonstração reproduzível

1. Executar os comandos de verificação acima.
2. Abrir `flutter run -t lib/main_classic.dart` e selecionar as três categorias grátis: há 120 conceitos disponíveis em inglês.
3. Iniciar, revelar/ocultar os três papéis, avançar à discussão, confirmar o resultado e jogar novamente. As rodadas usam o catálogo atual e mantêm recência.
4. Em nova configuração, abrir Categorias, tocar em uma categoria bloqueada e habilitar **Premium demo**. Confirmar uma categoria Premium e iniciar uma rodada: agora há conteúdo real em todas as 20 categorias.
5. O teste `classic_catalog_test.dart` verifica cada categoria inteira, exemplos fora das primeiras cinco rodadas, reciclagem, contagens, rejeição de catálogo inválido e equivalência de todas as traduções legadas.
6. Para revisão humana, abrir a fonte por categoria e conferir os tópicos listados em `catalog-report.json`; registrar responsável, alterações e resultado antes de alterar `editorialStatus`.

## Schema e recuperação

Ver [contrato, idiomas, atualização e migração](CATALOG_SCHEMA.md). A sessão mantém schema 1. Rodadas restauradas conservam palavra e versão congeladas; a próxima rodada registra `classic-1`. O mapping completo não repete automaticamente migrações já concluídas, nem reconstrói referências que versões anteriores descartaram. O JSON Guided original permanece intacto.
