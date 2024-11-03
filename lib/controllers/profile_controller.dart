import 'package:get/get.dart';

import '../data/models/user_model.dart';
import '../data/repositories/firebase_auth_repo.dart';
import '../globals/globals.dart';
import '../routes/routes.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserDetails();
  }

  var name = "".obs;
  var profileUrl = "".obs;
  var email = "".obs;

  final FirebaseAuthRepo? firebaseAuthRepo;
  ProfileController({this.firebaseAuthRepo});

  Future<void> fetchUserDetails() async {
    try {
      // Use await to resolve the Future and get UserModel
      UserModel user = await firebaseAuthRepo!.getUserDetails(Globals.userId!);

      // Now assign values to observables
      name.value = user.fullName;
      profileUrl.value = user.userImg;
      email.value = user.email;
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> logout() async {
    await firebaseAuthRepo?.logout().then((_) {
      Get.snackbar('Logout', 'Successfully logged out.');
      Get.toNamed(Routes.login);
    }).catchError((error) {
      Get.snackbar('Logout Error', 'Failed to log out. Please try again.');
      print("Error during logout: $error");
    });
  }
}
