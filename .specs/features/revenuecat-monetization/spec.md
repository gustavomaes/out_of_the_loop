# RevenueCat / Monetização Pro — Specification

**Status**: Approved (decisões D1–D6 fechadas em 2026-05-19)  
**Design**: `.specs/features/revenuecat-monetization/design.md`  
**Tasks**: `.specs/features/revenuecat-monetization/tasks.md`  
**Contexto**: O MVP do jogo está jogável offline. O Figma inclui frame **Assinatura Pro** (`2:625`). Esta feature introduz monetização sem login e sem interromper partidas.

---

## Problem Statement

O app oferece 20 categorias de conteúdo local, mas não há forma de monetizar o catálogo completo. RevenueCat centraliza recibos, restauração e ofertas nas lojas, evitando StoreKit / Play Billing direto no Flutter.

---

## Goals

- [ ] Permitir compra ou restauração de **Pro** (mensal, anual, vitalício) via App Store e Google Play.
- [ ] Desbloquear **todas as 20 categorias** para assinantes Pro.
- [ ] Exibir paywall **custom** como **primeira tela isolada** para usuários Free (Figma `2:625`).
- [ ] Oferecer **Restaurar compras** no paywall e em Configurações (obrigatório).
- [ ] Manter gameplay offline; rede apenas para IAP e refresh de entitlement.
- [ ] Não punir compradores sem rede: cache Pro prevalece (D6).
- [ ] Sem login, conta OTL ou multiplayer online.

---

## Modelo de produto (aprovado)

| Camada | O que o usuário recebe |
| --- | --- |
| **Free** | **3 categorias** fixas: `food`, `movies`, `sports`. |
| **Pro** | **Todas as 17 categorias restantes** (e visual Pro na grade). |
| **Planos** | **Mensal**, **Anual** (preço com desconto vs 12× mensal), **Vitalício** (non-consumable). |
| **Trial** | **7 dias grátis** no plano **anual** (configurado nas lojas + refletido no paywall). |

**Princípio:** qualquer grupo free consegue jogar partida completa nas 3 categorias; Pro expande variedade.

---

## Decisões de produto (aprovadas)

| ID | Decisão | Valor |
| --- | --- | --- |
| D1 | Produtos | Mensal + Anual (desconto) + Vitalício |
| D2 | Trial | 7 dias no anual |
| D3 | Benefício Pro | Todas as categorias |
| D4 | Categorias free | 3 — `food`, `movies`, `sports` |
| D5 | Paywall | Custom Flutter v1 (Figma `2:625`) |
| D6 | Offline / cache | Cache Pro mantém acesso sem rede; não punir comprador |
| D7 | Entitlement RC | `pro` |
| D8 | Offering RC | `default` (Current) |
| D9 | Rede | Só para IAP/refresh; jogo offline inalterado |
| D10 | Paywall na abertura | Free: **primeira tela** fullscreen isolada; fechar → app normal |
| D11 | Categoria bloqueada | **Alerta** de confirmação antes do paywall (não abrir paywall direto) |
| D12 | Cadeado na grade | Ícone no **canto superior esquerdo** do tile bloqueado |
| D13 | Restaurar compras | Botão **obrigatório** no paywall **e** em Configurações |

**IDs de produto nas lojas (convenção):**

| Plano | Product ID |
| --- | --- |
| Mensal | `otl_pro_monthly` |
| Anual | `otl_pro_annual` |
| Vitalício | `otl_pro_lifetime` |

---

## Out of Scope

| Feature | Reason |
| --- | --- |
| Login / conta OTL | RC ID anônimo por dispositivo. |
| RevenueCat Paywalls remotos | D5: custom v1; RC UI fica para iteração futura. |
| Anúncios | Modelo IAP apenas. |
| Consumíveis | Não aplicável ao jogo. |
| Paywall durante partida | Bloqueio só via alerta em categorias; paywall de lançamento é pré-app. |
| Timer ou perks Pro além de categorias | D3. |

---

## User Stories

### P1: Inicializar SDK e estado Pro (RC-01)

**Acceptance Criteria**:

1. WHEN o app inicia THEN o sistema SHALL configurar RevenueCat com chaves por plataforma (`--dart-define`).
2. WHEN o entitlement `pro` está ativo THEN o sistema SHALL tratar o usuário como Pro em toda a UI.
3. WHEN há cache local `isPro == true` e a rede falha THEN o sistema SHALL **manter Pro** (D6).
4. WHEN não há cache Pro e a rede falha THEN o sistema SHALL assumir Free até refresh bem-sucedido.
5. WHEN a rede volta THEN o sistema SHALL atualizar entitlement em background.

---

### P1: Paywall como primeira tela (RC-03a)

**Acceptance Criteria**:

1. WHEN o usuário **não é Pro** abre o app (cold start) THEN o sistema SHALL exibir o paywall como **primeira tela**, fullscreen, **fora** do `DiscoveryShell` (sem bottom bar).
2. WHEN o usuário **é Pro** abre o app THEN o sistema SHALL ir direto para o fluxo normal (`home` / discovery).
3. WHEN o paywall de abertura é exibido THEN o sistema SHALL exibir botão **Fechar** (X ou equivalente) com área de toque ≥ 44pt.
4. WHEN o usuário toca Fechar THEN o sistema SHALL navegar para o restante do app (entrada padrão: `home`) sem exigir compra.
5. WHEN o usuário compra com sucesso no paywall de abertura THEN o sistema SHALL ativar Pro e navegar para o app (mesmo destino do Fechar).
6. WHEN o usuário já dispensou o paywall nesta sessão e navega internamente THEN o sistema SHALL **não** reexibir o paywall de abertura até o próximo cold start (salvo navegação explícita para paywall).

