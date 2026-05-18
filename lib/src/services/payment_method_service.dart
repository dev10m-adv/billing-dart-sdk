import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class PaymentMethodService {
  final IBillingHttpClient _client;
  PaymentMethodService(this._client);

  Future<List<PaymentMethod>> list() async {
    final json = await _client.get('/payment-methods');
    return unwrapList(json)
        .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> setDefault(int id) async {
    await _client.post('/payment-methods/$id/set-default',
        body: {'setDefault': true});
  }

  Future<void> remove(int id) async {
    await _client.delete('/payment-methods/$id');
  }
}
