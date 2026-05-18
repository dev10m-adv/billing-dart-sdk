class Affiliate {
  final int id;
  final String affiliateCode;
  final String name;
  final String? email;
  final Map<String, dynamic>? contactInfo;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const Affiliate({
    required this.id,
    required this.affiliateCode,
    required this.name,
    this.email,
    this.contactInfo,
    this.isActive = true,
    this.metadata,
  });

  factory Affiliate.fromJson(Map<String, dynamic> j) => Affiliate(
        id: j['id'] as int,
        affiliateCode: j['affiliateCode'] as String,
        name: j['name'] as String,
        email: j['email'] as String?,
        contactInfo: j['contactInfoJson'] as Map<String, dynamic>?,
        isActive: j['isActive'] as bool? ?? true,
        metadata: j['metadataJson'] as Map<String, dynamic>?,
      );
}

class CreateAffiliateRequest {
  final String affiliateCode;
  final String name;
  final String? email;
  final Map<String, dynamic>? contactInfo;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const CreateAffiliateRequest({
    required this.affiliateCode,
    required this.name,
    this.email,
    this.contactInfo,
    this.isActive = true,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'affiliateCode': affiliateCode,
        'name': name,
        if (email != null) 'email': email,
        if (contactInfo != null) 'contactInfoJson': contactInfo,
        'isActive': isActive,
        if (metadata != null) 'metadataJson': metadata,
      };
}

class UpdateAffiliateRequest {
  final String? name;
  final String? email;
  final bool? isActive;
  final Map<String, dynamic>? metadata;

  const UpdateAffiliateRequest({
    this.name,
    this.email,
    this.isActive,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (isActive != null) 'isActive': isActive,
        if (metadata != null) 'metadataJson': metadata,
      };
}
