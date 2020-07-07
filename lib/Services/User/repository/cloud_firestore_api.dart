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

  Stream <DocumentSnapshot> getPersonalDetails(String userID) {
     return applications.document(userID).collection('Personal Details')
        .document(userID).snapshots();
  }

  Stream <DocumentSnapshot> getContactDetails(String userID) {
    return applications.document(userID).collection('Contact Details')
        .document(userID).snapshots();
  }


  Future<List<User>> getListUsers (String userUid) async {
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
    return userInfo.document(userUid).snapshots();
  }

  void setUserData(User user) async {
    return await userInfo.document(user.uid).setData({
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

  Future<void> registerPersonalDetails ( String userID, String title, String givenName, String middleName,
      String familyName, String gender, String dateBirth, String placeBirth, String nationality,
      String passport, String dateExpire, String placeIssue, String religion)
  async {
    return await applications.document(userID).collection('Personal Details')
    .document(userID).setData({
      'title': title,
      'given name': givenName ,
      'middle name': middleName,
      'family name': familyName,
      'gender': gender,
      'date of birth': dateBirth,
      'place of birth': placeBirth,
      'passport': passport,
      'date of expire': dateExpire,
      'place of issue': placeIssue,
      'religion': religion,
      'nationality' : nationality
    }, merge: true);

  }


  Future<void> registerContactDetails ( String userID, String email, String otherEmail, String phone,
      String mobile,
      String residentialAddress, String residentialCity, String residentialState, String residentialCountry, String residentialPostcode,
      String postalAddress, String postalCity, String postalState, String postalCountry, String postalPostcode,
      String emergencyContact, String emergencyRel, String mobileInt)
  async {
    return await applications.document(userID).collection('Contact Details')
        .document(userID).setData({
      'email': email,
      'other email': otherEmail ,
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
  
  Future<void> addMessage( Message message, User sender , User receiver)
async {
    Map map = message.toMap();

    await messages.document(message.senderId)
    .collection(message.receiverId)
    .add(map);

    return await messages.document(message.receiverId)
        .collection(message.senderId)
        .add(map);

} }
