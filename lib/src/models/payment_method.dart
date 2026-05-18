class PaymentMethod {
  final int id;
  final String provider;
  final String? last4;
  final String? brand;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.provider,
    this.last4,
    this.brand,
    this.isDefault = false,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> j) => PaymentMethod(
        id: j['id'] as int,
        provider: j['provider'] as String,
        last4: j['last4'] as String?,
        brand: j['brand'] as String?,
        isDefault: j['isDefault'] as bool? ?? false,
      );
}
