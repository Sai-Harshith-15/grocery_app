import '../models/user_model.dart';

abstract class AuthInterface {
  Future<List<UserModel>> fetchUsersFromFirebase();

  Future<List<UserModel>> signup(
    String fullName,
    String email,
    String password,
  );

  Future<void> login(String email, String password);
  Future<bool> loginWithGoogle();

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<UserModel> getUserDetails(String uid);
}
