/// Thrown when a transport-level failure occurs (no response received).
class BillingNetworkException implements Exception {
  final String message;
  final Object? cause;

  const BillingNetworkException(this.message, {this.cause});

  @override
  String toString() => 'BillingNetworkException: $message';
}
