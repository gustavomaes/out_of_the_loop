# DESIGN SYSTEM — OUT OF THE LOOP

> **Versão:** 1.0 · **Data:** 2026-05-18

---

## Visão Geral

**Out of the Loop** é um jogo de festa social onde um jogador fica "fora do loop" e os demais precisam descobrir quem é através de perguntas e votação.

**Personalidade da marca:** Divertida · Misteriosa · Social · Vibrante · Noturna

**Palavras-chave:** `loop` `segredo` `votação` `neon` `festa` `glitch`

---

## 1. Cores

### 1.1 Cores Base (Backgrounds)

| Token | Hex | Uso |
|-------|-----|-----|
| `color-background-primary` | `#0B0B2B` | Fundo principal de todas as telas |
| `color-background-secondary` | `#1A1A3A` | Cards, modais, containers |
| `color-background-tertiary` | `#2C2C54` | Inputs, botões secundários, timer base |

**Regras:**
- Nunca usar fundo branco puro
- Todo conteúdo deve estar dentro de cards com `color-background-secondary`
- A tela principal usa `color-background-primary`

---

### 1.2 Cores Primárias (Ação / Destaque)

| Token | Hex | Uso |
|-------|-----|-----|
| `color-primary-main` | `#FF4D6D` | Botões primários, ícones principais, destaques |
| `color-primary-light` | `#FF758F` | Hover de botões primários |
| `color-primary-dark` | `#C9184A` | Estado pressed/active |

---

### 1.3 Cores Secundárias (Feedback / Timer)

| Token | Hex | Uso |
|-------|-----|-----|
| `color-secondary-main` | `#FFB703` | Timer, ícones especiais, acentos de destaque |
| `color-secondary-light` | `#FFC633` | Hover de elementos secundários |
| `color-secondary-dark` | `#CC9200` | Estados inativos secundários |

---

### 1.4 Cores de Texto

| Token | Hex | Uso |
|-------|-----|-----|
| `color-text-primary` | `#FFFFFF` | Títulos, textos principais |
| `color-text-secondary` | `#B0B3C8` | Labels, descrições, textos auxiliares |
| `color-text-tertiary` | `#6C6F8D` | Versão do app, textos menos importantes |
| `color-text-disabled` | `#3D3D5C` | Textos de elementos desabilitados |

---

### 1.5 Cores de Feedback

| Token | Hex | Uso |
|-------|-----|-----|
| `color-feedback-success` | `#4CAF50` | Acertos, pontuações positivas, "Wins!" |
| `color-feedback-error` | `#E63946` | Votação incorreta, eliminação, erros |
| `color-feedback-warning` | `#FFB703` | Avisos, timers próximos do fim |
| `color-feedback-info` | `#3B82F6` | Informações auxiliares |

---

### 1.6 Bordas e Divisões

| Token | Hex | Uso |
|-------|-----|-----|
| `color-border-default` | `#2E2E4A` | Bordas de cards, inputs, divisões |
| `color-border-focus` | `#FF4D6D` | Estado focus de inputs |

---

### 1.7 Overlays e Efeitos

| Token | Valor | Uso |
|-------|-------|-----|
| `color-overlay-dark` | `rgba(0,0,0,0.6)` | Modais, fundos escuros temporários |
| `color-overlay-glow` | `rgba(255,77,109,0.15)` | Efeito neon suave atrás de elementos |

---

## 2. Tipografia

### 2.1 Fontes

| Token | Valor | Uso |
|-------|-------|-----|
| `typography-fontFamily-primary` | `Poppins` | Todas as interfaces |
| `typography-fontFamily-fallback` | `Inter` | Fallback caso Poppins não carregue |

> **Importante:** Usar `font-display: swap` no carregamento da fonte.

---

### 2.2 Font Weights

| Token | Valor |
|-------|-------|
| `typography-fontWeight-regular` | `400` |
| `typography-fontWeight-semibold` | `600` |
| `typography-fontWeight-bold` | `700` |

---

### 2.3 Heading Styles

