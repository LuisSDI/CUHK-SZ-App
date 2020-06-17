import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/Services/User/repository/auth_repository.dart';
import 'package:cuhkszapp/Services/User/repository/cloud_firestore_repository.dart';
import 'package:cuhkszapp/Services/User/repository/firebase_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  //Firebase Auth
  //1.SignIn
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

  Future sendRecoveryPassword(String email) => _auth_repository.sendRecoveryPassword(email);

  // Firebase Cloud Firestore
  
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

  //Firebase Storage

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<StorageUploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);
  Future<String> getImageUrl(String imageId) => _firebaseStorageRepository.getImageUrl(imageId);


  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
