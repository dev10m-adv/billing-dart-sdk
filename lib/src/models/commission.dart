class Commission {
  final int id;
  final int affiliateId;
  final int? payingPartyId;
  final String status;
  final double amount;
  final String currency;
  final String? paidAt;

  const Commission({
    required this.id,
    required this.affiliateId,
    this.payingPartyId,
    required this.status,
    required this.amount,
    required this.currency,
    this.paidAt,
  });

  factory Commission.fromJson(Map<String, dynamic> j) => Commission(
        id: j['id'] as int,
        affiliateId: j['affiliateId'] as int,
        payingPartyId: j['payingPartyId'] as int?,
        status: j['status'] as String,
        amount: (j['amount'] as num).toDouble(),
        currency: j['currency'] as String,
        paidAt: j['paidAt'] as String?,
      );
}

class UpdateCommissionStatusRequest {
  final String status;
  final String? paidAt;

  const UpdateCommissionStatusRequest({required this.status, this.paidAt});

  Map<String, dynamic> toJson() => {
        'status': status,
        if (paidAt != null) 'paidAt': paidAt,
      };
}
