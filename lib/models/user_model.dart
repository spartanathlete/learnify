import 'dart:typed_data';

class UserModel {
  final String? id;
  final Uint8List? filePhoto;
  final String? urlPhoto;
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
    this.filePhoto,
    this.urlPhoto,
    this.email,
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return UserModel(
      id: id,
      urlPhoto: map['urlPhoto'] ?? '',
      firstname: map["firstname"] ?? '',
      lastname: map["lastname"] ?? '',
      username: map["username"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
    );
  }

  toJson({required String url}) {
    return {
      'firstname': firstname ?? '',
      'lastname': lastname ?? '',
      'username': username ?? '',
      'email': email ?? '',
      'urlPhoto': url,
      'password': password ?? '',
      'pubDate': DateTime.now(),
    };
  }
}
