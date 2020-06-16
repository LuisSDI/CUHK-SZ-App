import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CloudFireStoreAPI {
  final Firestore _db = Firestore.instance;
  final CollectionReference userInfo =
      Firestore.instance.collection('userInfo');

  Future<User> getUserData(String userUid) async {
    User user;
    Future<DocumentSnapshot> document = userInfo.document(userUid).get();
    await document.then<dynamic>((DocumentSnapshot value) async {
      user = User(
        name: value.data['full name'],
        type: value.data['type'],
        phone: value.data['phone'],
        description: value.data['description'],
        country: value.data['country'],
        uid: value.data['uid'],
        photoUrL: value.data['photoURL'],
        email: value.data['email'],
      );
    });
    return user;
  }

  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return userInfo.document(userUid).snapshots();
  }

  void setUserData(User user) async {
    return await userInfo.document(user.uid).setData({
      'uid': user.uid,
      'full name': user.name,
      'email': user.email,
      'photoURL': user.photoUrL,
      'phone': user.phone,
      'country': user.country,
      'type': user.type,
      'description': user.description,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  void updateUserData(User user) async {
    return await userInfo.document(user.uid).updateData({
      'uid': user.uid,
      'full name': user.name,
      'email': user.email,
      'photoURL': user.photoUrL,
      'phone': user.phone,
      'country': user.country,
      'type': user.type,
      'description': user.description,
      'lastSignIn': DateTime.now()
    });
  }
}
