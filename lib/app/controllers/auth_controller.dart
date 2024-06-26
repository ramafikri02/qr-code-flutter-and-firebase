import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //? cek kondisi -> ada auth atau tidak
  //? null -> tidak ada user yang login
  //? uid -> ada user yang login
  String? uid;

  late FirebaseAuth auth;

//! Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      return {"error": false, "message": "Berhasil login"};
    } on FirebaseAuthException catch (e) {
      //? Error firebase
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //? Error general
      return {"error": true, "message": "Tidak dapat login"};
    }
  }

//! Logout
  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();

      return {"error": false, "message": "Berhasil logout"};
    } on FirebaseAuthException catch (e) {
      //? Error firebase
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //? Error general
      return {"error": true, "message": "Tidak dapat logout"};
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}
