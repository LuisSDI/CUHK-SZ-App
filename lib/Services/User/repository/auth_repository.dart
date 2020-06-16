import 'package:cuhkszapp/Services/User/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase(String email, String password) =>
      _firebaseAuthAPI.signIn(email, password);

  Future<FirebaseUser> signUpFirebase(String email, String password) =>
      _firebaseAuthAPI.signUp(email, password);

  Future<AuthResult> signInCredential(AuthCredential credential) =>
      _firebaseAuthAPI.signInUsingCredential(credential);

  Future<AuthCredential> credentialGoogle() =>
      _firebaseAuthAPI.credentialGoogle();
  Future<AuthCredential> credentialFacebook() =>
      _firebaseAuthAPI.credentialFacebook();

  signOut() => _firebaseAuthAPI.signOut();
}
