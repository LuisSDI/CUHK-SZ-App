import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/messages.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';

class CloudFireStoreAPI {
  final CollectionReference userInfo =
      Firestore.instance.collection('userInfo');

  final CollectionReference messages =
      Firestore.instance.collection('messages');

  final CollectionReference applications =
      Firestore.instance.collection('applications');

  String errorMessage;

  String getErrorCloud() {
    return errorMessage;
  }

  void resetErrorCloud() {
    errorMessage = null;
  }

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

  Stream<DocumentSnapshot> getPersonalDetails(String userID) {
    return applications
        .document(userID)
        .collection('Personal Details')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getContactDetails(String userID) {
    return applications
        .document(userID)
        .collection('Contact Details')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getPersonalQuestion(String userID) {
    return applications
        .document(userID)
        .collection('Personal Questionnaires')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getAdditionalDetails(String userID) {
    return applications
        .document(userID)
        .collection('Additional Details')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getApplicationPhoto(String userID) {
    return applications
        .document(userID)
        .collection('Application Photo')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getSelectedMajor(String userID) {
    return applications
        .document(userID)
        .collection('Selected Major')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getTranscriptsUrlsNames(String userID) {
    return applications
        .document(userID)
        .collection('School Transcripts')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getEducationHistory(String userID) {
    return applications
        .document(userID)
        .collection('Education History')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getLanguageQualifications(String userID) {
    return applications
        .document(userID)
        .collection('Language Qualifications')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getReferences(String userID) {
    return applications
        .document(userID)
        .collection('References')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getWorkExpirience(String userID) {
    return applications
        .document(userID)
        .collection('Work Expirience')
        .document(userID)
        .snapshots();
  }

  Stream<DocumentSnapshot> getSupportingMaterials(String userID) {
    return applications
        .document(userID)
        .collection('Supporting Materials')
        .document(userID)
        .snapshots();
  }

  Future<List<User>> getListUsers(String userUid) async {
    List<User> users = List<User>();
    var querySnapshot = await userInfo.getDocuments();
    querySnapshot.documents.forEach((value) {
      User user = User(
        name: value.data['full name'],
        type: value.data['type'],
        phone: value.data['phone'],
        description: value.data['description'],
        country: value.data['country'],
        uid: value.data['uid'],
        photoUrL: value.data['photoURL'],
        email: value.data['email'],
      );
      users.add(user);
    });
    return users;
  }

  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return userInfo.doc(userUid).snapshots();
  }

  Future<void> setUserData(UserModel user) async {
    try {
      return await userInfo.doc(user.uid).set({
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
    } catch (error) {
      print(error.code);
      switch (error.code) {
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "You are unable to connect";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
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
      String religion) async {
    return await applications
        .document(userID)
        .collection('Personal Details')
        .document(userID)
        .setData({
      'title': title,
      'given name': givenName,
      'middle name': middleName,
      'family name': familyName,
      'gender': gender,
      'date of birth': dateBirth,
      'place of birth': placeBirth,
      'passport': passport,
      'date of expire': dateExpire,
      'place of issue': placeIssue,
      'religion': religion,
      'nationality': nationality
    }, merge: true);
  }

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
      String mobileInt) async {
    return await applications
        .document(userID)
        .collection('Contact Details')
        .document(userID)
        .setData({
      'email': email,
      'other email': otherEmail,
      'phone': phone,
      'mobile': mobile,
      'residential address': residentialAddress,
      'residential city': residentialCity,
      'residential state': residentialState,
      'residential country': residentialCountry,
      'residential postcode': residentialPostcode,
      'postal address': postalAddress,
      'postal city': postalCity,
      'postal state': postalState,
      'postal country': postalCountry,
      'postal postcode': postalPostcode,
      'emergency contact name': emergencyContact,
      'emergency relationship': emergencyRel,
      'mobile for interview': mobileInt,
    }, merge: true);
  }

  Future<void> registerPersonalQuestionnaires(String userID, String questionOne,
      String questionTwo, String questionThree) async {
    return await applications
        .document(userID)
        .collection('Personal Questionnaires')
        .document(userID)
        .setData({
      'attributes question': questionOne,
      'why china question': questionTwo,
      'ambitions question': questionThree,
    }, merge: true);
  }

  Future<void> registerAdditionalDetails(
      String userID,
      String dropdownTuition,
      String dropdownNeeds,
      String needsDetails,
      String dropdownCriminal,
      String criminalDetails,
      String dropdownAgent,
      String nameAgent,
      String emailAgent) async {
    return await applications
        .document(userID)
        .collection('Additional Details')
        .document(userID)
        .setData({
      'source of tuition': dropdownTuition,
      'special needs': dropdownNeeds,
      'needs details': needsDetails,
      'criminal convictions': dropdownCriminal,
      'criminal details': criminalDetails,
      'uses agent': dropdownAgent,
      'name of agent': nameAgent,
      'email of agent': emailAgent,
    }, merge: true);
  }

  Future<void> registerApplicationPhoto(String userID, String photoUrl) async {
    return await applications
        .document(userID)
        .collection('Application Photo')
        .document(userID)
        .setData({'photoUrl': photoUrl}, merge: true);
  }

  Future<void> registerSelectedMajor(
      String userID, String majorSelected) async {
    return await applications
        .document(userID)
        .collection('Selected Major')
        .document(userID)
        .setData({'selected major': majorSelected}, merge: true);
  }

  Future<void> registerSchoolTranscripts(String userID,
      List<String> transcriptUrls, List<String> transcriptsNames) async {
    print(transcriptsNames);
    return await applications
        .document(userID)
        .collection('School Transcripts')
        .document(userID)
        .setData({
      'school transcripts urls': transcriptUrls,
      'school transcripts name': transcriptsNames
    }, merge: true);
  }

  Future<void> registerEducationHistory(
    String userID,
    String awardingInstitution,
    String countryInstitution,
    String attendenceTo,
    String attendenceFrom,
    String gradesRecord,
    String nationalExam,
    String dropdownStudy,
  ) async {
    return await applications
        .document(userID)
        .collection('Education History')
        .document(userID)
        .setData({
      'national exam': nationalExam,
      'awarding institution': awardingInstitution,
      'country of qualification': countryInstitution,
      'study mode': dropdownStudy,
      'date of attendence (From)': attendenceFrom,
      'date of attendence (To)': attendenceTo,
      'grades record': gradesRecord
    }, merge: true);
  }

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
  ) async {
    return await applications
        .document(userID)
        .collection('Language Qualifications')
        .document(userID)
        .setData({
      'english first language': dropdownEnglish,
      'has english qualification': dropdownQualificationState,
      'english qualification': selectEnglishTest,
      'date taken': dateTaken,
      'total score': totalScore,
      'tentative english qualification': tentativeEnglishTest,
      'has chinese experience': dropdownChinese,
      'length chinese study': lengthChineseStudy,
      'place chinese study': placeStudy,
      'chinese proficiency': dropdownProficiency,
      'other languages': otherLanguages,
    }, merge: true);
  }

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
  ) async {
    return await applications
        .document(userID)
        .collection('References')
        .document(userID)
        .setData({
      'first referee': {
        'title': dropdownTitleFirst,
        'given name': givenNameFirst,
        'family name': familyNameFirst,
        'organization name': organizationFirst,
        'job title': jobFirst,
        'email': emailFirst,
        'phone number': phoneFirst,
        'street address': residentialFirst,
        'city': cityFirst,
        'state': stateFirst,
        'postcode': postcodeFirst,
        'country': countryFirst
      },
      'second referee': {
        'title': dropdownTitleSecond,
        'given name': givenNameSecond,
        'family name': familyNameSecond,
        'organization name': organizationSecond,
        'job title': jobSecond,
        'email': emailSecond,
        'phone number': phoneSecond,
        'street address': residentialSecond,
        'city': citySecond,
        'state': stateSecond,
        'postcode': postcodeSecond,
        'country': countrySecond
      },
    }, merge: true);
  }

  Future<void> registerLanguageUrl(String userID, List<String> languageUrls,
      List<String> languageNames) async {
    return await applications
        .document(userID)
        .collection('Language Qualifications')
        .document(userID)
        .setData({
      'language qualifications urls': languageUrls,
      'language qualifications name': languageNames
    }, merge: true);
  }

  Future<void> registerReferenceUrl(String userID, List<String> referenceUrls,
      List<String> referenceNames) async {
    return await applications
        .document(userID)
        .collection('References')
        .document(userID)
        .setData({
      'reference letter urls': referenceUrls,
      'reference letter name': referenceNames
    }, merge: true);
  }

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
  ) async {
    return await applications
        .document(userID)
        .collection('Work Expirience')
        .document(userID)
        .setData({
      'employers name': employersName,
      'position held': positionHeld,
      'is this your employee? ': dropdownIsEmployer,
      'email': email,
      'start date': startDate,
      'to date': toDate,
      'street address': residential,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': countryFirst
    }, merge: true);
  }

  //Supporting Material Methods

  Future<void> registerPassportUrl(String userID, List<String> referenceUrls,
      List<String> referenceNames) async {
    return await applications
        .document(userID)
        .collection('Supporting Materials')
        .document(userID)
        .setData({
      'passport': {
        'passport urls': referenceUrls,
        'passport name': referenceNames
      },
    }, merge: true);
  }

  Future<void> registerStatementUrl(String userID, List<String> referenceUrls,
      List<String> referenceNames) async {
    return await applications
        .document(userID)
        .collection('Supporting Materials')
        .document(userID)
        .setData({
      'personal statements': {
        'personal statements urls': referenceUrls,
        'personal statements name': referenceNames
      },
    }, merge: true);
  }

  Future<void> registerOtherUrl(String userID, List<String> referenceUrls,
      List<String> referenceNames) async {
    return await applications
        .document(userID)
        .collection('Supporting Materials')
        .document(userID)
        .setData({
      'other material': {
        'other material urls': referenceUrls,
        'other material name': referenceNames
      },
    }, merge: true);
  }

  //Ends Here

  Future<void> registerApplication(String userID) async {
    return await userInfo
        .document(userID)
        .setData({'status of application': 'Finish'}, merge: true);
  }

  Stream<DocumentSnapshot> getUserInfo(String userID) {
    return userInfo.document(userID).snapshots();
  }

  Future<void> addMessage(Message message, User sender, User receiver) async {
    Map map = message.toMap();

    await messages
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await messages
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}
