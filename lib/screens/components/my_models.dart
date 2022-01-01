class ExceptionAwareResponse<T> {
  dynamic error;
  T? response;
  ExceptionAwareResponse({
    required this.response,
    this.error,
  });
}
