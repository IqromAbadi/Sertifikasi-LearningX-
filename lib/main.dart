import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_iqromabadi/app/modules/Login/controllers/login_controller.dart';
import 'package:sertifikasi_iqromabadi/app/utils/Loading.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBvACO4pZ3s6WgDBp0MNUeMu_Vp76p-c18",
      appId: "1:139724572850:android:f029fc883d134f2cd5a1ab",
      messagingSenderId: "139724572850",
      projectId: "sertifikasi-c2580",
      storageBucket: "gs://sertifikasi-c2580.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.SPLASHSCREEN
                    : Routes.HOME,
            getPages: AppPages.routes,
          );
        }
        return const LoadingView();
      },
    );
  }
}
