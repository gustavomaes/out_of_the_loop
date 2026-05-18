# PRD – Out of the Loop (Clone / Implementação)

## 1. Visão Geral

| Campo | Detalhe |
|---|---|
| **Nome do Projeto** | Out of the Loop |
| **Tipo** | Jogo de festa / social / party game (3–9 jogadores) |
| **Plataforma** | Android / iOS |
| **Duração média de uma rodada** | 5–10 minutos |
| **Duração de uma partida completa** | 5 rodadas (configurável) |

**Objetivo principal:** Permitir que um grupo aja como "jogadores por dentro" (sabem uma palavra secreta) e um jogador como "fora" (não sabe a palavra). O grupo precisa descobrir quem está fora; o fora precisa se passar por membro do grupo e adivinhar a palavra secreta.

> **Contexto de uso:** O app roda em um único aparelho compartilhado entre todos os jogadores presencialmente.

---

## 2. Funcionalidades Principais

### 2.1 Tela Inicial

- Botão **Jogar**
- Botão **Como Jogar**

### 2.2 Configurar Partida

- Escolher uma categoria (lista com 20 categorias disponíveis)
- Definir número de rodadas (padrão: 5)
- Cadastrar nome dos jogadores (apenas o nome, sem login)
- Botão **Iniciar Partida** fica ativo somente com 3+ jogadores cadastrados

### 2.3 Distribuição de Papéis (por rodada)

- Sistema escolhe **aleatoriamente** 1 jogador como **"fora"** (out of the loop)
- Os outros jogadores são **"dentro"** (in the loop)
- **Dentro:** recebem a palavra secreta
- **Fora:** recebe apenas a mensagem "Você está FORA do círculo — aja naturalmente"

### 2.4 Banco de Palavras e Perguntas

- **20 categorias**, com **30 palavras secretas cada** (600 palavras no total)
- Para cada palavra secreta, deve existir uma lista de **3–9 perguntas associadas**
- Regra: **mínimo de 1 pergunta por jogador cadastrado** na rodada

**Estrutura de dados:**

```json
{
  "word": "pizza",
  "category": "comida",
  "questions": [
    "Você gosta de comer isso com as mãos?",
    "Qual a primeira memória que você tem disso?",
    "Isso é mais comum no café da manhã ou jantar?"
  ]
}
```

---

## 3. Fases do Jogo (por rodada)

### Fase 1 – Revelação dos Papéis

O aparelho é passado de mão em mão. Para cada jogador, o sistema exibe:

- Tela com o nome do jogador e botão **"Visualizar minha palavra"**
- Ao tocar: mostra a palavra secreta (se dentro) ou a mensagem de "fora"
- Botão **"Próximo jogador"** para passar o aparelho
- O sistema define a ordem automaticamente até todos terem visto

> A mecânica é baseada na confiança dos jogadores — não há bloqueio técnico entre visualizações.

### Fase 2 – Respostas Públicas

- Sistema exibe uma pergunta por vez
- O sistema indica qual jogador deve responder aquela pergunta
- O jogador responde em voz alta (sem digitar no app)
- Número de perguntas = **número de jogadores** (máximo 9)
- Timer opcional de 30s por pergunta

### Fase 3 – Votação

- O aparelho é passado de mão em mão
- Cada jogador vê seu nome na tela e escolhe em quem votar (lista de jogadores)
- Cada jogador vota uma única vez
- Voto secreto → ao final, o app revela o total de votos por jogador

### Fase 4 – Exibição dos Resultados da Rodada

- Revelar quem era o jogador "fora"
- Exibir resumo das perguntas e votos
- Exibir pontos ganhos por cada jogador nesta rodada

### Fase 5 – Adivinhação pelo Fora *(somente se o fora não foi descoberto)*

- O jogador "fora" fala em voz alta a palavra que ele acha que é a secreta
- O grupo confirma se acertou ou errou
- O app exibe dois botões: **"Acertou"** / **"Errou"**
- Quem toca no botão pode ser qualquer jogador do grupo

---

## 4. Pontuação (regras fixas)

**Jogadores "dentro":**

| Evento | Pontos |
|---|---|
| Votar corretamente no jogador "fora" | +25 |
| A maioria dos jogadores (> metade) votou no fora | +100 (para todos os dentro) |

**Jogador "fora":**

| Evento | Pontos |
|---|---|
| Não foi descoberto pela maioria | +50 |
| Adivinhar a palavra secreta correta | +125 |

