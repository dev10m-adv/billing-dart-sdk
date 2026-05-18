import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class PayingPartyService {
  final IBillingHttpClient _client;
  PayingPartyService(this._client);

  Future<PayingParty> create(CreatePayingPartyRequest req) async {
    final json = await _client.post('/paying-parties', body: req.toJson());
    return PayingParty.fromJson(unwrapData(json));
  }

  Future<PayingParty> getById(int id) async {
    final json = await _client.get('/paying-parties/$id');
    return PayingParty.fromJson(unwrapData(json));
  }

  Future<PayingParty> getByIdentity(
      String identityProvider, String identitySubject) async {
    final encodedSubject = Uri.encodeComponent(identitySubject);
    final json = await _client
        .get('/paying-parties/identity/$identityProvider/$encodedSubject');
    return PayingParty.fromJson(unwrapData(json));
  }

  Future<PayingParty> update(int id, UpdatePayingPartyRequest req) async {
    final json =
        await _client.patch('/paying-parties/$id', body: req.toJson());
    return PayingParty.fromJson(unwrapData(json));
  }

  Future<void> enableStripe(int id, String externalAccountId) async {
    await _client.post('/paying-parties/$id/enable-stripe',
        body: {'externalAccountId': externalAccountId});
  }

  Future<void> enablePayPal(int id, String externalAccountId) async {
    await _client.post('/paying-parties/$id/enable-paypal',
        body: {'externalAccountId': externalAccountId});
  }

  Future<VacantSeats> getVacantSeats(int id) async {
    final json = await _client.get('/paying-parties/$id/vacant-seats');
    return VacantSeats.fromJson(unwrapData(json));
  }
}
