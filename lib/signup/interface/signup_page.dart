import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/signup/domain/signup_provider.dart';
import 'package:r5_app/todo/todo_injection.dart';
import 'package:r5_app/utils/r5_colors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      backgroundColor: R5Colors.blue,
      body: Theme(
        data: ThemeData(
          primarySwatch: const MaterialColor(
            0xFF04D7A4,
            <int, Color>{
              50: Color(0xFFE9F9F7),
              100: Color(0xFFC8F2E6),
              200: Color(0xFFA4EDD5),
              300: Color(0xFF80E7C3),
              400: Color(0xFF5CE2B2),
              500: Color(0xFF38DDA1),
              600: Color(0xFF30C992),
              700: Color(0xFF28B283),
              800: Color(0xFF209874),
              900: Color(0xFF188D65),
            },
          ),
        ),
        child: Form(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crear cuenta',
                    style: GoogleFonts.rubik(
                      color: R5Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: signupProvider.emailController.value,
                    style: GoogleFonts.rubik(
                      color: R5Colors.green,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text(
                        'Email',
                        style: GoogleFonts.rubik(
                          color: R5Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: signupProvider.obscureText,
                    builder: (context, obscureText, snapshot) {
                      return TextField(
                        obscureText: obscureText,
                        controller: signupProvider.passwordController.value,
                        style: GoogleFonts.rubik(
                          color: R5Colors.green,
                        ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            'Contraseña',
                            style: GoogleFonts.rubik(
                              color: R5Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              //Puede parecer redundante pero si no hay un reseteo de valor en la
                              //Variable no hace la actualización de estado el ValueNotifier
                              signupProvider.obscureText.value =
                                  !signupProvider.obscureText.value;
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye_rounded,
                            ),
                            color: R5Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (signupProvider.validateForm()) {
                        signupProvider.signUp().then(
                          (value) {
                            if (value.isSuccess == true) {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: TodoInjection.injection(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.message),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.message),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Datos en formato incorrecto'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 20),
                      decoration: BoxDecoration(
                        color: R5Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Confirmar',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                        Text(
                          'Volver atras',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
