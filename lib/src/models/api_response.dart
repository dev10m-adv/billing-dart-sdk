/// Standard API response envelope returned by every endpoint.
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  const ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  ) {
    return ApiResponse(
      success: json['success'] as bool? ?? true,
      data: json['data'] != null ? fromData(json['data']) : null,
      message: json['message'] as String?,
    );
  }
}
