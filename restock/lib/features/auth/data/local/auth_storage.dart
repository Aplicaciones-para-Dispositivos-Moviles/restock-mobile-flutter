 
class AuthStorage {
  static int? _userId;
  static String? _token;

  Future<void> saveSession({
    required int userId,
    required String token,
  }) async {
    _userId = userId;
    _token = token;
  }

  Future<int?> getUserId() async => _userId;

  Future<String?> getToken() async => _token;

  Future<void> clear() async {
    _userId = null;
    _token = null;
  }
}
