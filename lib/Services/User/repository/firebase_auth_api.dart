import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  Future<FirebaseUser> signIn(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user;
  }

  Future<AuthResult> signInUsingCredential(AuthCredential credential) async {
    AuthResult authResult;
    try {
      authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      return authResult;
    } catch (e) {
      print(e);
      return authResult;
    }
  }

  Future<AuthCredential> credentialGoogle() async {
    AuthCredential credential;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await googleSignIn.signOut();
      return credential;
    } catch (e) {
      print(e);
      return credential;
    }
  }

  Future<AuthCredential> credentialFacebook() async {
    AuthCredential credential;
    try {
      final FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        facebookLogin.logOut();
      }
      return credential;
    } catch (e) {
      print(e);
      return credential;
    }
  }

  void signOut() async {
    await _auth.signOut().then((value) => print("Sesion Cerrada"));
  }
}
