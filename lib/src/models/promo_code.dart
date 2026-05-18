class PromoCode {
  final int id;
  final int? affiliateId;
  final String promoCode;
  final String? description;
  final String discountType;
  final double discountValue;
  final int? customerDiscountDurationMonths;
  final int? affiliateCommissionDurationMonths;
  final String? validFrom;
  final String? validUntil;
  final int? maxUses;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const PromoCode({
    required this.id,
    this.affiliateId,
    required this.promoCode,
    this.description,
    required this.discountType,
    required this.discountValue,
    this.customerDiscountDurationMonths,
    this.affiliateCommissionDurationMonths,
    this.validFrom,
    this.validUntil,
    this.maxUses,
    this.isActive = true,
    this.metadata,
  });

  factory PromoCode.fromJson(Map<String, dynamic> j) => PromoCode(
        id: j['id'] as int,
        affiliateId: j['affiliateId'] as int?,
        promoCode: j['promoCode'] as String,
        description: j['description'] as String?,
        discountType: j['discountType'] as String,
        discountValue: (j['discountValue'] as num).toDouble(),
        customerDiscountDurationMonths:
            j['customerDiscountDurationMonths'] as int?,
        affiliateCommissionDurationMonths:
            j['affiliateCommissionDurationMonths'] as int?,
        validFrom: j['validFrom'] as String?,
        validUntil: j['validUntil'] as String?,
        maxUses: j['maxUses'] as int?,
        isActive: j['isActive'] as bool? ?? true,
        metadata: j['metadataJson'] as Map<String, dynamic>?,
      );
}

class CreatePromoCodeRequest {
  final int? affiliateId;
  final String promoCode;
  final String? description;
  final String discountType;
  final double discountValue;
  final int? customerDiscountDurationMonths;
  final int? affiliateCommissionDurationMonths;
  final String? validFrom;
  final String? validUntil;
  final int? maxUses;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const CreatePromoCodeRequest({
    this.affiliateId,
    required this.promoCode,
    this.description,
    required this.discountType,
    required this.discountValue,
    this.customerDiscountDurationMonths,
    this.affiliateCommissionDurationMonths,
    this.validFrom,
    this.validUntil,
    this.maxUses,
    this.isActive = true,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        if (affiliateId != null) 'affiliateId': affiliateId,
        'promoCode': promoCode,
        if (description != null) 'description': description,
        'discountType': discountType,
        'discountValue': discountValue,
        if (customerDiscountDurationMonths != null)
          'customerDiscountDurationMonths': customerDiscountDurationMonths,
        if (affiliateCommissionDurationMonths != null)
          'affiliateCommissionDurationMonths': affiliateCommissionDurationMonths,
        if (validFrom != null) 'validFrom': validFrom,
        if (validUntil != null) 'validUntil': validUntil,
        if (maxUses != null) 'maxUses': maxUses,
        'isActive': isActive,
        if (metadata != null) 'metadataJson': metadata,
      };
}

class UpdatePromoCodeRequest {
  final String? description;
  final int? customerDiscountDurationMonths;
  final String? validUntil;
  final int? maxUses;
  final bool? isActive;

  const UpdatePromoCodeRequest({
    this.description,
    this.customerDiscountDurationMonths,
    this.validUntil,
    this.maxUses,
    this.isActive,
  });

  Map<String, dynamic> toJson() => {
        if (description != null) 'description': description,
        if (customerDiscountDurationMonths != null)
          'customerDiscountDurationMonths': customerDiscountDurationMonths,
        if (validUntil != null) 'validUntil': validUntil,
        if (maxUses != null) 'maxUses': maxUses,
        if (isActive != null) 'isActive': isActive,
      };
}
