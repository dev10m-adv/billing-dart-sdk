# billing_sdk

A generic, extensible Dart SDK for the **Package Billing API**.

---

## Features

| Domain | Coverage |
|---|---|
| Health | `check()` |
| Checkout | `createSession`, `fulfillSession` |
| Paying Parties | CRUD + `enableStripe`, `enablePayPal`, `getVacantSeats` |
| Products | CRUD |
| Plans | CRUD + `getPricings` |
| Subscriptions | CRUD + seat management (add, remove, assign, unassign, transfer) |
| Invoices | CRUD + finalize, mark-sent, generate recurring/proration, list by subscription/party |
| Tax Rules | CRUD + `getApplicable`, `calculate`, `getInvoiceTaxes` |
| Affiliates | CRUD + `getPromoCodes`, `getCommissions` |
| Promo Codes | CRUD + `validate` |
| Commissions | list, `updateStatus` |
| Payment Methods | list, `setDefault`, `remove` |
| License | `getBillingLicense` |

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  billing_sdk:
    path: ./billing_sdk   # or point at your git repo / pub package
  http: ^1.2.0
```

---

## Quick Start

```dart
import 'package:billing_sdk/billing_sdk.dart';

final billing = BillingClient(
  baseUrl: 'https://api.example.com/api/billing',
  tokenProvider: () async => await authService.getToken(),
);

// List active monthly plans (public endpoint – no token needed)
final plans = await billing.plans.list(billingInterval: 'monthly', isActive: true);

// Create a paying party
final party = await billing.payingParties.create(
  CreatePayingPartyRequest(
    identityProvider: 'auth0',
    identitySubject: 'auth0|user123',
    billingEmail: 'billing@acme.com',
  ),
);

billing.dispose(); // release HTTP client
```

---

## Configuration

### `BillingClient` constructor

| Parameter | Type | Default | Description |
|---|---|---|---|
| `baseUrl` | `String` | **required** | Full base URL e.g. `http://localhost:3000/api/billing` |
| `tokenProvider` | `Future<String?> Function()?` | `null` | Called before every authenticated request |
| `httpClient` | `http.Client?` | auto | Supply a mock client for tests |
| `defaultHeaders` | `Map<String, String>` | `{}` | Extra headers on every request |

---

## Error Handling

```dart
try {
  final invoice = await billing.invoices.get(999);
} on BillingApiException catch (e) {
  // HTTP 4xx / 5xx
  print('${e.statusCode}: ${e.message}');
  print(e.body); // raw response body map
} on BillingNetworkException catch (e) {
  // connectivity / timeout
  print(e.message);
}
```

---

## Services

### `billing.health`
```dart
final status = await billing.health.check();
// HealthStatus(status: 'ok', timestamp: '...')
```

### `billing.checkout`
```dart
final session = await billing.checkout.createSession(
  CreateCheckoutSessionRequest(planId: 1, pricingId: 1,
      successUrl: 'https://app.com/ok', cancelUrl: 'https://app.com/cancel'),
);
// Redirect user to session.url

// Local dev only:
await billing.checkout.fulfillSession(FulfillCheckoutRequest(
  sessionId: 'cs_test_abc', paymentMethodId: 'pm_123',
  customerId: 'cus_123', chargeId: 'ch_123', status: 'paid',
));
```

### `billing.payingParties`
```dart
final party  = await billing.payingParties.create(CreatePayingPartyRequest(...));
final party  = await billing.payingParties.getById(1);
final party  = await billing.payingParties.getByIdentity('auth0', 'auth0|user123');
final party  = await billing.payingParties.update(1, UpdatePayingPartyRequest(gracePeriodDays: 7));
await billing.payingParties.enableStripe(1, 'cus_stripe_abc');
await billing.payingParties.enablePayPal(1, 'B-paypal_abc');
final seats  = await billing.payingParties.getVacantSeats(1);
```

### `billing.products`
```dart
final list   = await billing.products.list(includeInactive: false);
final p      = await billing.products.get(1);
final p      = await billing.products.create(CreateProductRequest(name: 'Pro'));
final p      = await billing.products.update(1, UpdateProductRequest(name: 'Pro v2'));
await billing.products.delete(1);
```

### `billing.plans`
```dart
final list      = await billing.plans.list(productId: 1, billingInterval: 'monthly');
final plan      = await billing.plans.get(1);
final pricings  = await billing.plans.getPricings(1);
final plan      = await billing.plans.create(CreatePlanRequest(...));
final plan      = await billing.plans.update(1, UpdatePlanRequest(basePrice: 59.99));
await billing.plans.delete(1);
```

