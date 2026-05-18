/// Contract that every HTTP transport must satisfy.
/// Services depend on this abstraction, not on any concrete client,
/// which keeps them testable and transport-agnostic (DIP).
abstract class IBillingHttpClient {
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String?>? query,
    bool requiresAuth = true,
  });

  Future<Map<String, dynamic>> post(
    String path, {
    Object? body,
    Map<String, String?>? query,
    bool requiresAuth = true,
  });

  Future<Map<String, dynamic>> patch(
    String path, {
    Object? body,
    Map<String, String?>? query,
    bool requiresAuth = true,
  });

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, String?>? query,
    bool requiresAuth = true,
  });

  void dispose();
}
