import '../core/i_billing_http_client.dart';
import '../models/models.dart';
import 'service_helpers.dart';

class SubscriptionService {
  final IBillingHttpClient _client;
  SubscriptionService(this._client);

  Future<Map<String, dynamic>> getMeBillingSummary() async {
    return _client.get('/subscriptions/me');
  }

  Future<List<Subscription>> listMine() async {
    final json = await _client.get('/subscriptions');
    return unwrapList(json)
        .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Subscription> get(int id) async {
    final json = await _client.get('/subscriptions/$id');
    return Subscription.fromJson(unwrapData(json));
  }

  Future<Subscription> create(CreateSubscriptionRequest req) async {
    final json = await _client.post('/subscriptions', body: req.toJson());
    return Subscription.fromJson(unwrapData(json));
  }

  Future<Subscription> update(int id, UpdateSubscriptionRequest req) async {
    final json = await _client.patch('/subscriptions/$id', body: req.toJson());
    return Subscription.fromJson(unwrapData(json));
  }

  Future<Subscription> addSeat(AddSeatRequest req) async {
    final json =
        await _client.post('/subscriptions/seats', body: req.toJson());
    return Subscription.fromJson(unwrapData(json));
  }

  Future<void> removeSeat(int seatId) async {
    await _client.delete('/subscriptions/seats/$seatId');
  }

  Future<Subscription> assignUser(
      int subscriptionId, AssignSeatRequest req) async {
    final json = await _client.post('/subscriptions/$subscriptionId/assign',
        body: req.toJson());
    return Subscription.fromJson(unwrapData(json));
  }

  Future<Subscription> unassignUser(int subscriptionId) async {
    final json = await _client
        .post('/subscriptions/$subscriptionId/unassign', body: {});
    return Subscription.fromJson(unwrapData(json));
  }

  Future<Subscription> transferSeat(
      int subscriptionId, TransferSeatRequest req) async {
    final json = await _client.post('/subscriptions/$subscriptionId/transfer',
        body: req.toJson());
    return Subscription.fromJson(unwrapData(json));
  }
}
