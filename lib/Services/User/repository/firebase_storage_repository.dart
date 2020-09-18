import 'dart:io';

import 'package:cuhkszapp/Services/User/repository/firebase_storage_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  final _firebaseStorageAPI = FirebaseStorageAPI();
  Future<StorageUploadTask> uploadProfilePic(String path, File image) =>
      _firebaseStorageAPI.uploadProfilePic(path, image);
  Future<String> getImageUrl(String imageId) =>
      _firebaseStorageAPI.getImageUrl(imageId);
  Future<String> getApplicationPhotoUrl(String imageId, File imageFile) =>
      _firebaseStorageAPI.getApplicationPhotoUrl(imageId, imageFile);
  Future<String> getUploadTranscriptsUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadTranscriptsUrl(userId, files);
  Future<List<String>> getOnlyTranscriptsUrl(
          String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyTranscriptsUrl(userId, path);
  Future<String> getUploadLanguageUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadLanguageUrl(userId, files);
  Future<List<String>> getOnlyLanguageUrl(String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyLanguageUrl(userId, path);

  Future<String> getUploadReferenceUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadReferenceUrl(userId, files);
  Future<List<String>> getOnlyReferenceUrl(String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyReferenceUrl(userId, path);

  Future<void> deleteApplicationPhoto(String path) =>
      _firebaseStorageAPI.deleteApplicationPhoto(path);
  Future<void> deleteTranscriptFile(String userId, String path) =>
      _firebaseStorageAPI.deleteTranscriptFile(userId, path);
  Future<void> deleteLanguageFile(String userId, String path) =>
      _firebaseStorageAPI.deleteLanguageFile(userId, path);

  Future<void> deleteReferenceFile(String userId, String path) =>
      _firebaseStorageAPI.deleteReferenceFile(userId, path);

  //Supporting Material Methods

  Future<List<String>> getOnlyPassportUrl(String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyPassportUrl(userId, path);

  Future<List<String>> getOnlyStatementUrl(String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyStatementUrl(userId, path);

  Future<List<String>> getOnlyOthersUrl(String userId, List<String> path) =>
      _firebaseStorageAPI.getOnlyOthersUrl(userId, path);

  Future<void> deletePassportFile(String userId, String path) =>
      _firebaseStorageAPI.deletePassportFile(userId, path);

  Future<void> deleteStatementFile(String userId, String path) =>
      _firebaseStorageAPI.deleteStatementFile(userId, path);

  Future<void> deleteOtherFile(String userId, String path) =>
      _firebaseStorageAPI.deleteOtherFile(userId, path);

  Future<String> getUploadPassportUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadPassportUrl(userId, files);

  Future<String> getUploadStatementsUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadStatementsUrl(userId, files);

  Future<String> getUploadOthersUrl(String userId, File files) =>
      _firebaseStorageAPI.getUploadOthersUrl(userId, files);
  //Ends Here

}
