class GeneralResponse {
  late int responseCode;
  late String message;

  GeneralResponse({required this.responseCode, required this.message});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['response_message'];
  }

  
}