#### H1 — Título Principal
```css
font-family: Poppins;
font-weight: 700;
font-size: 32px;
line-height: 120%;
letter-spacing: -0.5px;
color: #FFFFFF;
```
> Uso: "OUT OF THE LOOP", títulos de splash screen

#### H2 — Subtítulo
```css
font-family: Poppins;
font-weight: 600;
font-size: 24px;
line-height: 130%;
color: #FFFFFF;
```
> Uso: "Round 1", "Game Over", "Quem vai jogar?"

#### H3 — Seção
```css
font-family: Poppins;
font-weight: 600;
font-size: 20px;
line-height: 140%;
color: #FFFFFF;
```
> Uso: "Pick a Category", "Como Jogar", "Configurações"

---

### 2.4 Body Styles

#### Body Large
```css
font-family: Poppins;
font-weight: 400;
font-size: 18px;
line-height: 150%;
color: #B0B3C8;
```
> Uso: Descrições longas, textos de instrução

#### Body Default
```css
font-family: Poppins;
font-weight: 400;
font-size: 16px;
line-height: 150%;
color: #B0B3C8;
```
> Uso: Texto normal, nomes de jogadores, categorias

#### Body Small
```css
font-family: Poppins;
font-weight: 400;
font-size: 14px;
line-height: 140%;
color: #B0B3C8;
```
> Uso: Textos auxiliares em cards menores

#### Label
```css
font-family: Poppins;
font-weight: 400;
font-size: 12px;
line-height: 130%;
color: #6C6F8D;
```
> Uso: Versão do app, termos de uso, textos de rodapé

---

### 2.5 Display Styles

#### Timer Display
```css
font-family: Poppins;
font-weight: 700;
font-size: 48px;
line-height: 100%;
color: #FFB703;
```
> Uso: Números do timer (12s, 11s…)

#### Emphasis Text
```css
font-family: Poppins;
font-weight: 700;
font-size: 16px;
line-height: 140%;
letter-spacing: 1px;
color: #FF4D6D;
text-transform: uppercase;
```
> Uso: "TOP SECRET", "SPEAK UP!", mensagens de alerta

---

### 2.6 Button Styles

#### Button Primary Text
```css
font-family: Poppins;
font-weight: 700;
font-size: 18px;
line-height: 100%;
color: #FFFFFF;
text-align: center;
```

#### Button Secondary Text
```css
font-family: Poppins;
font-weight: 600;
font-size: 16px;
line-height: 100%;
color: #FFFFFF;
text-align: center;
```

---

## 3. Espaçamento

> **Regra de ouro:** Usar múltiplos de `4px` sempre.

| Token | Valor | Uso |
|-------|-------|-----|
| `spacing-0` | `0px` | Sem espaçamento |
| `spacing-xs` | `4px` | Entre ícone e texto, padding mínimo |
| `spacing-sm` | `8px` | Entre label e campo, entre elementos inline |
| `spacing-md` | `16px` | Padding padrão de cards, entre linhas |
| `spacing-lg` | `24px` | Entre seções, margem entre cards |
| `spacing-xl` | `32px` | Topo da tela, antes do título principal |
| `spacing-2xl` | `48px` | Margem inferior de telas longas |
| `spacing-3xl` | `64px` | Espaçamento entre seções principais |

---

## 4. Bordas e Arredondamentos

| Token | Valor | Uso |
|-------|-------|-----|
| `borderRadius-none` | `0px` | Casos específicos (não usar em cards) |
| `borderRadius-sm` | `8px` | Inputs, elementos pequenos |
| `borderRadius-md` | `12px` | Cards de player, itens de lista |
| `borderRadius-lg` | `16px` | Cards principais, modais |
| `borderRadius-xl` | `24px` | Containers grandes |
| `borderRadius-full` | `40px` | Botões principais |
| `borderRadius-circle` | `9999px` | Avatares, timers circulares |

---

## 5. Sombras

