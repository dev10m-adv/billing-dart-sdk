import '../core/i_billing_http_client.dart';
import '../models/models.dart';

class CheckoutService {
  final IBillingHttpClient _client;
  CheckoutService(this._client);

  Future<CheckoutSessionResult> createSession(
      CreateCheckoutSessionRequest req) async {
    final json = await _client.post('/checkout/checkout-session',
        body: req.toJson());
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return CheckoutSessionResult.fromJson(data);
  }

  Future<Map<String, dynamic>> fulfillSession(
      FulfillCheckoutRequest req) async {
    return _client.post('/checkout/fulfill', body: req.toJson());
  }
}