---

## 5. Progressão de Partida

Ao final de cada rodada:

- Atualiza pontuação total acumulada
- Sorteia novo jogador "fora" para a próxima rodada
- Palavra secreta deve ser diferente das rodadas anteriores (sem repetição na mesma partida)

Ao final da última rodada:

- Exibe ranking final com pontuação total
- Botões: **"Nova partida"** / **"Voltar ao início"**

---

## 6. Fluxo de Telas

1. **Tela inicial** – Jogar / Como jogar
2. **Configurar partida** – Escolher categoria, número de rodadas, cadastrar jogadores
3. **Revelação dos papéis** – Passar o aparelho para cada jogador ver sua palavra
4. **Tela de pergunta** – Exibe pergunta + nome do jogador que deve responder em voz alta
5. **Tela de votação** – Passar o aparelho para cada jogador votar
6. **Tela de resultados da rodada** – Revelar fora, votos, pontuação
7. **Tela de adivinhação** *(condicional)* – Botões "Acertou" / "Errou"
8. **Tela de ranking final**
9. **Tela de configurações** – Alteração de idioma

---

## 7. Regras Não-Negociáveis

- O fora **nunca** vê a palavra secreta antes da fase de adivinhação.
- Jogadores dentro **não podem ver** quem é o fora antes da votação (a menos que adivinhem).
- A mesma palavra secreta **não deve se repetir** na mesma partida.
- A fase de adivinhação **só ocorre** se o fora não foi descoberto pela maioria.
- **Maioria = mais da metade** dos jogadores.
  - Ex: 5 jogadores → maioria = 3 votos no fora.
  - Se ninguém atingir maioria → fora escapa (+50), ninguém ganha +100.

---

## 8. Requisitos Técnicos

- **Totalmente offline** — sem login, sem internet
- **SQLite local** para armazenar categorias, palavras e perguntas
- Histórico de palavras por partida para evitar repetição entre rodadas
- Timer global configurável (padrão: 30s por pergunta/votação)

### 8.1 Localização (i18n)

O app deve suportar 4 idiomas, selecionáveis na tela de configurações:

| Idioma | Código |
|---|---|
| Português (Brasil) | `pt-BR` |
| Inglês | `en` |
| Espanhol | `es` |
| Hindi (Indiano) | `hi` |

- O idioma padrão deve ser detectado automaticamente pelo sistema operacional, com fallback para `pt-BR`
- A alteração de idioma é aplicada imediatamente, sem reiniciar o app
- **Todo o conteúdo do app deve ser localizado:** textos de interface, mensagens de fase, botões, categorias, palavras secretas e perguntas
- Cada idioma deve ter seu próprio banco de palavras e perguntas completo (600 palavras × 4 idiomas)

---

## 9. Exemplo de Rodada

**Jogadores:** Ana, Bruno, Carla, Daniel (4 players)
**Categoria:** Comida | **Palavra:** "sorvete" | **Fora:** Daniel

**Perguntas e respostas (em voz alta):**

| Pergunta | Jogador | Resposta |
|---|---|---|
| Isso é mais comum no verão ou inverno? | Ana | "Verão, com certeza" |
| Você come isso com colher ou com as mãos? | Bruno | "Colher" |
| Que sabor você mais gosta disso? | Carla | "Chocolate" |
| Você comeria isso todo dia? | Daniel | "Os dois..." *(levanta suspeita)* |

**Votação:**

| Jogador | Voto em |
|---|---|
| Ana | Daniel |
| Bruno | Daniel |
| Carla | Daniel |
| Daniel | Ana |

**Resultado:** 3 votos em Daniel → maioria acertou → fase de adivinhação não ocorre

**Pontuação da rodada:**

| Jogador | Detalhamento | Total |
|---|---|---|
| Ana | +25 (voto certo) +100 (maioria) | **125** |
| Bruno | +25 +100 | **125** |
| Carla | +25 +100 | **125** |
| Daniel | — | **0** |

---

## 10. Prioridades de Desenvolvimento

- ✅ **Prioridade 1:** Fluxo completo de 1 rodada com 3+ jogadores
- ✅ **Prioridade 2:** Sistema de pontuação e regra de maioria
- ✅ **Prioridade 3:** Banco de palavras completo e expansível
- ❌ Sem sistema de login
- ❌ Sem funcionalidades online ou multiplayer remoto
