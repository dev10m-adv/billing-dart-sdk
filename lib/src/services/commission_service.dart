import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class CommissionService {
  final IBillingHttpClient _client;
  CommissionService(this._client);

  Future<List<Commission>> list({
    int? affiliateId,
    int? payingPartyId,
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    final json = await _client.get('/commissions', query: {
      if (affiliateId != null) 'affiliateId': affiliateId.toString(),
      if (payingPartyId != null) 'payingPartyId': payingPartyId.toString(),
      if (status != null) 'status': status,
      'limit': limit.toString(),
      'offset': offset.toString(),
    });
    return unwrapList(json)
        .map((e) => Commission.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Commission> updateStatus(
      int id, UpdateCommissionStatusRequest req) async {
    final json =
        await _client.patch('/commissions/$id/status', body: req.toJson());
    return Commission.fromJson(unwrapData(json));
  }
}
