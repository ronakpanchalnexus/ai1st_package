// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

import 'package:bestforming_cac/src/features/authentication/domain/entity/sign_in_entity.dart';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel extends SignInEntity {
  const SignInModel({
    super.code,
    super.message,
    super.data,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : SignInData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class SignInData {
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;
  int? userId;

  SignInData({
    this.token,
    this.userEmail,
    this.userNicename,
    this.userDisplayName,
    this.userId,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
        token: json["token"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
    userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
        "user_id": userId,
      };
}
