import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:r5_app/common/models/todo_model.dart';
import 'package:r5_app/todo/domain/todo_provider.dart';
import 'package:r5_app/utils/r5_colors.dart';

class TodoCard {
  Container buildTodoCard({
    required TodoModel model,
    required TodoProvider todoProvider,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: model.isFinished,
              onChanged: (value) {
                model.isFinished = value!;
                todoProvider.finishedTodo(todoModel: model);
              },
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.title,
                    style: GoogleFonts.rubik(
                      color: R5Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(model.content),
                  const Divider(
                    color: R5Colors.green,
                  ),
                  Text(model.displayDate),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                todoProvider.deleteTodo(todoModel: model).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.message),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                });
              },
              child: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
