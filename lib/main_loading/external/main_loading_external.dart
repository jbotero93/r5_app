import 'package:r5_app/common/api_response.dart';

class MainLoadingExternal {
  Future<ApiResponse> checkSession() async {
    return ApiResponse(isSuccess: false, message: 'Failed');
  }

  Future<ApiResponse> getToDoList() async {
    return ApiResponse(isSuccess: false, message: 'Failed');
  }
}
