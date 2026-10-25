# Etapa 7 — experiência completa e observabilidade

Data: 25/10/2026. Implementação técnica entregue na entrada `lib/main_classic.dart`; **em validação** para aceite em aparelho, revisão humana das traduções e configuração de contatos/links. A entrada padrão Guided será substituída na etapa 8. Nenhuma publicação ou configuração comercial foi alterada.

## Entrega

- Settings Coral: idioma en/pt-BR/es/hi/ar em execução, música, efeitos, vibração, suporte, review, termos/privacidade, histórico e acesso a restore/gestão pelo painel Premium, inclusive para assinantes. As ações permanecem em conteúdo rolável.
- Preferências compatíveis `settings.language`, `settings.music`, `settings.soundEffects`; nova chave `settings.haptics` (default ligada). Música default desligada. Reutiliza serviços locais; pause/resume de música segue lifecycle. Efeitos/haptics dos botões Classic respeitam os switches. Falha ao salvar uma preferência exibe mensagem e permite retry, sem apagar a sessão.
- Traduções Classic e Premium explícitas, inclusive recuperação, estados de compra e aviso de mudança de acesso. Idioma da interface é independente do catálogo: rodadas continuam em inglês nesta entrega, com aviso visível; títulos de categorias e palavras seguem o conteúdo inglês. Não anunciar traduções integrais do catálogo Premium.
- Review disponível a todos pela home/settings, via API nativa, sem pergunta de satisfação ou ramificação para feedback. Nenhum pedido automático durante rodada; nenhuma recompensa. Feedback abre e-mail editável independente, sem assunto/corpo preenchido com dados do jogo e sem marcar mensagem como enviada.
- Share iOS via `UIActivityViewController`, ancorado no iPad. O callback distingue concluído/cancelado; em plataformas sem canal nativo, copia apenas o link público. Cópia tem mensagem e evento próprios. Não incluir dados da rodada, destinatários ou URL arbitrária.
- Revelar/ocultar acessível continua disponível sem hold; mudança de métricas (incluindo rotação) oculta imediatamente o cartão. Próximo permanece condicionado a olhar e esconder. Nenhum segredo vai para rotas ou eventos. Classic não adiciona animações de revelação; movimentos Material seguem preferências do sistema. Fallback tipográfico de sistema/emoji no tema.
- Analytics separado do Guided, com contrato restrito e falhas silenciosas. Firebase inicia em paralelo ao app; ausência de rede não bloqueia jogo. Debug desativa coleta Firebase. Classic não instala o encaminhamento de erros Flutter/async brutos do bootstrap Guided ao Crashlytics.

## Configuração antes do aceite externo

Adicionar aos defines já documentados na [etapa 6](STAGE_6.md):

| Define | Valor esperado |
| --- | --- |
| `CLASSIC_APP_URL` | URL HTTPS do app publicado em `apps.apple.com`, com `/id` numérico; nenhum ID foi inventado |
| `CLASSIC_SUPPORT_EMAIL` | Endereço real confirmado pelo proprietário |
| `CLASSIC_TERMS_URL` / `CLASSIC_PRIVACY_URL` | URLs HTTPS finais; continuam exigindo revisão de conteúdo e acessibilidade |

Sem configuração válida, ações mostram indisponibilidade recuperável. Sem app de e-mail ou falha de abertura, suporte permite nova tentativa e não anuncia envio. A API de review pode não mostrar prompt por quota/ambiente; sua chamada não comprova avaliação. Não há backend de feedback nesta entrega.

Não alterar produtos nem usar e-mail/URL de exemplo em release. Conferir declarações de privacidade da loja contra a coleta Firebase/RevenueCat real, incluindo dados automáticos dos SDKs; a restrição de eventos próprios não equivale a ausência total de coleta.

## Verificação reproduzível

