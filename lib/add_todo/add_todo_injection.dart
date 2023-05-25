import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/add_todo/domain/add_todo_provider.dart';
import 'package:r5_app/add_todo/interface/add_todo_page.dart';

class AddTodoInjection {
  AddTodoInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => AddTodoProvider(),
      child: const AddTodoPage(),
    );
  }
}
