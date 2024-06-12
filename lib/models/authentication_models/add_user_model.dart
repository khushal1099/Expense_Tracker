import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_model.dart';

class AddUserModel {
  static final AddUserModel _instace = AddUserModel._();

  AddUserModel._();

  factory AddUserModel() {
    return _instace;
  }

  void addUser(User? users) {
    AuthUser authUser = AuthUser(
      name: users?.displayName ?? '',
      image: users?.photoURL,
      email: users?.email,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(users?.uid)
        .set(authUser.toJson());
  }
}
