# Etapa 1 — base Classic e Coral Social

Status: concluída em 25/10/2026, com validação automatizada e previews reproduzíveis.
Base de implementação: `2150a10` (etapa 0). Código validado no commit `f8c01e7`. Integração na `main` solicitada pelo proprietário; a entrada pública permanece Guided até a etapa 8.

## Artefato e fronteiras

- `lib/main_classic.dart`: entrada de desenvolvimento offline. Não executa bootstrap Firebase nem inicializa compras, preferências ou rede.
- `domain/classic/classic_models.dart`: jogador com ID estável, configuração imutável, fases e palavra sem perguntas. Limites de grupo, Auto/manual e timer validados em Dart puro.
- `ClassicController`: recebe catálogo e configuração por construtor; rejeita alterações inválidas ou sem conteúdo disponível sem alterar estado. A galeria consome configuração e catálogo, inclusive atualização de hint.
- `ClassicContentRepository`: três palavras em inglês, uma por categoria gratuita, com IDs `fixture.*`. Material explicitamente experimental; não satisfaz o catálogo editorial da etapa 5.
- `classic_components.dart`: tokens do protótipo, tema Coral, botão, card, switch e sheet rolável com SafeArea e inset de teclado. Botões têm altura mínima 54; switch mantém alvo Material acessível. Loading bloqueia ação; erros têm anúncio semântico. Estados desabilitados não disparam callbacks.
- Textos da galeria nos ARBs existentes en/pt-BR/es/hi/ar; localização gerada pelo fluxo atual do projeto. Idioma de conteúdo da fixture permanece inglês.
- Nenhum contrato de persistência, sorteio, relógio ou billing criado antecipadamente sem consumidor. Rodada, histórico e snapshot serão implementados nas respectivas etapas.

## Demonstração reproduzível

1. Executar `flutter run -t lib/main_classic.dart` com rede indisponível. Esperado: galeria Classic abre com indicação de fixture e contagem 3 jogadores / 3 palavras.
2. Alternar hint; o estado muda. Switch desabilitado não muda.
3. Abrir o sheet e fechar pelo botão localizado ou gesto. Nenhuma rodada é criada.
4. Rolar até o fim: botão desabilitado da etapa 3, loading e erro/retry estão acessíveis.
5. Executar `flutter widget-preview start` e selecionar o grupo Classic em `lib/previews/classic_previews.dart`: largura 320, texto normal e 200%. Também é possível executar a entrada no emulador com texto ampliado.

## Validação

- `flutter gen-l10n`: passou.
- `flutter analyze --no-fatal-infos`: passou; dois infos preexistentes em analytics_service.dart e setup_screens_test.dart, fora do escopo.
- `flutter test test/classic test/domain test/data`: 62 testes passaram (4 Classic + 58 anteriores).
- Widgets a 320×640, texto 100%/200%: alternância, rolagem, abertura/fechamento do sheet e ausência de exceções de layout.
- `git diff --check`: passou.
- Domínio Classic importa apenas Dart, sem Flutter/SDKs.

Sem mudança de schema persistido ou configuração nativa; recuperação consiste em voltar à entrada `lib/main.dart`. Não houve teste físico, inspeção manual do previewer, build de distribuição ou validação comercial nesta etapa. Os previews estão disponíveis; a geometria foi validada pelos testes de widgets. Nenhum desses testes representa aprovação de lançamento.
