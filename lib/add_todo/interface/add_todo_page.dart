import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/add_todo/domain/add_todo_provider.dart';
import 'package:r5_app/common/widgets/r5_appbar.dart';
import 'package:r5_app/utils/r5_colors.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addTodoProvider = Provider.of<AddTodoProvider>(context);
    return Scaffold(
      appBar: R5AppBar().r5AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Título',
                style: GoogleFonts.rubik(
                  color: R5Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: addTodoProvider.titleController.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Expresate',
                style: GoogleFonts.rubik(
                  color: R5Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: addTodoProvider.contentController.value,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        addTodoProvider.saveTodo().then((value) {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Aceptar',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
