class LoginRequest {
  late String email;
  late String uuid;

  LoginRequest({required this.email, required this.uuid});

  Map<String, String> toJson() {
    final Map<String,String> _data = Map<String, String>();
    _data['email'] = email;
    _data['uuid'] = uuid;
    return _data;
  }
}
