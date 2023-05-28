import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/add_todo/add_todo_injection.dart';
import 'package:r5_app/common/models/todo_model.dart';
import 'package:r5_app/main_loading/main_loading_injection.dart';
import 'package:r5_app/todo/domain/todo_provider.dart';
import 'package:r5_app/todo/interface/widgets/todo_card.dart';
import 'package:r5_app/utils/r5_colors.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: AddTodoInjection.injection(),
            ),
          );
        },
        backgroundColor: R5Colors.green,
        child: const Icon(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R5 ToDo!',
                  style: GoogleFonts.rubik(
                    color: R5Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                InkWell(
                  onTap: () {
                    todoProvider.logOut().then(
                      (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(value.message),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: MainLoadingInjection.injection(),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Cerrar sesión',
                    style: GoogleFonts.rubik(
                      color: R5Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '¡Recuerda renovar tu seguro con nosotros!',
              style: GoogleFonts.rubik(
                color: R5Colors.blue,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: todoProvider.getTodoList(),
                builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<TodoModel> todoList = snapshot.data!;

                    return ListView.builder(
                      itemCount: todoList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TodoCard().buildTodoCard(
                          model: todoList[index],
                          todoProvider: todoProvider,
                          context: context,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Hubo un error con la info',
                        style: GoogleFonts.rubik(
                          color: R5Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
