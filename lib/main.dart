import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r5_app/firebase_options.dart';
import 'package:r5_app/main_loading/interface/main_loading_page.dart';
import 'package:r5_app/main_loading/main_loading_injection.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainLoadingInjection.injection(),
    );
  }
}
