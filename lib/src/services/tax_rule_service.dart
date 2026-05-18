import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class TaxRuleService {
  final IBillingHttpClient _client;
  TaxRuleService(this._client);

  Future<List<TaxRule>> list({String? scope, bool? isActive}) async {
    final json = await _client.get('/tax-rules', query: {
      if (scope != null) 'scope': scope,
      if (isActive != null) 'isActive': isActive.toString(),
    });
    return unwrapList(json)
        .map((e) => TaxRule.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<TaxRule>> getApplicable({
    required String jurisdiction,
    int? productId,
    int? planId,
  }) async {
    final json = await _client.get('/tax-rules/applicable', query: {
      'jurisdiction': jurisdiction,
      if (productId != null) 'productId': productId.toString(),
      if (planId != null) 'planId': planId.toString(),
    });
    return unwrapList(json)
        .map((e) => TaxRule.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TaxRule> get(int id) async {
    final json = await _client.get('/tax-rules/$id');
    return TaxRule.fromJson(unwrapData(json));
  }

  Future<TaxRule> create(CreateTaxRuleRequest req) async {
    final json = await _client.post('/tax-rules', body: req.toJson());
    return TaxRule.fromJson(unwrapData(json));
  }

  Future<TaxRule> update(int id, UpdateTaxRuleRequest req) async {
    final json = await _client.patch('/tax-rules/$id', body: req.toJson());
    return TaxRule.fromJson(unwrapData(json));
  }

  Future<Map<String, dynamic>> calculate(CalculateTaxesRequest req) async {
    return _client.post('/tax-rules/calculate', body: req.toJson());
  }

  Future<List<Map<String, dynamic>>> getInvoiceTaxes(int invoiceId) async {
    final json = await _client.get('/tax-rules/invoices/$invoiceId/taxes');
    return unwrapList(json).cast<Map<String, dynamic>>();
  }
}
