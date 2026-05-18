class CheckoutSessionResult {
  final String url;
  final String sessionId;

  const CheckoutSessionResult({required this.url, required this.sessionId});

  factory CheckoutSessionResult.fromJson(Map<String, dynamic> j) =>
      CheckoutSessionResult(
        url: j['url'] as String,
        sessionId: j['sessionId'] as String,
      );
}

class CreateCheckoutSessionRequest {
  final int planId;
  final int pricingId;
  final String successUrl;
  final String cancelUrl;

  const CreateCheckoutSessionRequest({
    required this.planId,
    required this.pricingId,
    required this.successUrl,
    required this.cancelUrl,
  });

  Map<String, dynamic> toJson() => {
        'planId': planId,
        'pricingId': pricingId,
        'successUrl': successUrl,
        'cancelUrl': cancelUrl,
      };
}

class FulfillCheckoutRequest {
  final String sessionId;
  final String paymentMethodId;
  final String customerId;
  final String chargeId;
  final String status;

  const FulfillCheckoutRequest({
    required this.sessionId,
    required this.paymentMethodId,
    required this.customerId,
    required this.chargeId,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'paymentMethodId': paymentMethodId,
        'customerId': customerId,
        'chargeId': chargeId,
        'status': status,
      };
}