| Token | Valor | Uso |
|-------|-------|-----|
| `shadow-none` | `none` | Elementos flat |
| `shadow-sm` | `0 2px 4px rgba(0,0,0,0.2)` | Cards leves, elementos sobrepostos |
| `shadow-md` | `0 4px 12px rgba(255,77,109,0.3)` | Botão primário, elementos principais |
| `shadow-lg` | `0 8px 24px rgba(0,0,0,0.4)` | Modais, elementos flutuantes |
| `shadow-glow` | `0 0 8px rgba(255,77,109,0.6)` | Efeito neon, glitch, elementos destacados |

---

## 6. Componentes

### 6.1 Botão Primário

> Uso: Ações principais — PLAY, VOTE, COMEÇAR, DONE ANSWERING

```css
background-color: #FF4D6D;
color: #FFFFFF;
border-radius: 40px;
padding: 12px 24px;
box-shadow: 0 4px 12px rgba(255, 77, 109, 0.3);
font: 700 18px/100% Poppins;
transition: all 0.15s ease;
cursor: pointer;
border: none;
```

| Estado | Estilo |
|--------|--------|
| Hover | `background-color: #FF758F` · sombra intensifica |
| Pressed | `background-color: #C9184A` · `scale: 0.98` |
| Disabled | `opacity: 0.5` · sem sombra · `cursor: not-allowed` |
| Loading | Spinner branco centralizado · texto oculto |

---

### 6.2 Botão Secundário

> Uso: Ações secundárias — CANCELAR, VOLTAR, ADICIONAR JOGADOR

```css
background-color: #2C2C54;
color: #FFFFFF;
border-radius: 40px;
padding: 10px 20px;
font: 600 16px/100% Poppins;
transition: all 0.15s ease;
border: none;
```

| Estado | Estilo |
|--------|--------|
| Hover | `background-color: #3D3D6C` |
| Pressed | `background-color: #1E1E3E` |

---

### 6.3 Botão Outline

> Uso: Ações neutras, VOTE antes da seleção

```css
background-color: transparent;
color: #FF4D6D;
border-radius: 40px;
border: 2px solid #FF4D6D;
padding: 10px 20px;
font: 600 16px/100% Poppins;
```

| Estado | Estilo |
|--------|--------|
| Hover | `background-color: rgba(255, 77, 109, 0.1)` |
| Selected | `background-color: #FF4D6D` · `color: #FFFFFF` |

---

### 6.4 Card de Categoria

> Uso: Tela de seleção de categorias

```
Container (120×120px ou auto)
├── Ícone (32×32px, color-primary-main)
└── Texto (16px bold, #FFFFFF)
```

```css
background-color: #1A1A3A;
border-radius: 16px;
border: 1px solid #2E2E4A;
padding: 16px;
gap: 12px; /* vertical */
```

| Estado | Estilo |
|--------|--------|
| Hover | `border-color: #FF4D6D` · sombra glow |
| Selected | `background-color: rgba(255,77,109,0.13)` · `border-color: #FF4D6D` |

---

### 6.5 Card de Player (Votação)

> Uso: Lista de jogadores para votação

```
Container (horizontal, space-between)
├── Nome do jogador (16px regular, #FFFFFF)
└── Botão VOTE (outline ou primário)
```

```css
background-color: #1A1A3A;
border-radius: 12px;
padding: 12px 16px;
margin-bottom: 8px;
```

**Caso especial "You":**
- Fundo: `rgba(255, 77, 109, 0.1)`
- Texto: `#6C6F8D`
- Botão VOTE: disabled ou "CANNOT VOTE"

---

### 6.6 Timer

#### Versão Circular
```
Container (80×80px, border-radius: 9999px)
├── Fundo: #2C2C54
├── Texto central: 48px bold, #FFB703
└── Borda circular animada: gradiente de #FF4D6D → #FFB703
```
> Uso: Tela de resposta do jogador

#### Versão Barra de Progresso
```
Container (100% width, height: 4px)
├── Fundo: #2C2C54
└── Progresso: linear-gradient(90deg, #FF4D6D, #FFB703)
    width: (tempo_restante / tempo_total) × 100%
```
> Uso: Tela de votação

---

### 6.7 Card de Leaderboard

