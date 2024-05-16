import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sertifikasi_iqromabadi/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var passwordVisible = true.obs;
  var confirmpasswordVisible = true.obs;

  late String userId;

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    usernameController = TextEditingController();

    super.onInit();
  }

  void register() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua form harus diisi');
      return;
    }

    if (password.length > 16) {
      Get.snackbar('Error', 'Password maksimal 16 karakter');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password tidak sama');
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      userId = userCredential.user!.uid;
      await addData(userId, username, password, confirmPassword);
      Get.snackbar('Berhasil', 'Pengguna berhasil dibuat');
      userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: 'Verifikasi email Anda',
        middleText:
            'Silakan verifikasi email Anda untuk melanjutkan. Kami telah mengirimkan tautan verifikasi email kepada Anda.',
        textConfirm: 'OK',
        textCancel: 'Kirim ulang',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAllNamed(Routes.LOGIN);
        },
        onCancel: () {
          userCredential.user!.sendEmailVerification();
          Get.snackbar('Berhasil', 'Tautan verifikasi email terkirim');
        },
      );
      usernameController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Password yang diberikan terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Akun sudah ada untuk email tersebut.');
      } else {
        Get.snackbar('Error', e.message ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addData(String userId, String username, String password,
      String confirmPassword) async {
    try {
      await FirebaseFirestore.instance.collection('User').doc(userId).set({
        'username': username,
        'password': password,
        'confirm password': confirmPassword,
      });
    } catch (e) {
      print(e);
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
