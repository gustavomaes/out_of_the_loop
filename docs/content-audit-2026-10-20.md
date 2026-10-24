# Auditoria e revisão das perguntas — 20/10/2026

As perguntas dos dois bancos foram reescritas. São 240 palavras, nove perguntas
por palavra e 2.160 registros de pergunta. Todos os IDs, palavras, categorias,
idiomas e metadados originais foram preservados.

| Banco/categoria | Palavras | Perguntas | Textos distintos por idioma |
| --- | ---: | ---: | ---: |
| Comida | 30 | 270 | 270 |
| Filmes | 30 | 270 | 270 |
| Esportes | 30 | 270 | 270 |
| Música | 30 | 270 | 270 |
| Viagem | 30 | 270 | 270 |
| Animais | 30 | 270 | 270 |
| Backyard Hangout | 20 | 180 | 180 |
| Road Trip | 20 | 180 | 180 |
| Holiday Hangout | 20 | 180 | 180 |

O gratuito mantém português brasileiro, inglês, espanhol, hindi e árabe. Os três
pacotes mantêm somente inglês. Total de textos localizados: 8.640. A checagem
conjunta dos dois bancos encontrou zero enunciados repetidos por idioma, inclusive
normalizando caixa, espaços, pontuação e Unicode.

## Critério editorial

Cada palavra tem três situações próprias, escritas nos idiomas do banco. Cada
situação recebe três enfoques diferentes, resultando em nove perguntas: atenção,
erro possível, experiência agradável, conselho a iniciante, primeira decisão,
dificuldade, detalhe despercebido, alternativa a experimentar e lembrança.

A estrutura dos nove enfoques é compartilhada; os enunciados completos e as
situações são específicos. A ausência de textos idênticos não significa que cada
pergunta tenha uma estrutura gramatical inédita. A automação verifica repetição
textual e exposição literal da resposta; coerência, dificuldade e equivalência
linguística continuam sendo critérios editoriais.

Os problemas semânticos encontrados na auditoria inicial foram tratados:

- Bebidas têm contextos de preparo, textura, temperatura e serviço; sem perguntas
  sobre comer com talheres.
- Filmes tratam de narrativa e cenas próprias de cada gênero ou tema; sem
  pressupor que um gênero tenha recebido um Oscar ou tenha uma sequência.
- Música distingue instrumentos, acessórios, estilos, profissionais e eventos.
- Viagem distingue lugares, meios de transporte, documentos e bagagens.
  Passaporte tem contextos de fronteira, proteção e renovação documental.
- Animais têm contextos de comportamento e observação. Não há listas de classes
  que excluam anfíbios ou moluscos.
- Os pacotes usam situações próprias de cada objeto, alimento ou evento;
  contagem regressiva e desfile não são tratados como itens compráveis.

## Fonte e regeneração

- `tool/data/question_contexts.txt`: 240 linhas editoriais, com três situações por
  idioma de cada palavra. Separador de campos: `|`; de situações: `;`.
- `tool/rewrite_content.py`: combina situações e enfoques localizados. Valida
  cobertura, nove perguntas, unicidade e ausência literal da palavra secreta em
  qualquer idioma antes de escrever. Altera somente os campos `text`.
- `tool/regenerate_seed_content.dart`: entrada de regeneração, agora delegando à
  fonte editorial em vez de restaurar os nove modelos genéricos por categoria.
- `tool/expand_seed_questions.dart`: entrada antiga delega à mesma implementação,
  sem voltar a inserir respostas nos enunciados.

Executar `python3 tool/rewrite_content.py` ou
`dart run tool/regenerate_seed_content.dart` na raiz. A entrada Dart também
funciona a partir de outros diretórios. A geração requer Python 3 e usa somente
arquivos locais, sem depender de serviços de tradução.

## Validação

- `python3 tool/audit_content.py --check`: passou; zero erros estruturais e zero
  grupos de enunciados repetidos entre palavras. `--json` fornece o inventário.
- Comparação com os arquivos anteriores: todas as 2.160 perguntas tiveram texto
  alterado; IDs, valores de palavras, campos de localização e metadados intactos.
- 28 testes passaram em `content_seed_test`, `content_editorial_test`,
  `local_content_repository_test`, `packs_controller_test`,
  `round_generation_service_test` e `session_history_test`.
- O teste novo `test/fixtures/content_editorial_test.dart` verifica ambos os
  bancos juntos: nove perguntas por palavra, idiomas originais, IDs estáveis e
  ausência de reutilização textual. Os testes existentes verificam também a
  ausência da palavra secreta nos enunciados e a rotação de rodadas/histórico.

## Diagnóstico anterior à revisão

O gratuito tinha 180 palavras e 1.620 perguntas, mas apenas 54 textos distintos
por idioma: os mesmos nove enunciados eram aplicados às 30 palavras de cada
categoria. Nos três pacotes, havia 60 palavras e 540 perguntas, mas apenas 141
textos distintos; sete perguntas eram compartilhadas pelas 20 palavras de cada
pacote. A checagem anterior apontava 291 grupos repetidos, contando cada idioma.

As palavras Burger, Hot dog, Souvenir, Road trip e Martial arts continuam
existindo em mais de uma categoria ou banco, conforme o catálogo original. Seus
enunciados agora são diferentes em cada contexto. Nenhuma palavra foi removida.

A presença de conteúdo no repositório não confirma publicação nem transações
validadas nas lojas.
