import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r5_app/todo/domain/todo_provider.dart';
import 'package:r5_app/todo/interface/todo_page.dart';

class TodoInjection {
  TodoInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => TodoProvider(),
      child: const TodoPage(),
    );
  }
}
