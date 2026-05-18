class BillingLicense {
  final String signedToken;

  const BillingLicense({required this.signedToken});

  factory BillingLicense.fromJson(Map<String, dynamic> j) =>
      BillingLicense(signedToken: j['signedToken'] as String);
}
