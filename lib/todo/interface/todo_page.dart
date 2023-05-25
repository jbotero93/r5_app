import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:r5_app/todo/todo_injection.dart';
import 'package:r5_app/utils/r5_colors.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: TodoInjection.injection(),
            ),
          );
        },
        backgroundColor: R5Colors.green,
        child: Icon(
          Icons.add_task_sharp,
          color: R5Colors.blue,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'R5 ToDo!',
              style: GoogleFonts.rubik(
                color: R5Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
