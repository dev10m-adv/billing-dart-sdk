import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class PromoCodeService {
  final IBillingHttpClient _client;
  PromoCodeService(this._client);

  Future<List<PromoCode>> list(
      {int? affiliateId, bool includeInactive = false}) async {
    final json = await _client.get('/promo-codes', query: {
      if (affiliateId != null) 'affiliateId': affiliateId.toString(),
      'includeInactive': includeInactive.toString(),
    });
    return unwrapList(json)
        .map((e) => PromoCode.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PromoCode> getByCode(String code) async {
    final json = await _client.get('/promo-codes/$code');
    return PromoCode.fromJson(unwrapData(json));
  }

  Future<PromoCode> getById(int id) async {
    final json = await _client.get('/promo-codes/id/$id');
    return PromoCode.fromJson(unwrapData(json));
  }

  Future<Map<String, dynamic>> validate(String code) async {
    return _client.post('/promo-codes/validate', body: {'code': code});
  }

  Future<PromoCode> create(CreatePromoCodeRequest req) async {
    final json = await _client.post('/promo-codes', body: req.toJson());
    return PromoCode.fromJson(unwrapData(json));
  }

  Future<PromoCode> update(int id, UpdatePromoCodeRequest req) async {
    final json = await _client.patch('/promo-codes/$id', body: req.toJson());
    return PromoCode.fromJson(unwrapData(json));
  }
}
