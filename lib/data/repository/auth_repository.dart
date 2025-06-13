import 'dart:developer';

import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/data/services/base_repository.dart';

class AuthRepository extends BaseRepositories {
  Future<UserModel> signUp({
    required String fullname,
    required String username,
    required String email,
    required String phonenumber,
    required String password,
  }) async {
    try {
      final formattedphonenumber = phonenumber.replaceAll(
        RegExp(r'\s+'),
        " ".trim(),
      );
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw "Failed To create The User";
      }
      final user = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        fullname: fullname,
        email: email,
        password: password,
        phonenumber: formattedphonenumber,
      );
      await saveUserData(user);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw "User Not Found";
      }
      final userData = await getUserData(userCredential.user!.uid);
      return userData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    try {
      await firestore.collection("users").doc(user.uid).set(user.tomap());
    } catch (e) {
      throw "Failed To Save User Data";
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();
      if (!doc.exists) {
        throw "User Data Not Found";
      }

      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw "Failed To Save User Data";
    }
  }
}
