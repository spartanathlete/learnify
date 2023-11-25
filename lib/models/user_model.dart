import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final Uint8List? photo;
  final String? srcPhoto;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? password;

  const UserModel({
    this.id,
    this.username,
    this.password,
    this.firstname,
    this.lastname,
    this.photo,
    this.srcPhoto,
    this.email,
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return UserModel(
      id: id,
      photo: map["photo"] ?? '',
      srcPhoto: map['srcPhoto'] ?? '',
      firstname: map["firstname"] ?? '',
      lastname: map["lastname"] ?? '',
      username: map["username"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
    );
  }

  toJson() {
    return {
      'srcPhoto': srcPhoto ?? '',
      'firstname': firstname ?? '',
      'lastname': lastname ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'pubDate': DateTime.now(),
    };
  }
}
