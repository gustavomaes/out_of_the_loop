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

---

## 2. Funcionalidades Principais

### 2.1 Criação de Sala / Lobby
- Definir uma categoria (ex: alimentos, filmes, animais, etc.)

### 2.2 Configurar partida

- Definir número de rodadas (padrão: 5)
- Cadastrar nome dos jogadores (é necessário apenas o nome)
- Botão de iniciar partida fica ativo com apenas com 3+ jogadores cadastrados

### 2.3 Distribuição de Papéis (por rodada)

- Sistema escolhe **aleatoriamente** 1 jogador como **"fora"** (out of the loop)
- Os outros jogadores são **"dentro"** (in the loop)
- **Dentro:** recebem a mesma palavra secreta
- **Fora:** recebe apenas uma mensagem informando para ele que ele é o **"fora"** e que deve agir naturalmente

### 2.4 Banco de Palavras e Perguntas

- Mínimo de 20 categorias
- Mínimo de 200 palavras secretas por categorias
- Para cada palavra secreta, deve existir uma lista de:
  - 3–9 perguntas associadas (ex: "Com que frequência você usa isso?") **Minimo de 1 pergunta por jogador cadastrado**

**Estrutura de dados:**

```json
{
  "word": "pizza",
  "category": "comida",
  "questions": [
    "Você gosta de comer isso com as mãos?",
    "Qual a primeira memória que você tem disso?",
    "Isso é mais comum no café da manhã ou jantar?"
  ],
}
```

### 2.5 Fases do Jogo (por rodada)

#### Fase 1 – Revelação dos Papéis

Cada jogador vê na tela:

- Se é **dentro:** palavra secreta + "Você está por dentro"
- Se é **fora:** "Você está FORA do círculo"

#### Fase 2 – Respostas Públicas

- Sistema mostra uma pergunta por vez (tempo opcional: 30s)
- O sistema escolhe um jogador para responder aquela pergunta
- Número de perguntas: **Número de jogadores por rodada**

#### Fase 3 – Discussão / Votação

- Todos votam em quem acham que é o jogador fora
- Cada jogador pode votar uma única vez,
- Voto secreto → ao final, revela total de votos por jogador

#### Fase 4 – Exibição da Pontuação da Rodada

- Mostrar quem era o fora
- Mostrar respostas e votos (resumo)
- Mostrar pontos ganhos por cada jogador nesta rodada

#### Fase 5 – Adivinhação pelo Fora

Se o jogador "fora" não for descoberto:
Deve descobrir ele acha que era a palavra secreta.


### 2.5 Pontuação (regras fixas)

**Jogadores "dentro":**

| Evento | Pontos |
|---|---|
| Votar corretamente no jogador "fora" | +25 |
| A maioria dos jogadores (> metade) votou no fora | +100 (para todos os dentro) |

**Jogador "fora":**

| Evento | Pontos |
|---|---|
| Não foi descoberto pela maioria | +50 |
| Adivinhar a palavra secreta correta no final | +125 |

### 2.6 Progressão de Partida

Ao final de cada rodada:

- Atualiza pontuação total acumulada
- Sorteia novo jogador "fora" para a próxima rodada
- Palavra secreta deve ser diferente da rodada anterior (evitar repetição imediata)

Ao final da última rodada (ex: rodada 5):

- Mostra ranking final com pontuação total
- Botão: "Nova partida" / "Voltar ao lobby"

---

## 3. Fluxo de Telas (UI/UX mínimo)

1. **Tela inicial** – Jogar / Como jogar
2. **Categorias** – Lista de categorias
3. **Tela de papel (preparação)** – Mostra palavra / fora
4. **Tela de pergunta** – Pergunta + jogador que deve responder
5. **Tela de votação** – Nome do Jogador e lista de jogadores, votar em 1. Passar o aparelho para o próximo jogador votar
6. **Tela de resultados da rodada**
7. **Tela de ranking final**

---

## 4. Regras Não-Negociáveis (falhas comuns a evitar)

- O fora **nunca** vê a palavra secreta antes da fase de adivinhação.
- Jogadores dentro **não podem ver** quem é o fora antes da votação (a menos que adivinhem).
- A mesma palavra secreta **não deve se repetir** na mesma partida entre rodadas diferentes.
- O fora **não participa** da fase de adivinhação como se fosse "dentro".
- **Maioria = mais da metade** dos jogadores.
  - Ex: 5 jogadores → maioria = 3 votos no fora.
  - Se todos votarem em pessoas diferentes e ninguém tiver maioria → fora escapa (+50), ninguém ganha +100.

---

## 5. Requisitos Técnicos

### Backend

- SQLite local
- Histórico de palavras por sala para evitar repetição
- Historico de partidas
- Timer global (ex: 30s por resposta/votação)

---

## 6. Exemplo de Rodada (para testes)

**Jogadores:** Ana, Bruno, Carla, Daniel (4 players)  
**Palavra:** "sorvete"  
**Fora:** Daniel

**Perguntas exibidas:**
1. Isso é mais comum no verão ou inverno?
2. Você come isso com colher ou com as mãos?
3. Que sabor você mais gosta disso?

**Respostas (Daniel inventa):**
- "Os dois" *(estranho → levanta suspeita)*

**Votação:**

| Jogador | Voto em |
|---|---|
| Ana | Daniel |
| Bruno | Daniel |
| Carla | Daniel |
| Daniel | Ana |

**Resultado:**
- 3 votos em Daniel → maioria acertou
- Daniel não escapa (sem +50)
- Daniel tenta adivinhar: lista = [sorvete, bolo, pudim, mousse]
- Daniel escolhe "sorvete" → acertou (**+125**)

**Pontuação final da rodada:**

| Jogador | Pontos |
|---|---|
| Ana | +25 +100 = **125** |
| Bruno | **125** |
| Carla | **125** |
| Daniel | **125** |

---

## 7. Observações Finais para o Agente de IA

- ❌ Não desenvolver sistema de login, o app deve rodar totalmente offline com SQLite local lidando com as categorias e palavras.
- ✅ **Prioridade 1:** fazer o fluxo completo de 1 rodada funcionar com 3+ jogadores reais.
- ✅ **Prioridade 2:** sistema de pontuação e regra de maioria.
- ✅ **Prioridade 3:** banco de palavras expansível.
