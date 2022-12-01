// Take Body Response from Api
class APIResponse<T> {
  T? data;
  bool? error;
  String? errorMessage;
  Object? createdNote;

  APIResponse(
      {this.data, this.error = false, this.errorMessage, this.createdNote});
}