- `flutter gen-l10n`: gerados os cinco idiomas e variantes portuguesas.
- `flutter test test/classic test/l10n`: 79 testes passaram, incluindo persistência/migração, Premium, privacidade e novos testes.
- `flutter analyze --no-fatal-infos`: sem erros/warnings nas alterações; apenas infos preexistentes em `analytics_service.dart` e `setup_screens_test.dart`.
- `flutter build ios --simulator -t lib/main_classic.dart`: build do Bundle ID preservado; canal Swift compilado. Build mantém CocoaPods existente; aviso de migração para Swift Packages não é bloqueador desta etapa e não provocou mudança de infraestrutura.
- Instalação/abertura no simulador iPhone 17 / iOS 26.3: home Classic inspecionada. Alguns emojis decorativos aparecem como glifos ausentes nesse simulador, inclusive com fallback tipográfico; os rótulos textuais permanecem legíveis. Registrar conferência/correção visual antes do RC. Isso não substitui testes físicos nem valida share/avaliação reais.
- `classic_experience_widget_test.dart`: contrato ARB, home/settings/paywall e revelar/ocultar nos cinco idiomas, 320×640 e 1024×768, texto 200%, RTL árabe e rotação com cartão aberto; troca de idioma em tela montada.
- `classic_observability_test.dart`: gravação durável e continuação sem salvar distintas; sem duplicatas em flush/lifecycle; cancelamento e cópia sem evento de share concluído; feedback apenas aberto; review apenas solicitado; áudio/haptics desligados; preferências reabertas; falha de telemetria não bloqueia jogo; funil Premium sem preço/IDs em eventos.
- Previews adicionais em `lib/previews/classic_previews.dart`: Settings 200% e home árabe/iPad 200%, sem persistência ou compras reais.

Revisão validada: `d664965` — `feat(classic): add localized settings, support and safe metrics`. Este relatório é registrado no commit documental seguinte.

## Roteiro de demonstração e aceite pendente

1. `flutter run -t lib/main_classic.dart` com defines reais confirmados. Abrir Settings, alternar idioma e voltar; grupo/configuração permanecem. Encerrar/reabrir e conferir preferências.
2. Em cada idioma, texto 200%, iPhone pequeno e iPad paisagem: rolar até suporte, review, links legais, histórico e Premium. Confirmar que o dock não bloqueia Start. Árabe deve inverter a direção sem alterar a ordem de passagem dos jogadores.
3. Com VoiceOver/TalkBack: iniciar, usar revelar acessível, ouvir papel, ocultar, avançar. Conferir que papel oculto não está na árvore semântica. Rotacionar, interromper gesto, mudar foco, bloquear/desbloquear e abrir multitarefa: cartão deve voltar coberto. Validar preview em aparelho.
4. Música/efeitos/vibração off, movimento reduzido e modo avião: completar rodada e replay. Música deve pausar no background e respeitar preferência ao voltar. Testar rota de áudio/volume no aparelho; widget tests não validam hardware.
5. Share: abrir e cancelar, depois concluir; no iPad conferir popover. Não exibir sucesso no cancelamento. Em plataforma sem canal, conferir cópia do link e evento `share_copied`, sem `share_completed`.
6. Suporte: abrir e-mail, editar, cancelar; app não confirma entrega. Review acessível independentemente da opinião; conferir tentativa com/sem disponibilidade nativa. Validar links finais e falhas offline.
7. Com sink de teste ou Firebase DebugView habilitado explicitamente em build de teste controlado, executar [roteiro de métricas](METRICS.md). Não usar dados reais de jogadores como fixtures de inspeção.

Pendentes: VoiceOver em aparelho; iPad físico/rotação/background/preview; áudio/haptics reais e movimento reduzido; share nativo com cancelamento/conclusão e e-mail sem handler; prompt real quando permitido; revisão linguística humana (sobretudo hindi/árabe), URLs/e-mail finais e inspeção do Firebase no projeto real. Etapas 4 e 6 mantêm suas dependências externas. Não declarar esta etapa concluída comercialmente nem aprovada para publicação apenas pelos testes locais.
