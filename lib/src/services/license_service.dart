import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class LicenseService {
  final IBillingHttpClient _client;
  LicenseService(this._client);

  Future<BillingLicense> getBillingLicense() async {
    final json = await _client.get('/license');
    return BillingLicense.fromJson(unwrapData(json));
  }
}
