import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/login/domain/login_provider.dart';
import 'package:r5_app/login/interface/login_page.dart';

class LoginInjection {
  LoginInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => LoginProvider(),
      child: const LoginPage(),
    );
  }
}
