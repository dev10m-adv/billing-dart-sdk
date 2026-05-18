/// Async callback that returns a fresh JWT bearer token, or null when
/// the caller is unauthenticated.
typedef TokenProvider = Future<String?> Function();
