# Etapa 9 — pacote de publicação e acompanhamento

25/10/2026. **Pacote local entregue; em validação, bloqueado para submissão.**
Não houve upload, publicação, mudança de produtos ou criação de automação.
A etapa 8 ainda não tem aceite externo; esta entrega prepara o trabalho independente
sem declarar encerrados os bloqueadores. Relatórios pós-lançamento aguardam lançamento.

## Pacote revisável

- [Checklist de submissão](publication/CHECKLIST.md): evidências e aprovação final.
- [Metadados en-US](publication/METADATA_en-US.md): copy concreta, coerente com
  Classic, sem preços fictícios ou trial; links/marca e revisão humana pendentes.
- [Notas de revisão](publication/REVIEW_NOTES.md): percurso gratuito, assinatura,
  restore e gestão; completar produtos e dados do candidato antes da submissão.
- [Manifesto](publication/manifest.json): Bundle ID preservado, versão fonte
  `1.2.1+7`, revisão base `d1cbb82`, hashes e origem das duas capturas reais.
  Esta revisão identifica o app/capturas anteriores, não o commit documental.
- [Hotfix](publication/HOTFIX.md): triagem, preservação de fontes/catálogo/mapping,
  validação de atualização e nova distribuição; sem promessa de rollback instantâneo.
- Relatórios [D7](publication/reports/D7.md), [D14](publication/reports/D14.md) e
  [D30](publication/reports/D30.md): modelos preenchíveis com denominadores,
  coortes, origem/plano, limitações e decisões. Nenhum dado de lançamento inventado.

## Capturas e binário

As capturas reais da home/categorias são evidência histórica do simulador em
português descrita em [EMOJI_FIX.md](EMOJI_FIX.md), reutilizada sem alteração de
pixels. Não são assets finais de loja nem evidência de TestFlight. Screenshots
Guided em `screenshots/final` não podem ser reutilizadas para Classic.
Nesta execução, `xcrun simctl list devices booted` não acessou CoreSimulatorService
no sandbox. Não se produziu uma nova captura ou um novo IPA. Capturas finais
em iPhone/iPad, gameplay e Premium devem identificar o mesmo candidato assinado,
localização, dispositivo e dimensões exigidas pela loja; conferir ausência de
nomes reais/segredos. Não promover a evidência anterior a aprovação comercial.

Versão/build foram lidos do fonte, sem bump arbitrário. A última versão/build
aceita pela loja é desconhecida. O manifesto mantém `signedCandidate=null` e
`storeVersionVerified=false`; conferir App Store Connect antes do archive/upload.
Não alterar Bundle ID para criar outra listagem.

## Demonstração e aceite

1. Executar `python3 tool/classic_publication_check.py`: deve passar integridade
   local e listar explicitamente os gates de release ainda abertos.
2. Abrir checklist, metadata, review notes e capturas pelo manifesto; conferir
   hashes, revisão de origem e ausência de promessas comerciais não verificadas.
3. Seguir matriz da etapa 8 para anexar QA físico, usabilidade, sandbox, auditoria
   legada/editorial, links/contatos e candidato assinado/TestFlight.
4. Substituir pendências por evidência revisada e preparar nova revisão do pacote.
   O checker atual valida somente o pacote bloqueado; não autoriza publicação.
5. Proprietário revisa pacote completo e autoriza publicação separadamente.
6. Após lançamento real, registrar timestamp e completar relatórios nas janelas
   maduras, usando [METRICS.md](METRICS.md). Não criar métricas/coortes fictícias.

| Critério | Situação |
| --- | --- |
| Mesmo Bundle ID e versão fonte identificados | Conferidos no pacote e checker |
| Checklist, metadata, review notes e hotfix concretos | Entregues para revisão |
| Screenshots reais com proveniência | Duas históricas; conjunto final pendente |
| Links/contatos válidos e versão/build aptos a upload | Dependem de confirmação externa |
| Distribuição/restore no candidato | Pendente sandbox/IPA/TestFlight |
| Todos os bloqueadores encerrados | Não; lista na etapa 8 e no manifesto |
| Relatórios D7/D14/D30 observados | Aguardam lançamento e janelas completas |
| Publicação autorizada | Não solicitada nem realizada nesta entrega |

## Validação

- `python3 tool/classic_publication_check.py`: passou integridade e listou 8 gates.
- `python3 tool/classic_catalog.py --check`: 120 textos grátis + 800 Premium,
  959 entradas; revisão humana pendente.
- `git diff --check`: passou.
- `flutter analyze --no-fatal-infos`: **No issues found**.
- `flutter test`: **83 testes passaram**, suíte completa. A primeira tentativa
  foi impedida pela escrita no cache externo do SDK; reexecução com acesso
  autorizado ao cache passou sem alterar dependências.

Nenhum schema de sessão, runtime ou configuração comercial foi modificado.
O checker verifica artefatos, versão, existência da revisão e hashes; não testa
links remotos, dimensões aceitas pela loja, assinatura, compras ou qualidade visual.
Para recuperar esta entrega documental, usar Git; preservar o fonte e os artefatos
do candidato real conforme o runbook. Conhecimento do fluxo já consta nestes
artefatos e em METRICS/STAGE_8; não há nova descoberta que justifique duplicá-lo
em `.notebook`.
