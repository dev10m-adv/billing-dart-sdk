import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class AffiliateService {
  final IBillingHttpClient _client;
  AffiliateService(this._client);

  Future<List<Affiliate>> list({bool includeInactive = false}) async {
    final json = await _client.get('/affiliates',
        query: {'includeInactive': includeInactive.toString()});
    return unwrapList(json)
        .map((e) => Affiliate.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Affiliate> get(int id) async {
    final json = await _client.get('/affiliates/$id');
    return Affiliate.fromJson(unwrapData(json));
  }

  Future<Affiliate> create(CreateAffiliateRequest req) async {
    final json = await _client.post('/affiliates', body: req.toJson());
    return Affiliate.fromJson(unwrapData(json));
  }

  Future<Affiliate> update(int id, UpdateAffiliateRequest req) async {
    final json = await _client.patch('/affiliates/$id', body: req.toJson());
    return Affiliate.fromJson(unwrapData(json));
  }

  Future<List<PromoCode>> getPromoCodes(int affiliateId,
      {bool includeInactive = false}) async {
    final json = await _client.get('/affiliates/$affiliateId/promo-codes',
        query: {'includeInactive': includeInactive.toString()});
    return unwrapList(json)
        .map((e) => PromoCode.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Commission>> getCommissions(int affiliateId,
      {String? status, int limit = 50, int offset = 0}) async {
    final json = await _client.get('/affiliates/$affiliateId/commissions',
        query: {
          if (status != null) 'status': status,
          'limit': limit.toString(),
          'offset': offset.toString(),
        });
    return unwrapList(json)
        .map((e) => Commission.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
