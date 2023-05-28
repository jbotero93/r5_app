import 'package:flutter/material.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/common/models/todo_model.dart';
import 'package:r5_app/todo/external/todo_external.dart';

class TodoProvider with ChangeNotifier {
  final todoList = ValueNotifier<List<TodoModel>>([]);
  final isLoading = ValueNotifier<bool>(false);

  Stream<List<TodoModel>>? getTodoList() {
    isLoading.value = true;
    return TodoExternal().getTodoList();
  }

  Future<ApiResponse> deleteTodo({required TodoModel todoModel}) async {
    return await TodoExternal()
        .deleteTodo(
      todoModel: todoModel,
    )
        .then((value) async {
      return value;
    });
  }

  Future<ApiResponse> finishedTodo({required TodoModel todoModel}) async {
    isLoading.value = true;
    return await TodoExternal()
        .finishedTodo(todoModel: todoModel)
        .then((value) async {
      isLoading.value = false;
      return value;
    });
  }

  Future<ApiResponse> logOut() async {
    return TodoExternal().logOut();
  }
}
