import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageAPI {
  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<StorageUploadTask> uploadProfilePic(String path, File image) async {
    return _storageReference.child('profile_pictures/$path').putFile(image);
  }

  Future<StorageUploadTask> uploadApplicationPhoto(
      String path, File image) async {
    return _storageReference.child('application_pictures/$path').putFile(image);
  }

  Future<StorageUploadTask> uploadTranscriptFile(
      String userId, File file) async {
    String filename = path.basename(file.path);
    return _storageReference
        .child('school_transcripts/$userId/$filename')
        .putFile(file);
  }

  Future<StorageUploadTask> uploadLanguageFile(String userId, File file) async {
    String filename = path.basename(file.path);
    return _storageReference
        .child('language_qualifications/$userId/$filename')
        .putFile(file);
  }

  Future<void> deleteLanguageFile(String userId, String path) async {
    return _storageReference
        .child('language_qualifications/$userId/$path')
        .delete();
  }

  Future<void> deleteTranscriptFile(String userId, String path) async {
    return _storageReference.child('school_transcripts/$userId/$path').delete();
  }

  Future<void> deleteApplicationPhoto(String path) async {
    return _storageReference.child('application_pictures/$path').delete();
  }

  Future<String> getImageUrl(String imageId) async {
    ImagePicker picker = ImagePicker();
    PickedFile imagePicked =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);
    File imageFile = File(imagePicked.path);
    StorageUploadTask uploadTask = await uploadProfilePic(imageId, imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<String> getApplicationPhotoUrl(String imageId, File imageFile) async {
    StorageUploadTask uploadTask =
        await uploadApplicationPhoto(imageId, imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<String> getUploadTranscriptsUrl(String userId, File files) async {
    StorageUploadTask uploadTask = await uploadTranscriptFile(userId, files);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<String> getUploadLanguageUrl(String userId, File files) async {
    StorageUploadTask uploadTask = await uploadLanguageFile(userId, files);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<List<String>> getOnlyTranscriptsUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('school_transcripts/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }

  Future<List<String>> getOnlyLanguageUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('language_qualifications/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }
}
