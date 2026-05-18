Map<String, dynamic> unwrapData(Map<String, dynamic> json) {
  if (json.containsKey('data') && json['data'] is Map<String, dynamic>) {
    return json['data'] as Map<String, dynamic>;
  }
  return json;
}

List<dynamic> unwrapList(Map<String, dynamic> json) {
  return json['data'] as List<dynamic>? ??
      json['items'] as List<dynamic>? ??
      [];
}
