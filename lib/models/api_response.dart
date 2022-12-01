// Take Body Response from Api
class APIResponse<T> {
  T? data;
  bool? error;
  String? errorMessage;
  Object? createdNote;
  Object? updatedNote;

  APIResponse(
      {this.data,
      this.error = false,
      this.errorMessage,
      this.createdNote,
      this.updatedNote});
}

class APIUpdateResponse<T> {
  T? data;
  bool? error;
  String? errorMessage;
  Object? createdNote;
  Object? updatedNote;

  APIUpdateResponse(
      {this.data,
      this.error = false,
      this.errorMessage,
      this.createdNote,
      this.updatedNote});
}
