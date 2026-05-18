/// Represents a non-2xx HTTP response from the Billing API.
class BillingApiException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? body;

  const BillingApiException({
    required this.statusCode,
    required this.message,
    this.body,
  });

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isUnprocessable => statusCode == 422;
  bool get isServerError => statusCode >= 500;

  @override
  String toString() =>
      'BillingApiException($statusCode): $message';
}
