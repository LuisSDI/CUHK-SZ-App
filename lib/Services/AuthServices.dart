import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  /// return the Future with firebase user object FirebaseUser if one exists
  ///
  // Future<User> getUser() {
  //   // _auth.currentUser();
  //   return FirebaseAuth.instance.currentUser().
  //     //_auth.currentUser();
  // }

  // wrapping the firebase calls
  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    print("Sucess");
    return result;
  }
}
