import 'package:flutter/material.dart';

class Profile {
  final ImageProvider photo;
  final String firstname;
  final String lastname;
  final String email;

  const Profile({
    required this.firstname,
    required this.lastname,
    required this.photo,
    required this.email,
  });
}
