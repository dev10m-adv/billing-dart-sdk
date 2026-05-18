import 'jwt_payload_keys.dart';

/// Paying party (org) that owns the subscriptions.
/// Schema: id, identity_provider, identity_subject, billing_email, organization_name (optional).
class PayingParty {
  const PayingParty({
    required this.id,
    required this.identityProvider,
    required this.identitySubject,
    required this.billingEmail,
    this.organizationName,
  });

  final String id;

  /// IdP name (e.g. "google", "microsoft").
  final String identityProvider;

  /// Subject ID from the identity provider.
  final String identitySubject;
  final String billingEmail;
  final String? organizationName;

  /// Legacy: use [identitySubject]. Kept for backward compatibility.
  String get ssoId => identitySubject;

  /// Parses from JWT payload map (snake_case or camelCase). Throws [FormatException] if invalid.
  /// Accepts current schema (identity_provider, identity_subject) or legacy sso_id.
  factory PayingParty.fromJson(Map<String, dynamic> json) {
    final id = getKey(json, 'id', 'id');
    final identityProvider = getKey(
      json,
      'identity_provider',
      'identityProvider',
    );
    final identitySubject = getKey(json, 'identity_subject', 'identitySubject');
    final ssoIdLegacy = getKey(json, 'sso_id', 'ssoId');
    final billingEmail = getKey(json, 'billing_email', 'billingEmail');
    if (id is! String || id.isEmpty)
      throw FormatException('paying_party.id required.');
    if (billingEmail is! String)
      throw FormatException('paying_party.billing_email required.');
    final provider = identityProvider is String && identityProvider.isNotEmpty
        ? identityProvider
        : (ssoIdLegacy is String && ssoIdLegacy.isNotEmpty ? 'legacy' : null);
    final subject = identitySubject is String && identitySubject.isNotEmpty
        ? identitySubject
        : (ssoIdLegacy is String ? ssoIdLegacy : null);
    if (provider == null || subject == null) {
      throw FormatException(
        'paying_party: identity_provider and identity_subject required (or legacy sso_id).',
      );
    }
    final org = getKey(json, 'organization_name', 'organizationName');
    return PayingParty(
      id: id,
      identityProvider: provider,
      identitySubject: subject,
      billingEmail: billingEmail,
      organizationName: org is String ? org : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayingParty &&
          id == other.id &&
          identityProvider == other.identityProvider &&
          identitySubject == other.identitySubject &&
          billingEmail == other.billingEmail &&
          organizationName == other.organizationName;

  @override
  int get hashCode => Object.hash(
        id,
        identityProvider,
        identitySubject,
        billingEmail,
        organizationName,
      );
}

class BillingAddress {
  final String? line1;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  const BillingAddress({
    this.line1,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> j) => BillingAddress(
        line1: j['line1'] as String?,
        city: j['city'] as String?,
        state: j['state'] as String?,
        postalCode: j['postal_code'] as String?,
        country: j['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (line1 != null) 'line1': line1,
        if (city != null) 'city': city,
        if (state != null) 'state': state,
        if (postalCode != null) 'postal_code': postalCode,
        if (country != null) 'country': country,
      };
}

class PayingPartyApi {
  final int id;
  final String identityProvider;
  final String identitySubject;
  final String? organizationName;
  final String? billingEmail;
  final BillingAddress? billingAddress;
  final String? taxId;
  final bool stripeEnabled;
  final bool paypalEnabled;
  final String? defaultPaymentProvider;
  final String? defaultPaymentMethodId;
  final int gracePeriodDays;
  final double? minimumChargeThreshold;

  const PayingPartyApi({
    required this.id,
    required this.identityProvider,
    required this.identitySubject,
    this.organizationName,
    this.billingEmail,
    this.billingAddress,
    this.taxId,
    this.stripeEnabled = false,
    this.paypalEnabled = false,
    this.defaultPaymentProvider,
    this.defaultPaymentMethodId,
    this.gracePeriodDays = 0,
    this.minimumChargeThreshold,
  });

  factory PayingPartyApi.fromJson(Map<String, dynamic> j) => PayingPartyApi(
        id: j['id'] as int,
        identityProvider: j['identityProvider'] as String,
        identitySubject: j['identitySubject'] as String,
        organizationName: j['organizationName'] as String?,
        billingEmail: j['billingEmail'] as String?,
        billingAddress: j['billingAddressJson'] != null
            ? BillingAddress.fromJson(
                j['billingAddressJson'] as Map<String, dynamic>)
            : null,
        taxId: j['taxId'] as String?,
        stripeEnabled: j['stripeEnabled'] as bool? ?? false,
        paypalEnabled: j['paypalEnabled'] as bool? ?? false,
        defaultPaymentProvider: j['defaultPaymentProvider'] as String?,
        defaultPaymentMethodId: j['defaultPaymentMethodId'] as String?,
        gracePeriodDays: j['gracePeriodDays'] as int? ?? 0,
        minimumChargeThreshold:
            (j['minimumChargeThreshold'] as num?)?.toDouble(),
      );
}

class CreatePayingPartyRequest {
  final String identityProvider;
  final String identitySubject;
  final String? organizationName;
  final String? billingEmail;
  final BillingAddress? billingAddress;
  final String? taxId;

  const CreatePayingPartyRequest({
    required this.identityProvider,
    required this.identitySubject,
    this.organizationName,
    this.billingEmail,
    this.billingAddress,
    this.taxId,
  });

  Map<String, dynamic> toJson() => {
        'identityProvider': identityProvider,
        'identitySubject': identitySubject,
        if (organizationName != null) 'organizationName': organizationName,
        if (billingEmail != null) 'billingEmail': billingEmail,
        if (billingAddress != null)
          'billingAddressJson': billingAddress!.toJson(),
        if (taxId != null) 'taxId': taxId,
      };
}

class UpdatePayingPartyRequest {
  final String? organizationName;
  final String? billingEmail;
  final BillingAddress? billingAddress;
  final String? taxId;
  final bool? stripeEnabled;
  final bool? paypalEnabled;
  final String? defaultPaymentProvider;
  final String? defaultPaymentMethodId;
  final int? gracePeriodDays;
  final double? minimumChargeThreshold;

  const UpdatePayingPartyRequest({
    this.organizationName,
    this.billingEmail,
    this.billingAddress,
    this.taxId,
    this.stripeEnabled,
    this.paypalEnabled,
    this.defaultPaymentProvider,
    this.defaultPaymentMethodId,
    this.gracePeriodDays,
    this.minimumChargeThreshold,
  });

  Map<String, dynamic> toJson() => {
        if (organizationName != null) 'organizationName': organizationName,
        if (billingEmail != null) 'billingEmail': billingEmail,
        if (billingAddress != null)
          'billingAddressJson': billingAddress!.toJson(),
        if (taxId != null) 'taxId': taxId,
        if (stripeEnabled != null) 'stripeEnabled': stripeEnabled,
        if (paypalEnabled != null) 'paypalEnabled': paypalEnabled,
        if (defaultPaymentProvider != null)
          'defaultPaymentProvider': defaultPaymentProvider,
        if (defaultPaymentMethodId != null)
          'defaultPaymentMethodId': defaultPaymentMethodId,
        if (gracePeriodDays != null) 'gracePeriodDays': gracePeriodDays,
        if (minimumChargeThreshold != null)
          'minimumChargeThreshold': minimumChargeThreshold,
      };
}

class VacantSeats {
  final int vacantCount;

  const VacantSeats({required this.vacantCount});

  factory VacantSeats.fromJson(Map<String, dynamic> j) =>
      VacantSeats(vacantCount: j['vacantCount'] as int? ?? 0);
}
