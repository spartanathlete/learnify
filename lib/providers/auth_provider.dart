// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:learnify/models/user_model.dart';

// class AuthProvider {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   Future<UserModel?> getUserById() async {
//     try {
//       DocumentSnapshot userSnapshot = await _firestore
//           .collection('users')
//           .doc(_auth.currentUser!.toString())
//           .get();

//       // If the user document exists, return a UserModel
//       return UserModel.fromJson(
//         map: userSnapshot.data() as Map<String, dynamic>,
//         id: userSnapshot.id,
//       );
//     } catch (error) {
//       // Handle any errors that might occur during the process
//       print('Error retrieving user: $error');
//       return null;
//     }
//   }
// }
