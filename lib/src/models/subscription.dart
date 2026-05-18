class Subscription {
  final int id;
  final int payingPartyId;
  final int pricingId;
  final int planId;
  final String status;
  final String? paymentProvider;
  final String? externalSubscriptionId;
  final String? externalCustomerId;
  final String? assignedIdentityProvider;
  final String? assignedIdentitySubject;
  final String? userPartyEmail;
  final String? currentPeriodStart;
  final String? currentPeriodEnd;

  const Subscription({
    required this.id,
    required this.payingPartyId,
    required this.pricingId,
    required this.planId,
    required this.status,
    this.paymentProvider,
    this.externalSubscriptionId,
    this.externalCustomerId,
    this.assignedIdentityProvider,
    this.assignedIdentitySubject,
    this.userPartyEmail,
    this.currentPeriodStart,
    this.currentPeriodEnd,
  });

  factory Subscription.fromJson(Map<String, dynamic> j) => Subscription(
        id: j['id'] as int,
        payingPartyId: j['payingPartyId'] as int,
        pricingId: j['pricingId'] as int,
        planId: j['planId'] as int,
        status: j['status'] as String,
        paymentProvider: j['paymentProvider'] as String?,
        externalSubscriptionId: j['externalSubscriptionId'] as String?,
        externalCustomerId: j['externalCustomerId'] as String?,
        assignedIdentityProvider: j['assignedIdentityProvider'] as String?,
        assignedIdentitySubject: j['assignedIdentitySubject'] as String?,
        userPartyEmail: j['userPartyEmail'] as String?,
        currentPeriodStart: j['currentPeriodStart'] as String?,
        currentPeriodEnd: j['currentPeriodEnd'] as String?,
      );
}

class CreateSubscriptionRequest {
  final int payingPartyId;
  final int pricingId;
  final int planId;
  final String paymentProvider;
  final String? currentPeriodStart;
  final String? currentPeriodEnd;
  final String? externalCustomerId;
  final String? assignedIdentityProvider;
  final String? assignedIdentitySubject;
  final String? createdByIdentityProvider;
  final String? createdByIdentitySubject;
  final String? userPartyEmail;
  final String? promoCode;

  const CreateSubscriptionRequest({
    required this.payingPartyId,
    required this.pricingId,
    required this.planId,
    required this.paymentProvider,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.externalCustomerId,
    this.assignedIdentityProvider,
    this.assignedIdentitySubject,
    this.createdByIdentityProvider,
    this.createdByIdentitySubject,
    this.userPartyEmail,
    this.promoCode,
  });

  Map<String, dynamic> toJson() => {
        'payingPartyId': payingPartyId,
        'pricingId': pricingId,
        'planId': planId,
        'paymentProvider': paymentProvider,
        if (currentPeriodStart != null) 'currentPeriodStart': currentPeriodStart,
        if (currentPeriodEnd != null) 'currentPeriodEnd': currentPeriodEnd,
        if (externalCustomerId != null) 'externalCustomerId': externalCustomerId,
        if (assignedIdentityProvider != null)
          'assignedIdentityProvider': assignedIdentityProvider,
        if (assignedIdentitySubject != null)
          'assignedIdentitySubject': assignedIdentitySubject,
        if (createdByIdentityProvider != null)
          'createdByIdentityProvider': createdByIdentityProvider,
        if (createdByIdentitySubject != null)
          'createdByIdentitySubject': createdByIdentitySubject,
        if (userPartyEmail != null) 'userPartyEmail': userPartyEmail,
        if (promoCode != null) 'promoCode': promoCode,
      };
}

class UpdateSubscriptionRequest {
  final String? status;
  final String? externalSubscriptionId;
  final String? userPartyEmail;
  final String? currentPeriodStart;
  final String? currentPeriodEnd;

  const UpdateSubscriptionRequest({
    this.status,
    this.externalSubscriptionId,
    this.userPartyEmail,
    this.currentPeriodStart,
    this.currentPeriodEnd,
  });

  Map<String, dynamic> toJson() => {
        if (status != null) 'status': status,
        if (externalSubscriptionId != null)
          'externalSubscriptionId': externalSubscriptionId,
        if (userPartyEmail != null) 'userPartyEmail': userPartyEmail,
        if (currentPeriodStart != null) 'currentPeriodStart': currentPeriodStart,
        if (currentPeriodEnd != null) 'currentPeriodEnd': currentPeriodEnd,
      };
}

class AddSeatRequest {
  final int planId;
  final int pricingId;
  final String? assignedIdentityProvider;
  final String? assignedIdentitySubject;
  final String? userPartyEmail;

  const AddSeatRequest({
    required this.planId,
    required this.pricingId,
    this.assignedIdentityProvider,
    this.assignedIdentitySubject,
    this.userPartyEmail,
  });

  Map<String, dynamic> toJson() => {
        'planId': planId,
        'pricingId': pricingId,
        if (assignedIdentityProvider != null)
          'assignedIdentityProvider': assignedIdentityProvider,
        if (assignedIdentitySubject != null)
          'assignedIdentitySubject': assignedIdentitySubject,
        if (userPartyEmail != null) 'userPartyEmail': userPartyEmail,
      };
}

class AssignSeatRequest {
  final String identityProvider;
  final String identitySubject;

  const AssignSeatRequest({
    required this.identityProvider,
    required this.identitySubject,
  });

  Map<String, dynamic> toJson() => {
        'identityProvider': identityProvider,
        'identitySubject': identitySubject,
      };
}

class TransferSeatRequest {
  final String fromIdentityProvider;
  final String fromIdentitySubject;
  final String toIdentityProvider;
  final String toIdentitySubject;

  const TransferSeatRequest({
    required this.fromIdentityProvider,
    required this.fromIdentitySubject,
    required this.toIdentityProvider,
    required this.toIdentitySubject,
  });

  Map<String, dynamic> toJson() => {
        'fromIdentityProvider': fromIdentityProvider,
        'fromIdentitySubject': fromIdentitySubject,
        'toIdentityProvider': toIdentityProvider,
        'toIdentitySubject': toIdentitySubject,
      };
}
