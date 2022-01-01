class ExceptionAwareResponse<T> {
  dynamic error;
  T? response;
  ExceptionAwareResponse({
    required this.response,
    this.error,
  });
}

class UserData {
  final String email;
  final String name;
  final String imgurl;
  final String phone;
  const UserData({
    this.email = '',
    this.name = '',
    this.imgurl = '',
    this.phone = '',
  });
}
