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
  final authRepository = AuthRepository();

  //Flujo de datos -Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  User get currentUser  => FirebaseAuth.instance.currentUser;
  //authStateChanges();

  //Firebase Auth

  // Error Methods
  String getError() => authRepository.getError();

  void resetError() => authRepository.resetError();
  //Delete User
  void deleteUser() => authRepository.deleteUser();
  //1.SignIn
  Future<dynamic> signIn(String email, String password) =>
      authRepository.signInFirebase(email, password);
  //2.SignIn Credential
  Future<dynamic> signInCredential(AuthCredential credential) =>
      authRepository.signInCredential(credential);
  //Google
  Future<AuthCredential> credentialGoogle() =>
      authRepository.credentialGoogle();
  //Facebook
  Future<AuthCredential> credentialFacebook() =>
      authRepository.credentialFacebook();
  //3.Sign Up
  Future<dynamic> signUp(String email, String password) =>
      authRepository.signUpFirebase(email, password);

  Future sendRecoveryPassword(String email) =>
      authRepository.sendRecoveryPassword(email);

  // Firebase Cloud Firestore

  //Error Methods

  String getErrorCloud() => _cloudFirestoreRepository.getErrorCloud();

  void resetErrorCloud() => _cloudFirestoreRepository.resetErrorCloud();

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  Future<void> setUserData(UserApp user) =>
      _cloudFirestoreRepository.setUserDataFirestore(user);

  void updateUserData(UserApp user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<UserApp> getUserData(String userUid) async =>
      _cloudFirestoreRepository.getUserData(userUid);
  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return _cloudFirestoreRepository.listenUserData(userUid);
  }

  Future<List<UserApp>> getListUsers(String userUid) =>
      _cloudFirestoreRepository.getListUsers(userUid);

  Future<void> addMessage(Message message, UserApp sender, UserApp receiver) =>
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

  //Supporting Material Methods

  Future<void> registerPassportUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreRepository.registerPassportUrl(
          userID, referenceUrls, referenceNames);

  Future<void> registerStatementUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreRepository.registerStatementUrl(
          userID, referenceUrls, referenceNames);

  Future<void> registerOtherUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreRepository.registerOtherUrl(
          userID, referenceUrls, referenceNames);

  Stream<DocumentSnapshot> getSupportingMaterials(String userID) =>
      _cloudFirestoreRepository.getSupportingMaterials(userID);

  //Ends Here

  Future<void> registerApplication(String userID) =>
      _cloudFirestoreRepository.registerApplication(userID);

  Stream<DocumentSnapshot> getUserInfo(String userID) =>
      _cloudFirestoreRepository.getUserInfo(userID);

  //Firebase Storage

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<dynamic> uploadFile(String path, File image) =>
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

  //Supporting Material Methods

  Future<List<String>> getOnlyPassportUrl(String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyPassportUrl(userId, path);

  Future<List<String>> getOnlyStatementUrl(String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyStatementUrl(userId, path);

  Future<List<String>> getOnlyOthersUrl(String userId, List<String> path) =>
      _firebaseStorageRepository.getOnlyOthersUrl(userId, path);

  Future<void> deletePassportFile(String userId, String path) =>
      _firebaseStorageRepository.deletePassportFile(userId, path);

  Future<void> deleteStatementFile(String userId, String path) =>
      _firebaseStorageRepository.deleteStatementFile(userId, path);

  Future<void> deleteOtherFile(String userId, String path) =>
      _firebaseStorageRepository.deleteOtherFile(userId, path);

  Future<String> getUploadPassportUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadPassportUrl(userId, files);

  Future<String> getUploadStatementsUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadStatementsUrl(userId, files);

  Future<String> getUploadOthersUrl(String userId, File files) =>
      _firebaseStorageRepository.getUploadOthersUrl(userId, files);
  //Ends Here

  signOut() {
    authRepository.signOut();
  }

  @override
  void dispose() {}
}
