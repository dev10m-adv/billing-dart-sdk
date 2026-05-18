class HealthStatus {
  final String status;
  final String timestamp;

  const HealthStatus({required this.status, required this.timestamp});

  factory HealthStatus.fromJson(Map<String, dynamic> j) => HealthStatus(
        status: j['status'] as String,
        timestamp: j['timestamp'] as String,
      );
}
