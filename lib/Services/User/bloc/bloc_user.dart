import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/Services/User/repository/auth_repository.dart';
import 'package:cuhkszapp/Services/User/repository/cloud_firestore_api.dart';
import 'package:cuhkszapp/Services/User/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos -Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  //Casos uso
  //1.SignIn a la aplicacion
  Future<FirebaseUser> signIn(String email, String password) =>
      _auth_repository.signInFirebase(email, password);
  //2.SignIn Credential
  Future<AuthResult> signInCredential(AuthCredential credential) =>
      _auth_repository.signInCredential(credential);
  //Google
  Future<AuthCredential> credentialGoogle() =>
      _auth_repository.credentialGoogle();
  //Facebook
  Future<AuthCredential> credentialFacebook() =>
      _auth_repository.credentialFacebook();
  //3.Sign Up
  Future<FirebaseUser> signUp(String email, String password) =>
      _auth_repository.signUpFirebase(email, password);

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void setUserData(User user) =>
      _cloudFirestoreRepository.setUserDataFirestore(user);

  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<User> getUserData(String userUid) async =>
      _cloudFirestoreRepository.getUserData(userUid);
  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return _cloudFirestoreRepository.listenUserData(userUid);
  }

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
