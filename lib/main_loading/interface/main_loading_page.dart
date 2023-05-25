import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/login/login_injection.dart';
import 'package:r5_app/main_loading/domain/main_loading_provider.dart';
import 'package:r5_app/todo/todo_injection.dart';
import 'package:r5_app/utils/r5_colors.dart';

class MainLoadingPage extends StatelessWidget {
  const MainLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainLoadingProvider = Provider.of<MainLoadingProvider>(context);
    return Scaffold(
      backgroundColor: R5Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: mainLoadingProvider.isLogged,
                builder: (context, isLogged, snapshot) {
                  return AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'R5 ToDo!',
                        textStyle: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: R5Colors.blue,
                          fontSize: 30,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    onFinished: () async {
                      if (!isLogged) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: LoginInjection.injection(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: TodoInjection.injection(),
                          ),
                        );
                      }
                    },
                  );
                }),
            Text(
              'Tu lista de deberes más segura :)',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: R5Colors.blue,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
