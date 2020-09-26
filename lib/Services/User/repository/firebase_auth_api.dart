import 'package:cuhkszapp/resources/async_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  String errorMessage;

  String getError() {
    return errorMessage;
  }

  void resetError() {
    errorMessage = null;
  }

  void deleteUser() async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      firebaseUser.delete();
    } catch (error) {
      switch (error.code) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "You are unable to connect.Verify your connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "You are unable to connect";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return user;
    } catch (error) {
      print(error.code);
      switch (error.code) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "You are unable to connect";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
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
    } catch (error) {
      print('Mmm...');
      print(error.runtimeType);
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
    } catch (error) {
      print(error.runtimeType);
      if (error.runtimeType == NoSuchMethodError) {
        print(error);
      } else {
        print(error.code);
        switch (error.code) {
          case "network_error":
            errorMessage = "You are unable to connect.Verify your connection";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
      }
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
        credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        facebookLogin.logOut();
      }
      return credential;
    } catch (error) {
      print(error.runtimeType);
      if (error.runtimeType == NoSuchMethodError) {
        print(error);
      } else {
        print(error.code);
        switch (error.code) {
          case "network_error":
            errorMessage = "You are unable to connect.Verify your connection";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
      }
    }
  }

  Future sendRecoveryPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  void signOut() async {
    await _auth.signOut().then((value) => print("Sesion Cerrada"));
  }
}
