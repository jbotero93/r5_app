import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r5_app/common/api_response.dart';

class MainLoadingProvider with ChangeNotifier {
  final isLogged = ValueNotifier<bool>(false);

  Future<void> checkAuth() async {
    final User? user = FirebaseAuth.instance.currentUser;
    isLogged.value = user == null ? false : true;
  }
}
