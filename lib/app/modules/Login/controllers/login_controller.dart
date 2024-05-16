import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_iqromabadi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordVisible = true.obs;

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login() async {
    final String email = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Semua Form harus diisi');
      return;
    }

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        Get.snackbar('Berhasil', 'Pengguna berhasil masuk');
        usernameController.clear();
        passwordController.clear();
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', 'Harap verifikasi email Anda');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'Username yang diberikan salah.',
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Password yang diberikan salah.',
        );
      } else if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Error',
          'Terlalu banyak permintaan. Coba lagi nanti.',
        );
      } else {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat login. Silakan coba lagi nanti.',
        );
        print(e);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat login. Silakan coba lagi nanti.',
      );
      print(e);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
