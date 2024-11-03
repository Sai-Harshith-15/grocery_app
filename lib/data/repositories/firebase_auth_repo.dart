import '../interfaces/auth_interface.dart';
import '../models/user_model.dart';

class FirebaseAuthRepo {
  final AuthInterface interfaces;
  FirebaseAuthRepo({
    required this.interfaces,
  });

  //fetch users from firebase
  Future<List<UserModel>> fetchUsersFromFirebase() async {
    return await interfaces.fetchUsersFromFirebase();
  }

//add user data to the firevbase
  Future<List<UserModel>> signup(
    String fullName,
    String email,
    String password,
  ) async {
    return interfaces.signup(
      fullName,
      email,
      password,
    );
  }

  //getUserdata
  Future<void> login(String email, String password) async {
    return interfaces.login(email, password);
  }

  //google login

  Future<bool> loginWithGoogle() async {
    return interfaces.loginWithGoogle();
  }

  // Logout by calling the logout method from Interfaces
  Future<void> logout() async {
    return interfaces.logout();
  }

  Future<void> forgotPassword(String email) {
    return interfaces.forgotPassword(email);
  }

  Future<UserModel> getUserDetails(String uid) {
    return interfaces.getUserDetails(uid);
  }
}
