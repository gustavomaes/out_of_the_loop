# RevenueCat / Monetização Pro — Tasks

**Spec**: `.specs/features/revenuecat-monetization/spec.md`  
**Design**: `.specs/features/revenuecat-monetization/design.md`  
**Status**: Ready for Execute  
**Gate**: `flutter analyze && flutter test`

**UX fixo:** paywall gate na abertura (Free) · alerta em categoria bloqueada · cadeado top-left · restaurar no paywall **e** settings.

---

## External setup (human — antes de T03)

| Step | Owner | Done |
| --- | --- | --- |
| Criar produtos `otl_pro_monthly`, `otl_pro_annual`, `otl_pro_lifetime` em ASC + Play | Você | [ ] |
| Anual: trial 7 dias nas duas lojas | Você | [ ] |
| Preço anual < 12× mensal | Você | [ ] |
| RevenueCat: entitlement `pro`, offering `default`, 3 packages | Você | [ ] |
| API keys públicas para dev | Você | [ ] |

---

## Phase 1: Foundation (RC-01)

```text
T01 -> T02 -> T03 -> T04
```

### T01 — Add `purchases_flutter` and platform config

**Requirement**: RC-01  
**What**: `pubspec.yaml`; iOS IAP capability; Android BILLING if missing; `dart_defines.example` doc comment.  
**Verify**: `flutter pub get && flutter analyze`

### T02 — Domain: `SubscriptionStatus` + `ProAccessPolicy`

**Requirement**: RC-02, D3, D4  
**What**:

- `lib/src/domain/models/subscription_status.dart`
- `lib/src/domain/services/pro_access_policy.dart` (`food`, `movies`, `sports`)

**Verify**: `test/domain/services/pro_access_policy_test.dart` — 3 free, 17 locked, pro unlocks all 20

### T03 — Data: cache + `SubscriptionRepository` + RevenueCat impl

**Requirement**: RC-01, D6  
**What**:

- `subscription_repository.dart`
- `subscription_cache.dart`
- `revenue_cat_subscription_repository.dart`
- `RestoreResult` (success / empty / error) para UI compartilhada

**Verify**: unit tests cache; mock restore outcomes

### T04 — App: bootstrap + `SubscriptionController` + `SubscriptionScope`

**Requirement**: RC-01  
**What**:

- `main.dart` configure Purchases
- `subscription_controller.dart` (`restore()`, `paywallGateDismissed`, `markPaywallGateDismissed()`)
- `subscription_scope.dart`
- Wire `OutOfTheLoopApp`

**Verify**: debug log tier after launch; analyze clean

---

## Phase 2: Paywall gate + grid + paywall UI (RC-03a, RC-02, RC-03)

```text
T04 -> T05 -> T06
T04 -> T07 -> T06
T05 -> T07
```

### T05 — Paywall gate routing (RC-03a, D10)

**Requirement**: RC-03a  
**What**:

- `AppRoutes.proPaywall` rota raiz fora de `DiscoveryShell`
- `GoRouter` `redirect` + `initialLocation` para Free cold start
- `ProPaywallScreen(mode: gate)` — Fechar → `go(home)` + `markPaywallGateDismissed()`
- Pro users skip gate (`initialLocation: home`)

**Verify**: manual Free cold start → paywall first; Fechar → home com bottom bar; kill app → paywall again

### T06 — Category grid: lock top-left + alert (RC-02, D11, D12)

**Requirement**: RC-02  
**What**:

- `OtlCategoryTile`: `locked` → `Positioned(top, left)` lock icon
- `showProCategoryAlert` — Cancelar / Ver vantagens Pro
- `CategorySelectionScreen`: locked tap → alert only; confirm → `push(paywall, presented)`
- Free tap → `matchSetup` unchanged

**Verify**: widget test lock top-left; widget test alert cancel vs confirm navigation

### T07 — `ProPaywallScreen` (presented + gate) + restore (RC-03, D13)

**Requirement**: RC-03, D1, D2, D5, D13  
**What**:

- `features/pro/` — plan cards, annual badge/trial/savings
- **Restaurar compras** button (shared `controller.restore()`)
- Fechar: gate vs `pop` by mode
- Purchase success → dismiss appropriately

**Verify**: sandbox 3 plans; restore from paywall; presented mode pops back to categories

### T08 — l10n (paywall, alert, restore feedback)

**Requirement**: NFR-03, D11, D13  
**What**: strings alert, paywall, restore success/empty/error, gate close  
**Verify**: `flutter gen-l10n`; localization contract test

---

## Phase 3: Settings (RC-04, D13)

```text
T07 -> T09
```

### T09 — Settings Pro section + restore (RC-04)

**Requirement**: RC-04, D13  
**What**:

- Seção PRO: upgrade CTA (Free), status + manage (Pro)
- **Restaurar compras** sempre visível (Free **e** Pro)
- Mesmo `SubscriptionController.restore()` + feedback que paywall

**Verify**: manual restore from settings; button present for Pro user

---

## Traceability

| Task | RC ID |
| --- | --- |
| T01–T04 | RC-01 |
| T05 | RC-03a |
| T06 | RC-02 |
| T07 | RC-03 |
| T08 | RC-06 (i18n) |
| T09 | RC-04 |

---

## Suggested first commit scope

**T01 + T02** em paralelo ao setup das lojas; depois **T04 + T05** para validar o gate de abertura cedo.
