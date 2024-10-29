import '../interfaces/auth_interface.dart';

class FirebaseAuthRepo {
  final AuthInterface interfaces;
  FirebaseAuthRepo({
    required this.interfaces,
  });

//add user data to the firevbase
  Future<void> signup(
    String email,
    String password,
    String fullName,
  ) async {
    return interfaces.signup(
      email,
      password,
      fullName,
    );
  }

  //getUserdata
  Future<void> login(String email, String password) async {
    return interfaces.login(email, password);
  }

  // Logout by calling the logout method from Interfaces
  Future<void> logout() async {
    return interfaces.logout();
  }

  Future<void> forgotPassword(String email) {
    return interfaces.forgotPassword(email);
  }
}
