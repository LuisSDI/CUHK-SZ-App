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


  Future<List<User>> getListUsers(String userUid) =>
      _cloudFirestoreAPI.getListUsers(userUid);
}