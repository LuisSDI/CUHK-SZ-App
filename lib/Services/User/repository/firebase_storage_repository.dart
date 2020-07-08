import 'dart:io';

import 'package:cuhkszapp/Services/User/repository/firebase_storage_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository{

  final _firebaseStorageAPI = FirebaseStorageAPI();
  Future<StorageUploadTask> uploadFile(String path, File image) => _firebaseStorageAPI.uploadFile(path, image);
  Future<String> getImageUrl(String imageId) => _firebaseStorageAPI.getImageUrl(imageId);
  Future<String> getApplicationPhotoUrl(String imageId) => _firebaseStorageAPI.getApplicationPhotoUrl(imageId);
  Future<void> deleteApplicationPhoto(String path) => _firebaseStorageAPI.deleteApplicationPhoto(path);

}