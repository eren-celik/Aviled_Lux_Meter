import 'dart:convert';

ApiToken apiTokenFromJson(String str) => ApiToken.fromJson(json.decode(str));

String apiTokenToJson(ApiToken data) => json.encode(data.toJson());

class ApiToken {
  ApiToken({
    this.success,
    this.apiToken,
  });

  String success;
  String apiToken;

  factory ApiToken.fromJson(Map<String, dynamic> json) => ApiToken(
        success: json['success'],
        apiToken: json['api_token'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'api_token': apiToken,
      };
}

SuccessMessageModel successMessageModelFromJson(String str) => SuccessMessageModel.fromJson(json.decode(str));

String successMessageModelToJson(SuccessMessageModel data) => json.encode(data.toJson());

class SuccessMessageModel {
  SuccessMessageModel({
    this.success,
  });

  String success;

  factory SuccessMessageModel.fromJson(Map<String, dynamic> json) => SuccessMessageModel(
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
      };
}
