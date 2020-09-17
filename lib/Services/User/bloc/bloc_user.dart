import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/messages.dart';
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

  Future sendRecoveryPassword(String email) =>
      _auth_repository.sendRecoveryPassword(email);

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

  Future<List<User>> getListUsers(String userUid) =>
      _cloudFirestoreRepository.getListUsers(userUid);

  Future<void> addMessage(Message message, User sender, User receiver) =>
      _cloudFirestoreRepository.addMessage(message, sender, receiver);

  Future<void> registerPersonalDetails(
          String userID,
          String title,
          String givenName,
          String middleName,
          String familyName,
          String gender,
          String dateBirth,
          String placeBirth,
          String nationality,
          String passport,
          String dateExpire,
          String placeIssue,
          String religion) =>
      _cloudFirestoreRepository.registerPersonalDetails(
          userID,
          title,
          givenName,
          middleName,
          familyName,
          gender,
          dateBirth,
          placeBirth,
          nationality,
          passport,
          dateExpire,
          placeIssue,
          religion);

  Stream<DocumentSnapshot> getPersonalDetails(String userID) =>
      _cloudFirestoreRepository.getPersonalDetails(userID);

  Future<void> registerContactDetails(
          String userID,
          String email,
          String otherEmail,
          String phone,
          String mobile,
          String residentialAddress,
          String residentialCity,
          String residentialState,
          String residentialCountry,
          String residentialPostcode,
          String postalAddress,
          String postalCity,
          String postalState,
          String postalCountry,
          String postalPostcode,
          String emergencyContact,
          String emergencyRel,
          String mobileInt) =>
      _cloudFirestoreRepository.registerContactDetails(
          userID,
          email,
          otherEmail,
          phone,
          mobile,
          residentialAddress,
          residentialCity,
          residentialState,
          residentialCountry,
          residentialPostcode,
          postalAddress,
          postalCity,
          postalState,
          postalCountry,
          postalPostcode,
          emergencyContact,
          emergencyRel,
          mobileInt);

  Stream<DocumentSnapshot> getContactDetails(String userID) =>
      _cloudFirestoreRepository.getContactDetails(userID);

  Stream<DocumentSnapshot> getPersonalQuestion(String userID) =>
      _cloudFirestoreRepository.getPersonalQuestion(userID);

  Future<void> registerPersonalQuestionnaires(String userID, String questionOne,
          String questionTwo, String questionThree) =>
      _cloudFirestoreRepository.registerPersonalQuestionnaires(
          userID, questionOne, questionTwo, questionThree);

  Future<void> registerAdditionalDetails(
          String userID,
          String dropdownTuition,
          String dropdownNeeds,
          String needsDetails,
          String dropdownCriminal,
          String criminalDetails,
          String dropdownAgent,
          String nameAgent,
          String emailAgent) =>
      _cloudFirestoreRepository.registerAdditionalDetails(
          userID,
          dropdownTuition,
          dropdownNeeds,
          needsDetails,
          dropdownCriminal,
          criminalDetails,
          dropdownAgent,
          nameAgent,
          emailAgent);

  Stream<DocumentSnapshot> getAdditionalDetails(String userID) =>
      _cloudFirestoreRepository.getAdditionalDetails(userID);

  Future<void> registerApplicationPhoto(String userID, String photoUrl) =>
      _cloudFirestoreRepository.registerApplicationPhoto(userID, photoUrl);

  Stream<DocumentSnapshot> getApplicationPhoto(String userID) =>
      _cloudFirestoreRepository.getApplicationPhoto(userID);

  Future<void> registerSelectedMajor(String userID, String majorSelected) =>
      _cloudFirestoreRepository.registerSelectedMajor(userID, majorSelected);

  Stream<DocumentSnapshot> getSelectedMajor(String userID) =>
      _cloudFirestoreRepository.getSelectedMajor(userID);

  Future<void> registerSchoolTranscripts(String userID,
          List<String> transcriptUrls, List<String> transcriptsNames) =>
      _cloudFirestoreRepository.registerSchoolTranscripts(
          userID, transcriptUrls, transcriptsNames);

  Stream<DocumentSnapshot> getTranscriptsUrlsNames(String userID) =>
      _cloudFirestoreRepository.getTranscriptsUrlsNames(userID);

  Future<void> registerEducationHistory(
    String userID,
    String awardingInstitution,
    String countryInstitution,
    String attendenceTo,
    String attendenceFrom,
    String gradesRecord,
    String nationalExam,
    String dropdownStudy,
  ) =>
      _cloudFirestoreRepository.registerEducationHistory(
          userID,
          awardingInstitution,
          countryInstitution,
          attendenceTo,
          attendenceFrom,
          gradesRecord,
          nationalExam,
          dropdownStudy);

  Stream<DocumentSnapshot> getEducationHistory(String userID) =>
      _cloudFirestoreRepository.getEducationHistory(userID);

  Future<void> registerLanguageQualifications(
    String userID,
    String dropdownEnglish,
    String dropdownQualificationState,
    String selectEnglishTest,
    String dateTaken,
    String totalScore,
    String tentativeEnglishTest,
    String dropdownChinese,
    String lengthChineseStudy,
    String placeStudy,
    String dropdownProficiency,
    String otherLanguages,
  ) =>
      _cloudFirestoreRepository.registerLanguageQualifications(
          userID,
          dropdownEnglish,
          dropdownQualificationState,
          selectEnglishTest,
          dateTaken,
          totalScore,
          tentativeEnglishTest,
          dropdownChinese,
          lengthChineseStudy,
          placeStudy,
          dropdownProficiency,
          otherLanguages);

  Future<void> registerLanguageUrl(String userID, List<String> languageUrls,
          List<String> languageNames) =>
      _cloudFirestoreRepository.registerLanguageUrl(
          userID, languageUrls, languageNames);

  Stream<DocumentSnapshot> getLanguageQualifications(String userID) =>
      _cloudFirestoreRepository.getLanguageQualifications(userID);

  Future<void> registerReferences(
    String userID,
    String dropdownTitleFirst,
    String givenNameFirst,
    String familyNameFirst,
    String organizationFirst,
    String jobFirst,
    String emailFirst,
    String phoneFirst,
    String residentialFirst,
    String cityFirst,
    String stateFirst,
    String postcodeFirst,
    String countryFirst,
    String dropdownTitleSecond,
    String givenNameSecond,
    String familyNameSecond,
    String organizationSecond,
    String jobSecond,
    String emailSecond,
    String phoneSecond,
    String residentialSecond,
    String citySecond,
    String stateSecond,
    String postcodeSecond,
    String countrySecond,
  ) =>
      _cloudFirestoreRepository.registerReferences(
          userID,
          dropdownTitleFirst,
          givenNameFirst,
          familyNameFirst,
          organizationFirst,
          jobFirst,
          emailFirst,
          phoneFirst,
          residentialFirst,
          cityFirst,
          stateFirst,
          postcodeFirst,
          countryFirst,
          dropdownTitleSecond,
          givenNameSecond,
          familyNameSecond,
          organizationSecond,
          jobSecond,
          emailSecond,
          phoneSecond,
          residentialSecond,
          citySecond,
          stateSecond,
          postcodeSecond,
          countrySecond);

  Future<void> registerReferenceUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreRepository.registerReferenceUrl(
          userID, referenceUrls, referenceNames);

  Stream<DocumentSnapshot> getReferences(String userID) =>
      _cloudFirestoreRepository.getReferences(userID);

  Future<void> registerWorkExperience(
    String userID,
    String employersName,
    String positionHeld,
    String dropdownIsEmployer,
    String email,
    String startDate,
    String toDate,
    String residential,
    String city,
    String state,
    String postcode,
    String countryFirst,
  ) =>
      _cloudFirestoreRepository.registerWorkExperience(
          userID,
          employersName,
          positionHeld,
          dropdownIsEmployer,
          email,
          startDate,
          toDate,
          residential,
          city,
          state,
          postcode,
          countryFirst);

  Stream<DocumentSnapshot> getWorkExpirience(String userID) =>
      _cloudFirestoreRepository.getWorkExpirience(userID);

  //Firebase Storage

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadProfilePic(path, image);

  Future<String> getImageUrl(String imageId) =>
      _firebaseStorageRepository.getImageUrl(imageId);

  Future<String> getApplicationPhotoUrl(String imageId, File imageFile) =>
      _firebaseStorageRepository.getApplicationPhotoUrl(imageId, imageFile);

  Future<String> getUploadTranscriptsUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadTranscriptsUrl(userId, files);

  Future<List<String>> getOnlyTranscriptsUrl(
          String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyTranscriptsUrl(userId, path);

  Future<String> getUploadLanguageUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadLanguageUrl(userId, files);

  Future<List<String>> getOnlyLanguageUrl(String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyLanguageUrl(userId, path);

  Future<String> getUploadReferenceUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadReferenceUrl(userId, files);

  Future<List<String>> getOnlyReferenceUrl(String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyReferenceUrl(userId, path);

  Future<void> deleteApplicationPhoto(String path) =>
      _firebaseStorageRepository.deleteApplicationPhoto(path);

  Future<void> deleteTranscriptFile(String userId, String path) =>
      _firebaseStorageRepository.deleteTranscriptFile(userId, path);

  Future<void> deleteLanguageFile(String userId, String path) =>
      _firebaseStorageRepository.deleteLanguageFile(userId, path);

  Future<void> deleterReferenceFile(String userId, String path) =>
      _firebaseStorageRepository.deleteReferenceFile(userId, path);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
