import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/common/models/todo_model.dart';

class AddTodoExternal {
  final FirebaseFirestore collectionRef = FirebaseFirestore.instance;

  Future<ApiResponse> saveTodo(
      {required String uid, required Map<String, dynamic> data}) async {
    try {
      collectionRef.collection(uid).add(data);
      return ApiResponse(isSuccess: true, message: 'Guardado con éxito');
    } catch (e) {
      return ApiResponse(isSuccess: false, message: 'Guardado fallido');
    }
  }
}