---

### P1: Bloquear categorias premium (RC-02)

**Acceptance Criteria**:

1. WHEN o usuário não é Pro e toca categoria fora de `{food, movies, sports}` THEN o sistema SHALL exibir um **alerta** (dialog nativo ou equivalente OTL) — **não** abrir o paywall imediatamente.
2. WHEN o alerta é exibido THEN o sistema SHALL oferecer pelo menos: **Cancelar** (permanece na grade) e **Ver vantagens Pro** (ou copy equivalente) que abre o paywall.
3. WHEN o usuário cancela o alerta THEN o sistema SHALL permanecer na seleção de categorias sem mudança de rota.
4. WHEN o usuário não é Pro e toca categoria free THEN o sistema SHALL seguir para `matchSetup`.
5. WHEN o usuário é Pro THEN o sistema SHALL permitir qualquer uma das 20 categorias.
6. WHEN a grade exibe categoria bloqueada THEN o sistema SHALL mostrar ícone de **cadeado no canto superior esquerdo** do tile (tokens OTL).

---

### P1: Paywall custom — três planos + restore (RC-03)

**Acceptance Criteria**:

1. WHEN o paywall abre (abertura, alerta ou Configurações) THEN o sistema SHALL exibir **mensal**, **anual** e **vitalício** com preços das lojas (`priceString`).
2. WHEN o plano anual é exibido THEN o sistema SHALL destacar **desconto** (vs 12× mensal ou copy aprovada) e **trial de 7 dias** (D2).
3. WHEN o usuário compra qualquer plano com sucesso THEN o sistema SHALL ativar Pro e fechar o paywall (voltando à tela anterior ou ao app, conforme origem).
4. WHEN compra falha ou é cancelada THEN o sistema SHALL permanecer Free sem crash e com mensagem localizada.
5. WHEN o paywall é exibido THEN o sistema SHALL exibir botão **Restaurar compras** sempre visível (D13).
6. WHEN o usuário toca Restaurar no paywall THEN o sistema SHALL chamar `restorePurchases` e atualizar UI com feedback (sucesso / nada encontrado / erro).
7. WHEN o paywall é exibido THEN o sistema SHALL incluir links Termos/Privacidade, texto legal e botão Fechar (quando não for pop forçado sem saída — paywall de abertura sempre tem Fechar, RC-03a).

---

### P2: Configurações — status Pro + restore (RC-04)

**Acceptance Criteria**:

1. WHEN Free THEN Configurações SHALL mostrar CTA upgrade → paywall.
2. WHEN Pro THEN Configurações SHALL mostrar status Pro + gerenciar assinatura (`managementURL`; vitalício sem renovação).
3. WHEN Pro THEN o CTA upgrade não SHALL aparecer.
4. WHEN Configurações é exibida THEN o sistema SHALL exibir botão **Restaurar compras** sempre visível na seção Pro (D13), independente de Free ou Pro.
5. WHEN o usuário toca Restaurar em Configurações THEN o sistema SHALL usar o mesmo fluxo de `restorePurchases` do paywall com feedback localizado.

---

### P3: Analytics de funil

Hooks documentados; ativação pós-lançamento no dashboard RevenueCat.

---

## Requisitos não funcionais

| ID | Requisito |
| --- | --- |
| NFR-01 | API keys via `--dart-define`; nunca no git. |
| NFR-02 | Sandbox iOS + Play test antes de produção. |
| NFR-03 | Paywall e erros em `pt-BR`, `en`, `es`, `hi`. |
| NFR-04 | CTAs ≥ 44pt; contraste `.agents/DESIGN.md`. |
| NFR-05 | Unit tests: `ProAccessPolicy` (3 free / 17 locked); widget test tile locked. |

---

## Rastreabilidade

| ID | Story | Fase |
| --- | --- | --- |
| RC-01 | SDK + estado + cache | 1 |
| RC-02 | Gating categorias | 2 |
| RC-03a | Paywall primeira tela (gate) | 2 |
| RC-03 | Paywall 3 planos + restore | 2 |
| RC-04 | Settings Pro + restore | 3 |
| RC-06 | i18n + testes | Transversal |

---

## Dependências externas (checklist)

- [ ] RevenueCat: app iOS + Android, entitlement `pro`, offering `default`
- [ ] Packages: `monthly`, `annual`, `lifetime` → product IDs acima
- [ ] App Store Connect: 3 produtos; **intro offer 7 dias** no anual
- [ ] Google Play: 3 produtos; **free trial 7 dias** no anual
- [ ] Preços: anual < 12× mensal (desconto visível no paywall)
- [ ] Banking/contratos lojas
- [ ] URLs Termos e Privacidade

---

## Success Metrics

- Conversão paywall (impressão → compra por plano)
- Restore success rate
- Churn / renewal (mensal e anual)
- Partida completa jogável nas 3 categorias free sem compra
