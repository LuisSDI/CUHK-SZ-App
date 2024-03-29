import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('userInfo');


  Future updateUserData(String name, String phone, String country, String type,
      String description) async {
    return await userInfo.doc(uid).set({
      'full name': name,
      'phone': phone,
      'country': country,
      'type': type,
      'description': description
    });
  }

  // Get User data
  Future<DocumentSnapshot> getData(userID) async {
    DocumentSnapshot result =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    return result;
  }
}
