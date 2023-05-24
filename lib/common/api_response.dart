class ApiResponse {
  String message;
  bool isSuccess;
  dynamic data;

  ApiResponse({
    required this.isSuccess,
    required this.message,
    this.data,
  });
}