### `billing.subscriptions`
```dart
final summary  = await billing.subscriptions.getMeBillingSummary();
final list     = await billing.subscriptions.listMine();
final sub      = await billing.subscriptions.get(1);
final sub      = await billing.subscriptions.create(CreateSubscriptionRequest(...));
final sub      = await billing.subscriptions.update(1, UpdateSubscriptionRequest(status: 'active'));

// Seat management
final seat     = await billing.subscriptions.addSeat(AddSeatRequest(planId: 1, pricingId: 1));
await billing.subscriptions.removeSeat(seatId);
final sub      = await billing.subscriptions.assignUser(1, AssignSeatRequest(...));
final sub      = await billing.subscriptions.unassignUser(1);
final sub      = await billing.subscriptions.transferSeat(1, TransferSeatRequest(...));
```

### `billing.invoices`
```dart
final list     = await billing.invoices.listMine(status: 'paid');
final inv      = await billing.invoices.get(1);
final inv      = await billing.invoices.create(CreateInvoiceRequest(...));
final inv      = await billing.invoices.update(1, UpdateInvoiceRequest(status: 'paid'));
final inv      = await billing.invoices.finalize(1);    // DRAFT → PENDING
final inv      = await billing.invoices.markSent(1);   // PENDING → PROCESSING
final inv      = await billing.invoices.generateRecurring(subscriptionId);
final inv      = await billing.invoices.generateProration(GenerateProrationRequest(...));
final list     = await billing.invoices.listBySubscription(1);
final list     = await billing.invoices.listByPayingParty(1);
```

### `billing.taxRules`
```dart
final list     = await billing.taxRules.list(scope: 'region');
final applic   = await billing.taxRules.getApplicable(jurisdiction: 'US-CA');
final rule     = await billing.taxRules.get(1);
final rule     = await billing.taxRules.create(CreateTaxRuleRequest(...));
final rule     = await billing.taxRules.update(1, UpdateTaxRuleRequest(rateValue: 9.0));
final result   = await billing.taxRules.calculate(CalculateTaxesRequest(...));
final taxes    = await billing.taxRules.getInvoiceTaxes(invoiceId);
```

### `billing.affiliates`
```dart
final list     = await billing.affiliates.list();
final aff      = await billing.affiliates.get(1);
final aff      = await billing.affiliates.create(CreateAffiliateRequest(...));
final aff      = await billing.affiliates.update(1, UpdateAffiliateRequest(...));
final codes    = await billing.affiliates.getPromoCodes(1);
final comms    = await billing.affiliates.getCommissions(1, status: 'pending');
```

### `billing.promoCodes`
```dart
final list     = await billing.promoCodes.list(affiliateId: 1);
final code     = await billing.promoCodes.getByCode('SAVE20');
final code     = await billing.promoCodes.getById(1);
final result   = await billing.promoCodes.validate('SAVE20');
final code     = await billing.promoCodes.create(CreatePromoCodeRequest(...));
final code     = await billing.promoCodes.update(1, UpdatePromoCodeRequest(...));
```

### `billing.commissions`
```dart
final list     = await billing.commissions.list(status: 'pending');
final comm     = await billing.commissions.updateStatus(1,
    UpdateCommissionStatusRequest(status: 'paid', paidAt: '2026-05-12T12:00:00Z'));
```

### `billing.paymentMethods`
```dart
final list     = await billing.paymentMethods.list();
await billing.paymentMethods.setDefault(1);
await billing.paymentMethods.remove(1);
```

### `billing.license`
```dart
final lic      = await billing.license.getBillingLicense();
print(lic.signedToken); // JWT
```

---

## Testing

```dart
import 'package:http/testing.dart';
import 'package:billing_sdk/billing_sdk.dart';

final mockClient = MockClient((request) async {
  return Response('{"status":"ok","timestamp":"2026-05-14T00:00:00Z"}', 200);
});

final billing = BillingClient(
  baseUrl: 'http://localhost',
  httpClient: mockClient,
);
final health = await billing.health.check();
```

---

## Extending the SDK

Each service is a plain Dart class. To add a new endpoint:

1. Add a model class to `lib/src/models/models.dart`.
2. Add a method to the relevant service in `lib/src/services/services.dart`.
3. Re-export if needed from `lib/billing_sdk.dart`.

The `BillingHttpClient` provides `get`, `post`, `patch`, `delete` — all new endpoints follow the same pattern.
