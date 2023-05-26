import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:r5_app/common/api_response.dart';
import 'package:r5_app/common/models/todo_model.dart';

class TodoExternal {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<ApiResponse> getTodoList({required String uid}) async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection(uid).get();
      List<TodoModel> todos =
          querySnapshot.docs.map((doc) => TodoModel.fromSnapshot(doc)).toList();

      return ApiResponse(
        isSuccess: true,
        message: 'Datos obtenidos correctamente',
        data: todos,
      );
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        message: 'Hubo un error al obtener los datos',
      );
    }
  }

  Future<ApiResponse> deleteTodo({
    required TodoModel todoModel,
  }) async {
    try {
      firestore
          .collection(uid)
          .where('timeStamp', isEqualTo: todoModel.timeStamp)
          .get()
          .then(
        (querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.delete();
          }
        },
      );
      return ApiResponse(isSuccess: true, message: 'Eliminado correctamente');
    } catch (e) {
      return ApiResponse(
          isSuccess: false, message: 'Hubo un error al eliminar la tarea');
    }
  }

  Future<ApiResponse> finishedTodo({
    required TodoModel todoModel,
  }) async {
    try {
      firestore
          .collection(uid)
          .where('timeStamp', isEqualTo: todoModel.timeStamp)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update({'isFinished': todoModel.isFinished});
        }
      });
      return ApiResponse(
          isSuccess: true, message: 'Finalizado, felicitaciones!!');
    } catch (e) {
      return ApiResponse(
          isSuccess: false, message: 'Hubo un error al marcarlo');
    }
  }

  Future<ApiResponse> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return ApiResponse(
          isSuccess: true, message: 'Sesión cerrada correctamente');
    } catch (e) {
      return ApiResponse(
          isSuccess: false, message: 'No se ha podido cerrar la sesión');
    }
  }
}
