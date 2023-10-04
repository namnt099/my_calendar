import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/domain/model/account/user.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/ultis/firebase/firebase_database.dart';
import 'package:my_calendar/widgets/views/show_loading_screen.dart';

class FirebaseAuthService {
  static Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    late final LoginUser loginUser;
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then(
          (credential) => {
            loginUser = LoginUser(
              email: credential.user?.email ?? '',
              photoUrl: credential.user?.photoURL ?? '',
              uid: credential.user?.uid ?? '',
              token: credential.user?.refreshToken ?? '',
              displayName: credential.user?.displayName ?? '',
            ),
            FirebaseDB.insertUser(loginUser),
            saveUserInfo(loginUser),

          },
        );
  }

  static Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await PrefsService.clear();
    await googleSignIn.signOut();
    HiveLocal.clearData();
  }

  static Future<void> signUpWithEmail(String email, String password) async {
    ShowLoadingScreen.show();
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ShowLoadingScreen.dismiss();
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          S.current.success,
          '${S.current.register} ${S.current.success.toLowerCase()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      ShowLoadingScreen.dismiss();
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          S.current.error,
          e.code,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  static Future<bool> signInWithEmail(String email, String password) async {
    var success = false;
    ShowLoadingScreen.show();
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      late final LoginUser loginUser;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ShowLoadingScreen.dismiss();
        loginUser = LoginUser(
          email: value.user?.email ?? '',
          photoUrl: value.user?.photoURL ?? '',
          uid: value.user?.uid ?? '',
          token: value.user?.refreshToken ?? '',
          displayName: value.user?.displayName ?? '',
          networkImage: false,
        );
        saveUserInfo(loginUser);
        FirebaseDB.insertUser(loginUser);
        success = true;
        return success;
      });
    } on FirebaseAuthException catch (e) {
      ShowLoadingScreen.dismiss();
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          S.current.error,
          e.code,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      success = false;
      return success;
    }
    return success;
  }

  static void saveUserInfo(LoginUser user) {
    PrefsService.saveFullName(user.displayName);
    PrefsService.saveEmail(user.email);
    PrefsService.saveUId(user.uid);
    PrefsService.savePhoto(user.photoUrl);
    HiveLocal.saveDataUser(user);
  }
}
