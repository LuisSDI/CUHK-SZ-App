import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/messages.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/Services/User/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFireStoreAPI();

  String getErrorCloud() => _cloudFirestoreAPI.getErrorCloud();

  void resetErrorCloud() => _cloudFirestoreAPI.resetErrorCloud();

  Future<void> setUserDataFirestore(UserModel user) =>
      _cloudFirestoreAPI.setUserData(user);

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<User> getUserData(String userUid) async {
    return _cloudFirestoreAPI.getUserData(userUid);
  }

  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return _cloudFirestoreAPI.listenUserData(userUid);
  }

  Future<void> addMessage(Message message, User sender, User receiver) =>
      _cloudFirestoreAPI.addMessage(message, sender, receiver);

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
      _cloudFirestoreAPI.registerPersonalDetails(
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
      _cloudFirestoreAPI.registerContactDetails(
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

  Future<void> registerPersonalQuestionnaires(String userID, String questionOne,
          String questionTwo, String questionThree) =>
      _cloudFirestoreAPI.registerPersonalQuestionnaires(
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
      _cloudFirestoreAPI.registerAdditionalDetails(
          userID,
          dropdownTuition,
          dropdownNeeds,
          needsDetails,
          dropdownCriminal,
          criminalDetails,
          dropdownAgent,
          nameAgent,
          emailAgent);

  Future<void> registerApplicationPhoto(String userID, String photoUrl) =>
      _cloudFirestoreAPI.registerApplicationPhoto(userID, photoUrl);

  Future<void> registerSelectedMajor(String userID, String majorSelected) =>
      _cloudFirestoreAPI.registerSelectedMajor(userID, majorSelected);

  Future<void> registerSchoolTranscripts(String userID,
          List<String> transcriptUrls, List<String> transcriptsNames) =>
      _cloudFirestoreAPI.registerSchoolTranscripts(
          userID, transcriptUrls, transcriptsNames);

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
      _cloudFirestoreAPI.registerEducationHistory(
          userID,
          awardingInstitution,
          countryInstitution,
          attendenceTo,
          attendenceFrom,
          gradesRecord,
          nationalExam,
          dropdownStudy);

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
      _cloudFirestoreAPI.registerLanguageQualifications(
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
      _cloudFirestoreAPI.registerLanguageUrl(
          userID, languageUrls, languageNames);

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
      _cloudFirestoreAPI.registerReferences(
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
      _cloudFirestoreAPI.registerReferenceUrl(
          userID, referenceUrls, referenceNames);

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
      _cloudFirestoreAPI.registerWorkExperience(
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

  Stream<DocumentSnapshot> getContactDetails(String userID) =>
      _cloudFirestoreAPI.getContactDetails(userID);

  Stream<DocumentSnapshot> getPersonalDetails(String userID) =>
      _cloudFirestoreAPI.getPersonalDetails(userID);

  Stream<DocumentSnapshot> getPersonalQuestion(String userID) =>
      _cloudFirestoreAPI.getPersonalQuestion(userID);

  Stream<DocumentSnapshot> getAdditionalDetails(String userID) =>
      _cloudFirestoreAPI.getAdditionalDetails(userID);

  Stream<DocumentSnapshot> getApplicationPhoto(String userID) =>
      _cloudFirestoreAPI.getApplicationPhoto(userID);

  Stream<DocumentSnapshot> getSelectedMajor(String userID) =>
      _cloudFirestoreAPI.getSelectedMajor(userID);

  Stream<DocumentSnapshot> getTranscriptsUrlsNames(String userID) =>
      _cloudFirestoreAPI.getTranscriptsUrlsNames(userID);

  Stream<DocumentSnapshot> getEducationHistory(String userID) =>
      _cloudFirestoreAPI.getEducationHistory(userID);

  Stream<DocumentSnapshot> getLanguageQualifications(String userID) =>
      _cloudFirestoreAPI.getLanguageQualifications(userID);

  Stream<DocumentSnapshot> getReferences(String userID) =>
      _cloudFirestoreAPI.getReferences(userID);

  Stream<DocumentSnapshot> getWorkExpirience(String userID) =>
      _cloudFirestoreAPI.getWorkExpirience(userID);

  Future<List<User>> getListUsers(String userUid) =>
      _cloudFirestoreAPI.getListUsers(userUid);

  //Supporting Material Methods

  Future<void> registerPassportUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreAPI.registerPassportUrl(
          userID, referenceUrls, referenceNames);

  Future<void> registerStatementUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreAPI.registerStatementUrl(
          userID, referenceUrls, referenceNames);

  Future<void> registerOtherUrl(String userID, List<String> referenceUrls,
          List<String> referenceNames) =>
      _cloudFirestoreAPI.registerOtherUrl(
          userID, referenceUrls, referenceNames);

  Stream<DocumentSnapshot> getSupportingMaterials(String userID) =>
      _cloudFirestoreAPI.getSupportingMaterials(userID);

  //Ends Here

  Future<void> registerApplication(String userID) =>
      _cloudFirestoreAPI.registerApplication(userID);

  Stream<DocumentSnapshot> getUserInfo(String userID) =>
      _cloudFirestoreAPI.getUserInfo(userID);
}
