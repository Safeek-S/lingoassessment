enum StatusCode {
  success,
  failure,
  error,
}

class ServiceResult<T> {
  final StatusCode statusCode;
  final String message;
  final T data;

  ServiceResult(this.statusCode, this.message, this.data,);
}
