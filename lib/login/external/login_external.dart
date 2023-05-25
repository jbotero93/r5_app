import 'package:firebase_auth/firebase_auth.dart';
import 'package:r5_app/common/api_response.dart';

class LoginExternal {
  Future<ApiResponse> logIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      return ApiResponse(
          isSuccess: true, message: 'Sesión iniciada', data: user);
    } catch (e) {
      return ApiResponse(
          isSuccess: false,
          message: 'Inicio de sesión fallido, valida tus datos');
    }
  }
}
