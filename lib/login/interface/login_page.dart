import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/login/domain/login_provider.dart';
import 'package:r5_app/todo/todo_injection.dart';
import 'package:r5_app/utils/r5_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: R5Colors.green,
      body: Form(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Iniciar Sesión',
                  style: GoogleFonts.rubik(
                    color: R5Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: loginProvider.emailController.value,
                  style: GoogleFonts.rubik(
                    color: R5Colors.blue,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      'Email',
                      style: GoogleFonts.rubik(
                        color: R5Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: loginProvider.obscureText,
                    builder: (context, obscureText, snapshot) {
                      return TextField(
                        obscureText: obscureText,
                        controller: loginProvider.passwordController.value,
                        style: GoogleFonts.rubik(
                          color: R5Colors.blue,
                        ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            'Contraseña',
                            style: GoogleFonts.rubik(
                              color: R5Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              //Puede parecer redundante pero si no hay un reseteo de valor en la
                              //Variable no hace la actualización de estado el ValueNotifier
                              loginProvider.obscureText.value =
                                  !loginProvider.obscureText.value;
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye_rounded,
                            ),
                            color: R5Colors.blue,
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    if (loginProvider.validateForm()) {
                      loginProvider.logIn().then(
                        (value) {
                          if (value.isSuccess == true) {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: TodoInjection.injection(),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Confirmar',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: R5Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
