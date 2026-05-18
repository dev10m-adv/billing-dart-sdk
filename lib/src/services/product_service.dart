import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class ProductService {
  final IBillingHttpClient _client;
  ProductService(this._client);

  Future<List<Product>> list({bool includeInactive = false}) async {
    final json = await _client.get('/products',
        query: {'includeInactive': includeInactive.toString()});
    return unwrapList(json)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Product> get(int id) async {
    final json = await _client.get('/products/$id');
    return Product.fromJson(unwrapData(json));
  }

  Future<Product> create(CreateProductRequest req) async {
    final json = await _client.post('/products', body: req.toJson());
    return Product.fromJson(unwrapData(json));
  }

  Future<Product> update(int id, UpdateProductRequest req) async {
    final json = await _client.patch('/products/$id', body: req.toJson());
    return Product.fromJson(unwrapData(json));
  }

  Future<void> delete(int id) async {
    await _client.delete('/products/$id');
  }
}
