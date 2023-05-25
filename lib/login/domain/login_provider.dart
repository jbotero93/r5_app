import 'package:flutter/material.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/login/external/login_external.dart';

class LoginProvider with ChangeNotifier {
  final emailController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final passwordController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final obscureText = ValueNotifier<bool>(true);

  bool validateForm() {
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    if (email.isEmpty || password.isEmpty || password.length < 6) {
      return false;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      return false;
    }

    return true;
  }

  Future<ApiResponse> logIn() async {
    final apiResponse = await LoginExternal().logIn(
      email: emailController.value.text,
      password: passwordController.value.text,
    );

    return apiResponse;
  }
}
