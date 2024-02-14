import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookc/features/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> getUser();
  Future<void> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      String? name,
      String? userName});
  Future<void> loginUserWithEmailandPassword(
      {required String email, required String password});
}

class AuthImplWithFirebase implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthImplWithFirebase({required this.firebaseAuth, required this.firestore});
  @override
  Future<UserModel> getUser() async {
    try {
      String userUid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userSnapshot =
          await firestore.collection("users").doc(userUid).get();

      if (userSnapshot.exists) {
        // If the document exists, convert the data to a UserModel
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          UserModel user = UserModel.fromMap(userData);
          return user;
        } else {
          // Handle the case where the data is null
          throw Exception("User data is null");
        }
      } else {
        // Handle the case where the document does not exist
        throw Exception("User document does not exist");
      }
    } catch (e) {
      // Handle any errors that might occur during the asynchronous operations

      throw Exception("Failed to fetch user data");
    }
  }

  @override
  Future<void> loginUserWithEmailandPassword(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      String? name,
      String? userName}) async {
    UserCredential signedUser = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel userModel = UserModel(
        id: signedUser.user!.uid,
        email: signedUser.user!.email,
        password: password,
        posts: const [],
        friends: const [],
        waitFriends: const [],
        userName: userName,
        name: name);
    firestore.collection('users').doc(userModel.id).set({
      'id': userModel.id,
      'name': userModel.name,
      'userName': userModel.userName,
      'password': userModel.password,
      'email': userModel.email,
      'posts': userModel.posts,
      'friends': userModel.friends,
      'waitFriends': userModel.waitFriends,
    });
  }
}
