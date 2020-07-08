import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuhkszapp/Services/User/model/messages.dart';
import 'package:cuhkszapp/Services/User/model/user.dart';
import 'package:cuhkszapp/Services/User/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFireStoreAPI();

  void setUserDataFirestore(User user) => _cloudFirestoreAPI.setUserData(user);

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<User> getUserData(String userUid) async {
    return _cloudFirestoreAPI.getUserData(userUid);
  }

  Stream<DocumentSnapshot> listenUserData(String userUid) {
    return _cloudFirestoreAPI.listenUserData(userUid);
  }

  Future<void> addMessage( Message message, User sender , User receiver) =>
  _cloudFirestoreAPI.addMessage(message, sender, receiver);

  Future<void> registerPersonalDetails ( String userID, String title, String givenName, String middleName,
      String familyName, String gender, String dateBirth, String placeBirth, String nationality,
      String passport, String dateExpire, String placeIssue, String religion) =>
  _cloudFirestoreAPI.registerPersonalDetails(userID, title, givenName, middleName, familyName, gender,
      dateBirth, placeBirth, nationality, passport, dateExpire, placeIssue, religion);

  Future<void> registerContactDetails ( String userID, String email, String otherEmail, String phone,
      String mobile, String residentialAddress, String residentialCity, String residentialState,
      String residentialCountry, String residentialPostcode, String postalAddress, String postalCity,
      String postalState, String postalCountry, String postalPostcode,
      String emergencyContact, String emergencyRel, String mobileInt)
  => _cloudFirestoreAPI.registerContactDetails(userID, email, otherEmail, phone, mobile,
      residentialAddress, residentialCity, residentialState, residentialCountry, residentialPostcode,
      postalAddress, postalCity, postalState, postalCountry, postalPostcode, emergencyContact, emergencyRel, mobileInt) ;

  Future<void> registerPersonalQuestionnaires (String userID, String questionOne, String questionTwo,
      String questionThree)
  => _cloudFirestoreAPI.registerPersonalQuestionnaires(userID, questionOne, questionTwo, questionThree);

  Future<void> registerAdditionalDetails (String userID, String dropdownTuition, String dropdownNeeds,
      String needsDetails,String dropdownCriminal, String criminalDetails, String dropdownAgent,
      String nameAgent, String emailAgent)
  => _cloudFirestoreAPI.registerAdditionalDetails(userID, dropdownTuition, dropdownNeeds,
      needsDetails, dropdownCriminal, criminalDetails, dropdownAgent, nameAgent, emailAgent);

  Stream <DocumentSnapshot> getContactDetails(String userID)
  => _cloudFirestoreAPI.getContactDetails(userID);

  Stream <DocumentSnapshot> getPersonalDetails(String userID) =>
  _cloudFirestoreAPI.getPersonalDetails(userID);

  Stream <DocumentSnapshot> getPersonalQuestion(String userID) =>
  _cloudFirestoreAPI.getPersonalQuestion(userID);

  Stream <DocumentSnapshot> getAdditionalDetails(String userID) =>
  _cloudFirestoreAPI.getAdditionalDetails(userID);


    Future<List<User>> getListUsers(String userUid) =>
      _cloudFirestoreAPI.getListUsers(userUid);
}