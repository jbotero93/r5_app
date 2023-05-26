import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/signup/domain/signup_provider.dart';
import 'package:r5_app/signup/interface/signup_page.dart';

class SignupInjection {
  SignupInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => SignupProvider(),
      child: const SignupPage(),
    );
  }
}
