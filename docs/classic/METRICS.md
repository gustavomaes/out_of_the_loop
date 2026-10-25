# Classic — coleta e leitura de métricas

## Contrato próprio

`ClassicAnalytics.record()` só aceita `ClassicEvent` e enums opcionais `ClassicOrigin`, `ClassicPlan`, `ClassicOption`. Não aceita mapas arbitrários. O sink injetável recebe o resultado fechado para teste. Eventos têm prefixo `classic_`, separados dos eventos Guided.

Parâmetros permitidos, sempre valores enumerados:

| Chave | Valores |
| --- | --- |
| `origin` | `home`, `categories`, `settings`, `result` |
| `plan` | `annual`, `weekly` (omitido quando período não identificado) |
| `option` | `players`, `categories`, `impostors`, `hint`, `timer`, `troll` |

Não coletar nomes, IDs locais de jogadores/rodadas, papéis, impostores identificáveis, palavras, histórico, texto de feedback, destinatários, URL/e-mail, snapshots, IDs de produto/entitlement, preço bruto ou exceções/stack traces. Trocar nomes registra apenas `option=players`, sem os valores anteriores/novos. As exceções de SDK/storage/áudio não atravessam esse contrato.

| Eventos (`classic_` + sufixo) | Gatilho e significado |
| --- | --- |
| `setup_viewed` | Montagem real da home, não rebuild |
| `setup_option_changed` | Configuração válida confirmada; somente opção alterada |
| `round_started` | Rodada criada em memória; **não** prova durabilidade |
| `round_saved` | Primeira gravação validada por releitura da rodada nova; uma vez por rodada na instância; snapshot restaurado não gera novo início salvo |
| `round_unsaved` | Entrada sem repository ou consentimento explícito para continuar após erro; uma vez por rodada na instância |
| `persistence_failed` | Primeiro erro de um episódio de falha; retry falho não duplica |
| `discussion_started` | Último cartão visualizado e coberto confirmado |
| `round_completed` | Resultado explicitamente revelado; não comprova diversão/votação |
| `replay_started` | Nova rodada criada a partir do resultado |
| `round_ended` | Saída explícita para configuração |
| `game_resumed` | Aceite explícito da retomada; resume de sistema não duplica |
| `paywall_opened` / `paywall_dismissed` | Apresentação/fechamento do sheet por origem; rebuild não é nova impressão |
| `plan_selected` / `purchase_requested` | Escolha e início da operação, por origem/plano |
| `purchase_verified` | SDK devolveu entitlement Premium configurado após compra |
| `purchase_cancelled` / `purchase_pending` / `purchase_failed` | Estados normalizados; sucesso de CTA não concede direito |
| `entitlement_changed` | Refresh mudou o conjunto de direitos, sem transmitir seus IDs |
| `restore_requested` / `restore_found` / `restore_empty` / `restore_failed` | Restore explícito; encontrado significa direitos retornados, inclusive legado; não necessariamente Premium completo |
| `share_requested` / `share_completed` / `share_cancelled` | Pedido e callback nativo; sem destinatários |
| `share_copied` | Fallback copiou link; não é prova de compartilhamento |
| `feedback_opened` | Handler de e-mail abriu; **nenhum** `feedback_submitted` é emitido |
| `review_requested` | Tentativa de API; **nenhum** evento de avaliação concluída |

Durabilidade: uma rodada inicialmente sem salvar pode mais tarde gerar `round_saved` após retry bem-sucedido; não somar as duas séries como populações exclusivas. Eventos não são uma fila transacional persistente: sem Firebase disponível (inclusive antes de terminar sua inicialização) ou ao matar o processo, podem se perder; a fila offline própria do SDK depende da inicialização ter ocorrido. A deduplicação local evita rebuild/retomada duplicarem ações; não promete exatamente uma entrega global pelo SDK.

## Coleta e limites

A entrada Classic inicializa Firebase em paralelo, sem bloquear gameplay offline. Em debug desativa Analytics por padrão. Não instala o encaminhamento de erros brutos ao Crashlytics utilizado pelo Guided. Nenhum sink recebe snapshot ou exceção. Novos diagnósticos devem ser códigos enumerados, nunca `error.toString()`.

Firebase Analytics e RevenueCat podem coletar metadados próprios, dados de dispositivo/instância, sessão e transações segundo configuração/SDK. Auditar o projeto real e atualizar privacidade/declarações da loja antes do RC; este arquivo documenta o contrato de eventos próprios, não atesta conformidade de todo o binário. Não habilitar debug de SDK com dados sensíveis em builds distribuídos.

A instrumentação desta etapa usa contagens e origem/plano. Não implementa IDs de correlação, cronômetros de usabilidade nem todas as dimensões analíticas propostas no PRD. Tempo até primeira rodada, distribuição, país/storefront e coortes precisam de medição/relatórios específicos na validação de 8/9. Não inferir abandono de ausência de eventos nem chamar tentativas de review de avaliações reais.

## Roteiro de leitura (D7/D14/D30)

No Firebase, filtrar eventos `classic_*` e a versão/build Classic correta. Primeiro verificar qualidade de dados em build controlado:

1. Abrir home e forçar rebuild: uma impressão. Confirmar uma alteração de cada opção; nomes/palavras devem estar ausentes do payload.
2. Start e duplo Start: um `round_started`, depois um `round_saved` quando storage validar. Injetar falha, continuar sem salvar: `persistence_failed` + `round_unsaved`, sem falso salvo. Repetir retry/resume/rebuild e conferir contagens.
3. Completar distribuição, revelar resultado, replay, sair e retomar snapshot. Conferir sequência e ausência de novos inícios na retomada.
4. Abrir/fechar paywall por cada origem, comprar anual/semanal usando sandbox, cancelar, restaurar vazio/com direitos e injetar erro: conferir origem/plano e status sem payload comercial bruto. Rebuild e refresh sem mudança não repetem impressão/entitlement.
5. Cancelar share e e-mail; solicitar review. Não pode haver share concluído por cancelamento, feedback enviado nem avaliação concluída.

Painel sugerido (contagens e denominadores explícitos):

- Qualidade: `persistence_failed`, `round_unsaved` e retomadas por build; investigar aumentos antes de conversão. Não interpretar zero eventos como zero falhas.
- Ativação aproximada: usuários com `round_started` / usuários com `setup_viewed`, na mesma janela/coorte. Separar progresso salvo de tentativas em memória.
- Conclusão aproximada: `round_completed` / `round_started`; replay: `replay_started` / `round_completed`. Eventos sem correlação não permitem afirmar uma conversão exata por rodada; distinguir usuários de contagem de ações.
- Premium: usuários/eventos `paywall_opened` → `purchase_requested` → `purchase_verified`, por `origin`/`plan` quando presente. Não usar receita calculada por estes eventos: reconciliar preço, renovação, churn, estorno e receita líquida com loja/RevenueCat.
- Share: pedidos, concluídos, cancelados e cópias separados. Suporte/review: somente aberturas/tentativas.
- Retenção D7/D30: usar coortes do SDK por versão e janelas completas; não misturar denominadores Guided/Classic. Mostrar números absolutos e limites de amostra, sem alegar causalidade ou significância com pouco tráfego.

Nenhum painel remoto foi criado ou validado nesta tarefa; este roteiro é o entregável reproduzível permitido pela etapa 7. Acesso real a Analytics, inspeção dos SDKs e QA físico permanecem pendentes.
