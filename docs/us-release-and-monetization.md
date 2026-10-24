# US release: gameplay, content, and one-time purchases

Implementation date: 2026-10-20. App name and Neon refined identity are unchanged.

## Included in this implementation

- Guided mode: randomized, least-recently-used questions. Free play: one-word clues, one turn per person, optional additional laps, then the existing vote/scoring flow.
- Local session persistence: last group (names only, scores reset), mode, round settings, and bounded word/question history. Question history considers normalized text, including identical prompts attached to different words. History is scoped by language and category.
- Six existing free categories/180 words remain free. Both modes and history are free.
- US English catalog: Backyard Hangout, Road Trip, Holiday Hangout. Each has 20 words and 9 prompts per word. The pack descriptions and all premium editorial content are English; core UI labels are translated in the existing supported languages.
- Pack offers and a Game Night Collection containing exactly these three packs. No promise of all future releases.
- RevenueCat SDK integration: one-time products only, localized store prices, restore, cancellation/pending/error handling, and access based on SDK-confirmed entitlements. No locally stored paid/unpaid boolean.
- RevenueCat is inactive without a platform public SDK key. Free gameplay is unaffected. Store buttons are disabled if there is no valid offer; there are no hardcoded retail prices.

## Configuration required before real sales

Create a RevenueCat project for THIS app and connect the matching App Store Connect and Google Play apps. Do not reuse another app's project or public key.

Create **non-consumable / one-time** products in each store. Link each product to the following RevenueCat custom package and entitlement identifiers. Actual Apple/Google product IDs can differ; this app uses package/entitlement identifiers, not hardcoded product IDs.

| Content | RevenueCat package identifier | RevenueCat entitlement identifier |
| --- | --- | --- |
| Backyard Hangout | `us_backyard` | `us_backyard` |
| Road Trip | `us_roadtrip` | `us_roadtrip` |
| Holiday Hangout | `us_holidays` | `us_holidays` |
| These three packs together | `game_night_collection` | `game_night_collection` |

Put these packages in the **current offering**. Only products classified by the SDK as non-subscription, with no subscription period, are displayed. Setting up a weekly/yearly subscription under these identifiers will not enable an offer in the app.

Store the platform-specific **public SDK key** in local `.env` and `.env.test` files using `KEY=value` syntax (`REVENUECAT_IOS_API_KEY` or `REVENUECAT_ANDROID_API_KEY`). Only the iOS key is currently configured. Pass the appropriate file at build time:

```sh
flutter run --dart-define-from-file=.env.test
flutter build ipa --dart-define-from-file=.env
```

Use the matching flag for release builds too. Never embed Apple private keys, Google service credentials, or RevenueCat secret API keys in Dart defines or the app binary. The SDK manages anonymous purchase identity; player names are not sent to RevenueCat or analytics.

The iOS project declares In-App Purchase capability. The deployment target is iOS 15, above the SDK's iOS 13 requirement. Android declares Internet/Billing permissions and uses `singleTop`. Refreshing on app resume rechecks pending purchases and changes in entitlement access. SDK-cached customer information supplies offline access when available; fetching offers can fail without removing already confirmed SDK rights.

Before enabling products for customers, verify real sandbox purchases, cancellation, Ask to Buy/pending approval, restore after reinstall using the same store account, offline access after purchase, and revoked/refunded entitlement behavior. Automated fake-store tests do not replace these store checks. Review the updated purchase SDK disclosures/privacy policy before submission.

Official integration references:
- https://www.revenuecat.com/docs/getting-started/installation/flutter
- https://www.revenuecat.com/docs/getting-started/making-purchases
- https://www.revenuecat.com/docs/getting-started/restoring-purchases

## English-US storefront draft

Keep the current store name: **Imposter Spy: Out of the Loop**.

Subtitle: **One phone. Find the imposter.**

Promotional text:

> Everyone knows the secret word. Except one. Play with 3–9 friends on one phone: answer guided questions or give your own one-word clues. No Wi-Fi needed to play.

Description:

> Someone in your group is bluffing. Can you spot who?
>
> Pass one phone around. Everyone gets the same secret word, except the imposter. Take turns sharing clues, compare suspicious answers, and vote. If the imposter escapes the vote, they get a chance to guess the secret word.
>
> TWO WAYS TO PLAY
> Guided: the app picks questions, so everyone knows what to say next.
> Free play: give a one-word clue. Take another lap if your group needs more time, then vote.
>
> MADE FOR YOUR NEXT HANGOUT
> - 3–9 players, one phone, no account required for gameplay
> - Six free categories with 180 words
> - Recent words and questions are deprioritized on your device
> - Your last group and game settings are remembered
> - Play offline after installation; purchases and restoration may require a connection
>
> Optional Game Night packs add English-language topics for backyard hangouts, road trips, and holiday gatherings. Packs are one-time purchases with no subscription. Both game modes remain free.

First six screenshot headlines (use real captures, not invented ratings/player counts):
1. **One of you is bluffing.** — role reveal
2. **Questions or one-word clues?** — mode selection
3. **Your crew. One phone.** — player setup
4. **Who gave that away?** — question/clue screen
5. **Fresh topics for game night.** — packs, showing real prices only if configured
6. **Call the bluff. Play again.** — voting and result

The former “20+ players” claim must not be reused: the implementation supports 3–9. Store copy is prepared locally; no listing has been changed or submitted.

## Measure the US hypothesis

North America performs well in aggregate subscription benchmarks, but this does not prove conversion for this US party game or for one-time packs. Source: https://www.revenuecat.com/state-of-subscription-apps

Filter results by Firebase's actual country = United States, and compare acquisition cohorts/source. English UI and USD pricing are not geographic attribution. Track:

- Activation: `start_match` / first opens, with `game_mode` and `content_version`.
- Play quality: `complete_round`, `match_finished`, `cancel_match`, `rematch_started`.
- Offer funnel: `pack_shop_viewed` → `pack_purchase_started` → `pack_purchase_completed`.
- Separate `pack_purchase_cancelled`, `pack_purchase_pending`, `pack_purchase_failed`, and `pack_purchase_unavailable`.
- Revenue and refunds: reconcile with RevenueCat and store financial reports. The app's custom funnel events are not audited revenue and do not emit a duplicate standard `purchase` event.
- Repeat play/retention: US D7/D30 cohorts, plus pack usage (`owned_pack_selected`). Register `game_mode`, `pack_id`, and `content_version` as custom dimensions in GA4 as needed.

Set prices in the stores after deciding the initial test; the app displays those store prices. Compare pack conversion and total net revenue per active user while monitoring refunds and rematches. Avoid optimizing download-to-paid conversion alone if acquisition cost or retention deteriorates.

## Validation commands

```sh
flutter test
flutter analyze --no-fatal-infos
NEON_CAPTURE_DIR=/absolute/output/path flutter test test/features/neon_refined_layout_test.dart
```

The layout matrix includes all supported UI languages, narrow phones with enlarged text, normal phones, tablets, and landscape. New purchase behavior has fake-gateway tests and premium access checks; sandbox transactions require the configuration above.
