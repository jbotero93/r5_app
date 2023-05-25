import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r5_app/firebase_options.dart';
import 'package:r5_app/main_loading/main_loading_injection.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        primarySwatch: const MaterialColor(
          0xFF040464,
          <int, Color>{
            50: Color(0xFFE9E9F6),
            100: Color(0xFFC8C8E1),
            200: Color(0xFFA4A4CB),
            300: Color(0xFF8080B5),
            400: Color(0xFF5C5CA0),
            500: Color(0xFF38388B),
            600: Color(0xFF30307A),
            700: Color(0xFF28286A),
            800: Color(0xFF202059),
            900: Color(0xFF181849),
          },
        ),
      ),
      home: MainLoadingInjection.injection(),
    );
  }
}
