class Plan {
  final int id;
  final int productId;
  final String name;
  final String? description;
  final String billingInterval;
  final double basePrice;
  final String currency;
  final List<String> features;
  final bool isActive;

  const Plan({
    required this.id,
    required this.productId,
    required this.name,
    this.description,
    required this.billingInterval,
    required this.basePrice,
    required this.currency,
    this.features = const [],
    this.isActive = true,
  });

  factory Plan.fromJson(Map<String, dynamic> j) => Plan(
        id: j['id'] as int,
        productId: j['productId'] as int,
        name: j['name'] as String,
        description: j['description'] as String?,
        billingInterval: j['billingInterval'] as String,
        basePrice: (j['basePrice'] as num).toDouble(),
        currency: j['currency'] as String,
        features: (j['features'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        isActive: j['isActive'] as bool? ?? true,
      );
}

class Pricing {
  final int id;
  final int planId;
  final double price;
  final String currency;
  final bool isActive;

  const Pricing({
    required this.id,
    required this.planId,
    required this.price,
    required this.currency,
    this.isActive = true,
  });

  factory Pricing.fromJson(Map<String, dynamic> j) => Pricing(
        id: j['id'] as int,
        planId: j['planId'] as int,
        price: (j['price'] as num).toDouble(),
        currency: j['currency'] as String,
        isActive: j['isActive'] as bool? ?? true,
      );
}

class CreatePlanRequest {
  final int productId;
  final String name;
  final String? description;
  final String billingInterval;
  final double basePrice;
  final String currency;
  final List<String>? features;

  const CreatePlanRequest({
    required this.productId,
    required this.name,
    this.description,
    required this.billingInterval,
    required this.basePrice,
    required this.currency,
    this.features,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        if (description != null) 'description': description,
        'billingInterval': billingInterval,
        'basePrice': basePrice,
        'currency': currency,
        if (features != null) 'features': features,
      };
}

class UpdatePlanRequest {
  final String? name;
  final String? description;
  final double? basePrice;
  final String? currency;
  final List<String>? features;
  final bool? isActive;

  const UpdatePlanRequest({
    this.name,
    this.description,
    this.basePrice,
    this.currency,
    this.features,
    this.isActive,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (basePrice != null) 'basePrice': basePrice,
        if (currency != null) 'currency': currency,
        if (features != null) 'features': features,
        if (isActive != null) 'isActive': isActive,
      };
}
