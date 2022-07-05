class LoginResponse {
  late int responseCode;
  late Data data;

  LoginResponse({required this.responseCode, required this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    data = new Data.fromJson(json['data']);
  }
}

class Data {
 late String name;
 late String email;
 late String token;
 late String adminId;

  Data({required this.name,required this.email,required this.token,required this.adminId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    token = json['token'];
    adminId = json['admin_id'];
  }

}
