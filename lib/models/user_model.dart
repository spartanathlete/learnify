import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final ImageProvider? photo;
  final String? firstname;
  final String? lastname;
  final String? email;

  const UserModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.photo,
    required this.email,
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return UserModel(
      id: id,
      firstname: map["firstname"] ?? '',
      lastname: map["lastname"] ?? '',
      photo: map["photo"] ?? '',
      email: map["email"] ?? '',
    );
  }

  toJson() {
    return {
      'firstname': firstname ?? '',
      'lastname': lastname ?? '',
      'photo': photo ?? '',
      'email': email ?? '',
      'pubDate': DateTime.now(),
    };
  }
}
