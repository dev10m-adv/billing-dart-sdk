import '../core/i_billing_http_client.dart';
import '../models/models.dart';

class HealthService {
  final IBillingHttpClient _client;
  HealthService(this._client);

  Future<HealthStatus> check() async {
    final json = await _client.get('/health', requiresAuth: false);
    return HealthStatus.fromJson(json);
  }
}
