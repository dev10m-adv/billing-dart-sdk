enum InvoiceStatus {
  draft,
  pending,
  processing,
  paid,
  failed,
  overdue,
  void_;

  static InvoiceStatus fromString(String value) =>
      InvoiceStatus.values.firstWhere(
        (e) =>
            e.name.toLowerCase() == value.toLowerCase() ||
            (value.toLowerCase() == 'void' && e == InvoiceStatus.void_),
        orElse: () => InvoiceStatus.draft,
      );
}

enum InvoiceType { recurring, proration, oneTime, combined }

class Invoice {
  final int id;
  final int subscriptionId;
  final int payingPartyId;
  final String billingInterval;
  final String? invoiceNumber;
  final InvoiceType? invoiceType;
  final InvoiceStatus status;
  final double amount;
  final String currency;
  final String? description;
  final String? dueDate;
  final String? graceEndDate;
  final String? paidAt;
  final String? externalInvoiceId;
  final bool? autoPayAttempted;
  final int? retryCount;
  final String? createdAt;
  final String? updatedAt;

  const Invoice({
    required this.id,
    required this.subscriptionId,
    required this.payingPartyId,
    required this.billingInterval,
    this.invoiceNumber,
    this.invoiceType,
    required this.status,
    required this.amount,
    required this.currency,
    this.description,
    this.dueDate,
    this.graceEndDate,
    this.paidAt,
    this.externalInvoiceId,
    this.autoPayAttempted,
    this.retryCount,
    this.createdAt,
    this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> j) => Invoice(
        id: _toInt(j['id']) ?? 0,
        subscriptionId: _toInt(j['subscriptionId']) ?? 0,
        payingPartyId: _toInt(j['payingPartyId']) ?? 0,
        billingInterval: _toStr(j['billingInterval']) ?? '',
        invoiceNumber: _toStr(j['invoiceNumber']),
        invoiceType: Invoice._parseInvoiceType(j['invoiceType']),
        status: InvoiceStatus.fromString(_toStr(j['status']) ?? 'draft'),
        amount: _toDouble(j['amount']) ?? 0,
        currency: _toStr(j['currency']) ?? '',
        description: _toStr(j['description']),
        dueDate: _toStr(j['dueDate']),
        graceEndDate: _toStr(j['graceEndDate']),
        paidAt: _toStr(j['paidAt']),
        externalInvoiceId: _toStr(j['externalInvoiceId']),
        autoPayAttempted: _toBool(j['autoPayAttempted']),
        retryCount: _toInt(j['retryCount']),
        createdAt: _toStr(j['createdAt']),
        updatedAt: _toStr(j['updatedAt']),
      );

  static InvoiceType? _parseInvoiceType(dynamic raw) {
    final value = _toStr(raw);
    if (value == null || value.isEmpty) return null;
    final normalized = value.toLowerCase();
    if (normalized == 'onetime' || normalized == 'one_time') {
      return InvoiceType.oneTime;
    }
    return InvoiceType.values.firstWhere(
      (e) => e.name.toLowerCase() == normalized,
      orElse: () => InvoiceType.proration,
    );
  }
}

int? _toInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v.trim());
  return null;
}

double? _toDouble(dynamic v) {
  if (v is double) return v;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v.trim());
  return null;
}

String? _toStr(dynamic v) {
  if (v == null) return null;
  if (v is String) return v;
  return v.toString();
}

bool? _toBool(dynamic v) {
  if (v is bool) return v;
  if (v is String) {
    final s = v.trim().toLowerCase();
    if (s == 'true') return true;
    if (s == 'false') return false;
  }
  return null;
}

class CreateInvoiceRequest {
  final int subscriptionId;
  final int payingPartyId;
  final String billingInterval;
  final String invoiceType;
  final double amount;
  final String currency;
  final String? description;
  final String? dueDate;
  final int? gracePeriodDays;
  final Map<String, dynamic>? prorationDetailsJson;

  const CreateInvoiceRequest({
    required this.subscriptionId,
    required this.payingPartyId,
    required this.billingInterval,
    required this.invoiceType,
    required this.amount,
    required this.currency,
    this.description,
    this.dueDate,
    this.gracePeriodDays,
    this.prorationDetailsJson,
  });

  Map<String, dynamic> toJson() => {
        'subscriptionId': subscriptionId,
        'payingPartyId': payingPartyId,
        'billingInterval': billingInterval,
        'invoiceType': invoiceType,
        'amount': amount,
        'currency': currency,
        if (description != null) 'description': description,
        if (dueDate != null) 'dueDate': dueDate,
        if (gracePeriodDays != null) 'gracePeriodDays': gracePeriodDays,
        if (prorationDetailsJson != null)
          'prorationDetailsJson': prorationDetailsJson,
      };
}

class UpdateInvoiceRequest {
  final String? status;
  final String? externalInvoiceId;
  final String? externalPaymentId;
  final String? paidAt;
  final bool? autoPayAttempted;
  final String? autoPayAttemptedAt;
  final int? retryCount;
  final String? nextRetryAt;

  const UpdateInvoiceRequest({
    this.status,
    this.externalInvoiceId,
    this.externalPaymentId,
    this.paidAt,
    this.autoPayAttempted,
    this.autoPayAttemptedAt,
    this.retryCount,
    this.nextRetryAt,
  });

  Map<String, dynamic> toJson() => {
        if (status != null) 'status': status,
        if (externalInvoiceId != null) 'externalInvoiceId': externalInvoiceId,
        if (externalPaymentId != null) 'externalPaymentId': externalPaymentId,
        if (paidAt != null) 'paidAt': paidAt,
        if (autoPayAttempted != null) 'autoPayAttempted': autoPayAttempted,
        if (autoPayAttemptedAt != null)
          'autoPayAttemptedAt': autoPayAttemptedAt,
        if (retryCount != null) 'retryCount': retryCount,
        if (nextRetryAt != null) 'nextRetryAt': nextRetryAt,
      };
}

class GenerateProrationRequest {
  final int subscriptionId;
  final int previousQuantity;
  final int newQuantity;
  final double pricePerUnit;
  final String periodStart;
  final String periodEnd;
  final String changeDate;
  final String nextBillingDate;

  const GenerateProrationRequest({
    required this.subscriptionId,
    required this.previousQuantity,
    required this.newQuantity,
    required this.pricePerUnit,
    required this.periodStart,
    required this.periodEnd,
    required this.changeDate,
    required this.nextBillingDate,
  });

  Map<String, dynamic> toJson() => {
        'subscriptionId': subscriptionId,
        'previousQuantity': previousQuantity,
        'newQuantity': newQuantity,
        'pricePerUnit': pricePerUnit,
        'periodStart': periodStart,
        'periodEnd': periodEnd,
        'changeDate': changeDate,
        'nextBillingDate': nextBillingDate,
      };
}
