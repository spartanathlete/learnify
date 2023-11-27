import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learnify/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<String> userSignup(UserModel user) async {
    String res = "";

    try {
      final UserCredential creds = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      res = await uploadImageToStorage(
        childName: 'profiles',
        file: user.photo!,
        isPost: false,
      );

      _firestore.collection('users').doc(creds.user!.uid).set(user.toJson());
      log('Done', name: 'userSignup()');
    } catch (error) {
      print('Error signing user : ${error.toString()}');
      res = 'Error: ${error.toString()}';
    }

    return res;
  }

  Future<String> userLogin(UserModel user) async {
    String res = "User signed up successfuly!";

    try {
      await _auth.signInWithEmailAndPassword(
        email: user.username!,
        password: user.password!,
      );
      log('User\'s ID: ${_auth.currentUser!.uid}');
      log('User\'s email: ${_auth.currentUser!.email}');
    } catch (error) {
      res = 'Error: ${error.toString()}';
    }

    return res;
  }

  Future<String> uploadImageToStorage({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  snackBar({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
