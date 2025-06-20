class AuthRepository {
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return email == 'test@test.com' && password == 'password';
  }

  Future<bool> signup(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
