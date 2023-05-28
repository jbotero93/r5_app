import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r5_app/add_todo/external/add_todo_external.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/common/models/todo_model.dart';

class AddTodoProvider with ChangeNotifier {
  final contentController =
      ValueNotifier<TextEditingController>(TextEditingController());

  final titleController =
      ValueNotifier<TextEditingController>(TextEditingController());

  Future<ApiResponse> saveTodo() async {
    //Auth
    User user = FirebaseAuth.instance.currentUser!;
    //Model
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    TodoModel model = TodoModel(
      uid: user.uid,
      content: contentController.value.text,
      displayDate: formattedDate,
      isFinished: false,
      dateTime: now,
      timeStamp: Timestamp.now(),
      title: titleController.value.text,
    );

    return await AddTodoExternal().saveTodo(uid: user.uid, data: model.toMap());
  }
}
