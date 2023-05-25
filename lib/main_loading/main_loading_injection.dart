import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/main_loading/domain/main_loading_provider.dart';
import 'package:r5_app/main_loading/interface/main_loading_page.dart';

class MainLoadingInjection {
  MainLoadingInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => MainLoadingProvider()..checkAuth(),
      child: const MainLoadingPage(),
    );
  }
}