> Uso: Tela de Game Over

```
Container
├── Header (H2 "LEADERBOARD")
└── Lista de jogadores
    ├── Posição (#1, #2, #3)
    ├── Nome
    └── Pontuação
```

```css
background-color: #1A1A3A;
border-radius: 16px;
padding: 16px;
```

| Linha | Fundo |
|-------|-------|
| Par | `#1A1A3A` |
| Ímpar | `#23234A` |

**Destaque do vencedor:** Ícone troféu `24px #FFB703` · Nome em `#FFB703` · Pontuação em `#4CAF50`

---

### 6.8 Input de Texto

> Uso: Adicionar nome do jogador, buscar categorias

```css
background-color: #2C2C54;
border-radius: 12px;
border: 1px solid #2E2E4A;
padding: 12px 16px;
color: #FFFFFF;
font: 400 16px/150% Poppins;
width: 100%;
```

| Estado | Estilo |
|--------|--------|
| Focus | `border-color: #FF4D6D` · `box-shadow: 0 0 0 2px rgba(255,77,109,0.2)` |
| Placeholder | `color: #6C6F8D` |

---

### 6.9 Avatar do Jogador

> Uso: Miniaturas, listas de jogadores ativos

```css
width: 40px;
height: 40px;
background-color: #FF4D6D;
border-radius: 9999px;
display: flex;
align-items: center;
justify-content: center;
color: #FFFFFF;
font: 700 16px/1 Poppins;
```

> Fallback: Iniciais do nome (máximo 2 letras)

---

## 7. Layouts Específicos

### Splash Screen / Start Game
- Título centralizado "OUT OF THE LOOP" com efeito glitch/neon
- Botão "START GAME" centralizado
- Link "HOW TO PLAY" no rodapé

### Tela de Categorias
- Header com logo reduzido
- Subtítulo "Pick a Category"
- Grid de categorias (2–3 colunas conforme viewport)
- Botão "PLAY" fixo no rodapé
- Navegação inferior: **PLAY · CATEGORIES · PROFILE**

### Tela de Jogadores
- Título + contador `3–9 JOGADORES`
- Lista com toggle **IN / OUT** por jogador
- Input + botão para adicionar novo jogador
- Botão "COMEÇAR JOGO" ativo somente com ≥ 3 jogadores

### Tela Top Secret
- Fundo escuro sólido com ruído sutil opcional
- Texto "TOP SECRET" com efeito glitch
- Ícone de olho ou cadeado
- Instrução: *"Make sure nobody else is looking at your screen."*

### Tela de Resposta (Turno do Jogador)
- "Player X's Turn" (H2)
- "?" grande e centralizado — `64px bold #FFB703`
- Pergunta (H3 centralizado)
- Timer circular
- Botão "DONE ANSWERING"

### Tela de Votação
- "WHO IS OUT OF THE LOOP?" (H2)
- Subtítulo explicativo
- Lista de cards de player com botões VOTE
- Timer em barra de progresso
- Botão "CONFIRM VOTES" ativo somente após todos votarem

### Tela Game Over
- "GAME OVER" (H1)
- Nome do vencedor + badge "THE MASTERMIND" ou "OUT OF THE LOOP"
- Palavra secreta revelada em card especial
- Leaderboard
- Botão **PLAY AGAIN** (primário) + **BACK TO HOME** (secundário)

### Tela How to Play
Quatro seções com ícones:

| Ícone | Título | Conteúdo |
|-------|--------|---------|
| 🔥 | O SEGREDO | Descrição |
| 🎯 | A PERGUNTA | Descrição |
| 🔴 | A VOTAÇÃO | Descrição |
| 🟢 | O DESFECHO | Descrição |

> Cada seção: ícone + título (H3) + descrição (body). Botão "ENTENDI!" no final.

### Tela de Configurações
- Seções: **TEMA · IDIOMA · ÁUDIO · SOBRE**
- Toggle para tema (Claro/Escuro — apenas Escuro implementado)
- Select/Radio para idioma
- Switches para Música e Efeitos Sonoros
- Links para Termos e Privacidade
- Versão do app (label)

