class TaxRule {
  final int id;
  final String taxRuleName;
  final String scope;
  final String? jurisdiction;
  final int? productId;
  final int? planId;
  final String rateType;
  final double rateValue;
  final bool inclusive;
  final String? effectiveFrom;
  final String? effectiveTo;
  final int priority;
  final String? description;
  final bool isActive;

  const TaxRule({
    required this.id,
    required this.taxRuleName,
    required this.scope,
    this.jurisdiction,
    this.productId,
    this.planId,
    required this.rateType,
    required this.rateValue,
    this.inclusive = false,
    this.effectiveFrom,
    this.effectiveTo,
    this.priority = 0,
    this.description,
    this.isActive = true,
  });

  factory TaxRule.fromJson(Map<String, dynamic> j) => TaxRule(
        id: j['id'] as int,
        taxRuleName: j['taxRuleName'] as String,
        scope: j['scope'] as String,
        jurisdiction: j['jurisdiction'] as String?,
        productId: j['productId'] as int?,
        planId: j['planId'] as int?,
        rateType: j['rateType'] as String,
        rateValue: (j['rateValue'] as num).toDouble(),
        inclusive: j['inclusive'] as bool? ?? false,
        effectiveFrom: j['effectiveFrom'] as String?,
        effectiveTo: j['effectiveTo'] as String?,
        priority: j['priority'] as int? ?? 0,
        description: j['description'] as String?,
        isActive: j['isActive'] as bool? ?? true,
      );
}

class TaxLineItem {
  final String type;
  final String description;
  final double amount;

  const TaxLineItem({
    required this.type,
    required this.description,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
        'amount': amount,
      };
}

class CalculateTaxesRequest {
  final String jurisdiction;
  final int? productId;
  final int? planId;
  final List<TaxLineItem> lineItems;

  const CalculateTaxesRequest({
    required this.jurisdiction,
    this.productId,
    this.planId,
    required this.lineItems,
  });

  Map<String, dynamic> toJson() => {
        'jurisdiction': jurisdiction,
        if (productId != null) 'productId': productId,
        if (planId != null) 'planId': planId,
        'lineItems': lineItems.map((e) => e.toJson()).toList(),
      };
}

class CreateTaxRuleRequest {
  final String taxRuleName;
  final String scope;
  final String? jurisdiction;
  final int? productId;
  final int? planId;
  final String rateType;
  final double rateValue;
  final bool inclusive;
  final String? effectiveFrom;
  final String? effectiveTo;
  final int priority;
  final String? description;

  const CreateTaxRuleRequest({
    required this.taxRuleName,
    required this.scope,
    this.jurisdiction,
    this.productId,
    this.planId,
    required this.rateType,
    required this.rateValue,
    this.inclusive = false,
    this.effectiveFrom,
    this.effectiveTo,
    this.priority = 0,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'taxRuleName': taxRuleName,
        'scope': scope,
        if (jurisdiction != null) 'jurisdiction': jurisdiction,
        if (productId != null) 'productId': productId,
        if (planId != null) 'planId': planId,
        'rateType': rateType,
        'rateValue': rateValue,
        'inclusive': inclusive,
        if (effectiveFrom != null) 'effectiveFrom': effectiveFrom,
        if (effectiveTo != null) 'effectiveTo': effectiveTo,
        'priority': priority,
        if (description != null) 'description': description,
      };
}

class UpdateTaxRuleRequest {
  final String? taxRuleName;
  final double? rateValue;
  final bool? isActive;
  final String? effectiveTo;

  const UpdateTaxRuleRequest({
    this.taxRuleName,
    this.rateValue,
    this.isActive,
    this.effectiveTo,
  });

  Map<String, dynamic> toJson() => {
        if (taxRuleName != null) 'taxRuleName': taxRuleName,
        if (rateValue != null) 'rateValue': rateValue,
        if (isActive != null) 'isActive': isActive,
        if (effectiveTo != null) 'effectiveTo': effectiveTo,
      };
}
