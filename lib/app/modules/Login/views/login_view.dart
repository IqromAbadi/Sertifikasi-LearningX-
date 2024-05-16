import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sertifikasi_iqromabadi/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1663F2),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    const Text(
                      "Welcome Back,\nPlease login to your account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.usernameController,
                          cursorColor: const Color(0xffD9D9D9),
                          style: const TextStyle(
                            color: Color(0xffD9D9D9),
                          ),
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Color(0xffD9D9D9),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextField(
                            obscureText: !controller.passwordVisible.value,
                            controller: controller.passwordController,
                            cursorColor: const Color(0xffD9D9D9),
                            style: const TextStyle(
                              color: Color(0xffD9D9D9),
                            ),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                color: Color(0xffD9D9D9),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.passwordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  controller.passwordVisible.value =
                                      !controller.passwordVisible.value;
                                },
                                color: const Color(0xffD9D9D9),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => controller.login(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0D0D0F),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Color(0xff0D0D0F),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffd9d9d9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: RichText(
              text: TextSpan(
                text: 'Don\'t have any account? ',
                style: const TextStyle(
                  color: Color(0xffd9d9d9),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(
                      color: Color(0xffd9d9d9),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(Routes.REGISTER);
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
