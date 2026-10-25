# Etapa 4 — persistência, migração e retomada

Status: implementação entregue em 25/10/2026; **em validação**, com aceite de atualização e interrupções em aparelho físico pendente. Base: `1c1579e` (etapa 3); implementação e testes: `9c8b6d7`. Commits e push na `main` autorizados pelo proprietário.

## Artefato

Executar `flutter run -t lib/main_classic.dart`. A entrada Classic agora inicializa armazenamento offline; `lib/main.dart` continua no fluxo anterior até a etapa 8. Sem bootstrap de Firebase, rede ou compras na demonstração.

- `ClassicSessionRepository`: envelope JSON `classic.session.v1`, schema 1, revisão, versão do catálogo, configuração, histórico e snapshot opcional. Cada gravação captura seu estado antes de entrar na fila, aguarda a anterior e verifica o conteúdo por releitura. Falha não impede retries posteriores.
- Snapshot congela jogadores/configuração, ID, palavra localizada, categoria localizada, impostores, iniciador, Troll, fase, índice e tempo restante. A restauração não consulta o catálogo atual para concluir a rodada, não sorteia novamente e nunca restaura visibilidade ou confirmação de visualização. O timer sempre retorna pausado.
- Validação de schema, configuração, IDs, papéis, fase, índice, duração e consistência entre configurações. Snapshot inválido recupera configuração e histórico independentemente quando válidos. JSON inválido oferece recuperação; schema futuro oferece retry ou jogo temporário sem substituir o envelope desconhecido.
- `ClassicSessionHost`: S09 (Resume/End round sem segredo), S20 (confirmação de descarte da rodada e de limpeza do histórico) e S21 (retry/nova partida ou continuação explícita após falha). Encerrar mantém grupo/configuração/histórico. Limpar histórico mantém grupo/configuração. Nenhuma dessas operações acessa ou limpa direitos de compra.
- Transições de configuração, criação, passagem de jogador, discussão, pausa, resultado e encerramento são persistidas. Durante a gravação, a UI cobre e bloqueia a interação com a rodada. Escrita com erro pausa o relógio e exige retry ou continuação explícita, com aviso persistente de possível retorno à última transição salva. Uma gravação posterior bem-sucedida remove o aviso.
- Lifecycle mantém a proteção da etapa 3: perda de foco/background cobre o cartão, invalida a visualização e pausa/persiste tempo. Os observadores da rodada continuam montados durante as gravações. Retorno não reinicia o timer nem abre cartão.
- Preferência de idioma existente orienta a interface na entrada Classic; chaves existentes de idioma e áudio permanecem intactas. Conteúdo jogável continua apenas em inglês nesta etapa; idiomas da interface e do catálogo são independentes. Áudio/haptics completos pertencem à etapa 7.
- Textos en/pt-BR; es/hi/ar mantêm fallback inglês até a etapa 7. Previews de retomada/recuperação em 320×640 e texto 200% ficam em `lib/previews/classic_previews.dart`, com repositório em memória isolado das preferências nativas.

## Migração e recuperação

Na ausência de envelope Classic, `game.session.v1` versão 1 é migrado. Nomes válidos de grupos com 3–20 jogadores recebem IDs locais; sem grupo válido usa-se o grupo default. Regras Guided sem equivalente (perguntas/placar/número de rodadas) não entram no Classic. O legado não contém partida ativa completa: nenhuma é inventada.

`classic_legacy_migration.dart` contém 31 equivalências explícitas de IDs ingleses dos dois assets antigos para o catálogo inicial Classic. Palavras vistas mapeadas mantêm recência; referências sem equivalência são contabilizadas no diagnóstico local `migration.unmappedWords`, sem registrar nomes ou palavras em logs. Conteúdo sem equivalência no catálogo inicial não é apresentado como migrado. A fonte antiga permanece intacta para ampliar o mapping na etapa 5, inclusive para idiomas ainda sem conteúdo Classic. Não há alteração em produtos, entitlements ou compras.

O novo envelope só marca a migração como concluída depois de gravado e validado por releitura. Reabrir usa o envelope e não importa nomes/histórico novamente. Falha de escrita preserva a fonte e os dados recuperados em memória para retry. Preferências originais não são apagadas.

Um save de versão futura fica preservado mesmo após aceitar uma partida temporária; atualizar para uma versão compatível é a recuperação recomendada. Não há downgrade automático. Em schema atual danificado, Nova partida exige confirmação antes de substituir o snapshot. Nunca apagar todas as SharedPreferences como solução de recuperação.

