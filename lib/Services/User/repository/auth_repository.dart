import 'package:cuhkszapp/Services/User/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  String getError() => _firebaseAuthAPI.getError();

  void resetError() => _firebaseAuthAPI.resetError();

  void deleteUser() => _firebaseAuthAPI.deleteUser();

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

  Future sendRecoveryPassword(String email) =>
      _firebaseAuthAPI.sendRecoveryPassword(email);

  signOut() => _firebaseAuthAPI.signOut();
}
