import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/common/models/todo_model.dart';
import 'package:r5_app/todo/external/todo_external.dart';

class TodoProvider with ChangeNotifier {
  final todoList = ValueNotifier<List<TodoModel>>([]);
  final apiResponse = ValueNotifier<ApiResponse?>(null);
  final isLoading = ValueNotifier<bool>(false);

  Future<ApiResponse> getTodoList() async {
    User user = FirebaseAuth.instance.currentUser!;
    return TodoExternal().getTodoList(uid: user.uid).then((value) {
      todoList.value = value.data;
      apiResponse.value = value;
      return value;
    });
  }

  Future<ApiResponse> deleteTodo({required TodoModel todoModel}) async {
    return await TodoExternal()
        .deleteTodo(
      todoModel: todoModel,
    )
        .then((value) async {
      await getTodoList();
      return value;
    });
  }

  Future<ApiResponse> finishedTodo({required TodoModel todoModel}) async {
    isLoading.value = true;
    return TodoExternal()
        .finishedTodo(todoModel: todoModel)
        .then((value) async {
      await getTodoList();
      isLoading.value = false;
      return value;
    });
  }

  Future<ApiResponse> logOut() async {
    return TodoExternal().logOut();
  }
}
