# Correção dos emojis Classic

25/10/2026. Corrigido o P2 visual registrado na etapa 8.

Os emojis decorativos dos controles, chips e seletor de categorias agora usam
29 imagens PNG locais do [Twemoji v14.0.2](https://github.com/twitter/twemoji/tree/v14.0.2).
Isso evita depender da renderização de fontes coloridas do sistema, que exibia
quadrados com interrogação no simulador. O sintoma corresponde ao
[problema reportado no Flutter](https://github.com/flutter/flutter/issues/183828);
não foi necessário alterar o SDK nem configurações do simulador.

`ClassicEmojiLabel` mantém o texto localizado separado da imagem, com quebra de
linha, direção RTL e tamanho proporcional à escala de texto. As imagens são
excluídas da semântica: o leitor de tela usa o nome textual do controle. IDs,
palavras e campos emoji do catálogo não mudam. Não há downloads em runtime.

Os gráficos originais, sem modificação, são de Twitter, Inc e colaboradores,
licenciados sob CC BY 4.0. A atribuição, origem e licença completa estão em
`assets/emoji/LICENSE-GRAPHICS.txt` e em Settings → Licenses (rótulo localizado
pelo Material). O registro é feito na entrada de produção.

## Verificação

- `flutter test test/classic`: **76 testes passaram**. Os três testes novos
  decodificam os 29 assets (incluindo sequências ZWJ e variation selectors) e
  verificam layout a 200% em 320×640, tanto LTR como RTL, sem overflow.
- `flutter analyze --no-fatal-infos`: **No issues found**.
- `flutter build ios --simulator`: sucesso pela entrada padrão.
- Instalação sobre o app do simulador iPhone 17 / iOS 26.3: home e seletor de
  categorias inspecionados. Emojis visíveis, coloridos e sem glifos ausentes;
  árvore de acessibilidade contém os rótulos textuais, sem as imagens decorativas.
- `git diff --check`: passou.

Capturas do build corrigido:

- [Home](emoji-fixed-home.jpg)
- [Categorias](emoji-fixed-categories.jpg)

A evidência de release sem assinatura e seus hashes em `stage8-release-inspection.json`
continuam identificando o build anterior à correção. Não representam uma nova
exportação de IPA. As demais pendências comerciais/físicas da etapa 8 permanecem
registradas naquele relatório.
