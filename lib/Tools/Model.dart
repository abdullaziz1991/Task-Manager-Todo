// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";

class UserModle {
  final String Id;
  final String Username;
  final String Email;
  final String FirstName;
  final String LastName;
  final String Gender;
  final String Image;
  final String Token;
  final String RefreshToken;

  UserModle({
    required this.Id,
    required this.Username,
    required this.Email,
    required this.FirstName,
    required this.LastName,
    required this.Gender,
    required this.Image,
    required this.Token,
    required this.RefreshToken,
  });
  factory UserModle.fromJson(Map<String, dynamic> json) {
    return UserModle(
      Id: json['id'],
      Username: json['username'],
      Email: json["email"],
      FirstName: json['firstName'],
      LastName: json['lastName'],
      Gender: json['gender'],
      Image: json['image'],
      Token: json['token'],
      RefreshToken: json['refreshToken'],
    );
  }
}

class TodoModle {
  final String Todo_Id;
  final String Id_In_SqlLite;
  final String Todo_Text;
  String Todo_Completed;
  final String Todo_Priority;
  final String Todo_Date;
  final String Todo_Time;
  //final String Todo_UserId;

  TodoModle({
    required this.Todo_Id,
    required this.Id_In_SqlLite,
    required this.Todo_Text,
    required this.Todo_Completed,
    required this.Todo_Priority,
    required this.Todo_Date,
    required this.Todo_Time,
  });
  // factory TodoModle.fromJson(Map<String, dynamic> json) {
  //   return TodoModle(
  //     Todo_Id: json['id'].toString(),
  //     Id_In_SqlLite: json['id'].toString(),
  //     Todo_Text: json['todo'],
  //     Todo_Completed: json['completed'].toString(),
  //     //   Todo_UserId: json['userId'].toString(),
  //   );
  // }
}
