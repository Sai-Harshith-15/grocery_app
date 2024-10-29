abstract class AuthInterface {
  Future<void> signup(
    String email,
    String password,
    String fullName,
    
  );

  Future<void> login(String email, String password);
  Future<void> logout();

  Future<void> forgotPassword(String email);
}