### Tela de Premium (VIRE PRO)
- "VIRE PRO" (H1 com gradiente)
- Subtítulo: *"A experiência definitiva de festa."*
- Feature cards: REMOVA ANÚNCIOS · LIBERE TODAS AS CATEGORIAS

| Plano | Período | Preço |
|-------|---------|-------|
| FESTA RÁPIDA | Mensal | R$ 14,90/mês |
| MAIS POPULAR | Anual | R$ 89,90/ano |
| MELHOR VALOR | Vitalício | R$ 199,90 |

---

## 8. Animações e Transições

### 8.1 Durações

| Token | Valor | Uso |
|-------|-------|-----|
| `duration-fast` | `150ms` | Hover, focus, micro-interações |
| `duration-normal` | `300ms` | Mudanças de tela, modais |
| `duration-slow` | `500ms` | Animações de vitória, confetes |

### 8.2 Easing

| Token | Valor | Uso |
|-------|-------|-----|
| `easing-default` | `cubic-bezier(0.4, 0, 0.2, 1)` | Uso geral |
| `easing-bounce` | `cubic-bezier(0.68, -0.55, 0.265, 1.55)` | Elementos divertidos |

### 8.3 Animações Específicas

#### Efeito Glitch (texto "TOP SECRET")
- Repetir o texto com deslocamentos RGB
- Duração: `0.3s`, loop infinito
- Keyframes: deslocamento horizontal de `2px`

#### Timer Finalizando
- Quando restar ≤ 5s: cor muda de `#FFB703` → `#E63946`
- Pulsar suavemente

#### Vitória
- Confetes (canvas ou SVG)
- Texto do vencedor: escala `0.8 → 1.2 → 1.0`

#### Transição entre Telas
- Fade in/out (`opacity: 0 → 1`)
- Duração: `300ms`

---

## 9. Grid e Breakpoints

### 9.1 Breakpoints

| Dispositivo | Largura |
|-------------|---------|
| Mobile | `375px` |
| Mobile large | `425px` |
| Tablet | `768px` |
| Desktop | `1024px` |
| Wide | `1440px` |

### 9.2 Grid Desktop

| Propriedade | Valor |
|-------------|-------|
| Colunas | 12 |
| Gutter | `24px` |
| Margem lateral | `32px` |

### 9.3 Grid Mobile

| Propriedade | Valor |
|-------------|-------|
| Colunas | 4 |
| Gutter | `16px` |
| Margem lateral | `16px` |

---

## 10. Acessibilidade

### Contraste

| Par de cores | Contraste |
|---|---|
| `#0B0B2B` / `#FFFFFF` | ≥ 15:1 ✅ |
| `#1A1A3A` / `#FFFFFF` | ≥ 12:1 ✅ |
| `#FF4D6D` / `#FFFFFF` | ≥ 4.5:1 ✅ |

### Foco
```css
outline: 2px solid #FFB703;
outline-offset: 2px;
```

### Touch Targets (Mobile)
- Botões: mínimo `44×44px`
- Espaçamento entre touch targets: mínimo `8px`

### Texto
- Evitar `text-align: justify`
- `line-height` mínimo de `1.4` para textos longos
- Permitir zoom até `200%` sem quebrar o layout

---

## 11. Regras Gerais de Implementação

- **Nunca usar cores fixas** — sempre usar tokens do design system
- **Evitar fundo branco** a todo custo
- O termo **"Out of the Loop"** sempre em caixa alta quando for título
- **Timers são críticos** — garantir precisão e feedback visual claro
- **Votação deve ser anônima** — não mostrar quem votou em quem
- **Estado de loading** em todas as ações de rede
- **Mobile first** — adaptar para tablet/desktop mantendo legibilidade
- Feedback sonoro é opcional, nunca essencial para o gameplay

---

## 12. Histórico de Versão

| Versão | Data | Alterações |
|--------|------|------------|
| 1.0 | 2026-05-18 | Criação inicial do design system baseado nas telas do Out of the Loop |