O envelope contém segredos locais: não anexar seu JSON a suporte, analytics, crash reports ou evidências. Usar apenas fase/revisão/resultado de validação sem conteúdo sensível. SharedPreferences pode concluir uma chamada antes da durabilidade física no disco: a fila e a releitura não prometem transação ou garantia contra encerramento abrupto do sistema. A UI informa a limitação quando detecta falha. Referência: [documentação oficial do plugin](https://pub.dev/packages/shared_preferences).

## Evidências e comandos

| Critério | Evidência |
| --- | --- |
| Reiniciar em revealing, discussion e result, mesmos IDs/papéis/palavra/iniciador | `classic_session_test.dart`: recriação de controlador a partir do envelope em cada transição; visualização sempre falsa e timer parado |
| Timer pausado conserva restante | Relógio injetado: 180 s → 157 s, background → restaurar com 157 s, sem descontar tempo do processo morto |
| Migração uma vez e fonte preservada | Fixture Guided v1; segunda carga não executa migrador; falha injetada mantém fonte para retry |
| Escritas sequenciais/falha/retry | Primeira escrita bloqueada e falha; segunda/terceira concluem em ordem; revisão final 3 |
| Corrupção/schema futuro | Fixture com índice fora do grupo, JSON quebrado e versão 99; leitura não substitui fonte; campos válidos recuperados separadamente |
| Mudança de catálogo | Snapshot de catálogo/palavra removidos termina usando conteúdo localizado congelado |
| Encerrar/reset/replay | Encerrar elimina só snapshot; reset elimina só histórico; replay não repete ID e rejeita duplo toque |
| S09/S20/S21 | `classic_session_host_test.dart`: destruir árvore, reabrir, Resume coberto, Next desabilitado, End com confirmação, recuperação/falha e aviso de continuação |
| Layout pequeno/texto ampliado | Recuperação com rolagem em 320×640 e texto 200%, sem exceções de layout; previews adicionais |
| Atualizar instalação existente sem desinstalar | iPhone 17, iOS 26.3, simulador: `simctl install` sobre app existente; `settings.language=en` e `onboarding.completed=true` preservados; abertura Classic confirmada |
| Encerrar e reabrir processo real | Simulador: Start → snapshot revealing índice 0 revisão 1 → `simctl terminate`/`launch` → S09 → Resume → mesmo jogador, cartão coberto e Next desabilitado. Comparação local: snapshot e histórico idênticos antes/depois |
| Atualização real de versão publicada e interrupções em todas as fases em aparelho físico | **Pendente**: `xcrun xctrace list devices` não encontrou aparelho físico. A origem da instalação anterior no simulador não foi comprovada como versão de loja |

Validação no código da etapa:

- `flutter gen-l10n`: passou.
- `flutter analyze --no-fatal-infos`: passou, somente os dois infos preexistentes em analytics e testes de setup.
- `flutter test test/classic test/domain test/data test/l10n`: **106 testes passaram**.
- `flutter build ios --simulator --debug -t lib/main_classic.dart`: passou; Bundle ID mantido. Aviso preexistente sobre integração CocoaPods/Swift Packages, sem migração de infraestrutura nesta etapa.
- `git diff --check`: passou.

## Roteiro de aceite físico pendente

1. Instalar uma versão anterior identificada, sem desinstalar, com nomes, idioma, áudio e palavras vistas conhecidos. Registrar versão/build e preferências esperadas sem expor dados pessoais.
2. Atualizar para o build Classic identificado. Conferir nomes, idioma/áudio e recência mapeada; reabrir e confirmar que a migração não reaplica dados antigos. Conferir direitos com SDK/configuração comercial auditados na etapa 6.
3. Iniciar, visualizar papel e interromper o processo durante revealing; repetir após Next, discussão com timer e resultado. Reabrir: S09 sem segredo, mesmos papéis/palavra/iniciador/Troll, índice confirmado, cartão coberto e timer pausado. Next exige nova visualização.
4. Encerrar pela retomada e cancelar/confirmar: cancelar conserva a rodada; confirmar remove só a rodada. Na home, limpar histórico com confirmação e conferir grupo/configuração preservados.
5. Testar background/app switcher, perda de foco, teclado/VoiceOver e morte do processo após transição concluída. Verificar cobertura nativa e retomada segura. Falhas/catálogo alterado/schema futuro têm cenários automatizados reproduzíveis nos testes; validar no build físico apropriado antes do aceite.

Não foram validados build de distribuição, atualização de uma instalação da loja, durabilidade física sob interrupção de energia, todas as fases via processo nativo, VoiceOver físico, Android ou transações comerciais. A etapa permanece em validação; implementação local não equivale a aceite de release.
