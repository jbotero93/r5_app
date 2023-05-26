import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/add_todo/add_todo_injection.dart';
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
              '¡Recuerda hacer doble click para confirmar finalizar una tarea!',
              style: GoogleFonts.rubik(
                color: R5Colors.blue,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: todoProvider.apiResponse,
                  builder: (context, apiResponse, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: todoProvider.todoList,
                      builder: (context, todoList, snapshot) {
                        return ListView.builder(
                          itemCount: todoList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return apiResponse == null
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : apiResponse.isSuccess == false
                                    ? Center(
                                        child: Text(
                                          'Hubo un error con la info',
                                          style: GoogleFonts.rubik(
                                            color: R5Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    : apiResponse.isSuccess == true
                                        ? TodoCard().buildTodoCard(
                                            model: todoList[index],
                                            todoProvider: todoProvider,
                                            context: context,
                                          )
                                        : Center(
                                            child: Text(
                                              'Hubo un error inesperado',
                                              style: GoogleFonts.rubik(
                                                color: R5Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ),
                                            ),
                                          );
                          },
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
