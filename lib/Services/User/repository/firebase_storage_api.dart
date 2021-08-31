import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageAPI {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  UploadTask uploadProfilePic(String path, File image)  {
    Reference ref =_storageReference.child('profile_pictures/$path');
    return  ref.putFile(image);
  }

  UploadTask uploadApplicationPhoto(
      String path, File image)  {
    return _storageReference.child('application_pictures/$path').putFile(image);
  }

  UploadTask uploadTranscriptFile(
      String userId, File file)  {
    String filename = path.basename(file.path);
    return _storageReference
        .child('school_transcripts/$userId/$filename')
        .putFile(file);
  }

  UploadTask uploadLanguageFile(String userId, File file)  {
    String filename = path.basename(file.path);
    return _storageReference
        .child('language_qualifications/$userId/$filename')
        .putFile(file);
  }

  UploadTask uploadReferenceFile(
      String userId, File file)  {
    String filename = path.basename(file.path);
    return _storageReference
        .child('references/$userId/$filename')
        .putFile(file);
  }

  // Supporting Materials Methods

  UploadTask uploadPassportFile(String userId, File file)  {
    String filename = path.basename(file.path);
    return _storageReference
        .child('supporting_materials/passports/$userId/$filename')
        .putFile(file);
  }

  UploadTask uploadStatementFile(
      String userId, File file) {
    String filename = path.basename(file.path);
    return _storageReference
        .child('supporting_materials/personal_statements/$userId/$filename')
        .putFile(file);
  }

  UploadTask uploadOtherFile(String userId, File file)  {
    String filename = path.basename(file.path);
    return _storageReference
        .child('supporting_materials/others/$userId/$filename')
        .putFile(file);
  }

  //Ends Here

  Future<void> deleteLanguageFile(String userId, String path) async {
    return _storageReference
        .child('language_qualifications/$userId/$path')
        .delete();
  }

  Future<void> deleteReferenceFile(String userId, String path) async {
    return _storageReference.child('references/$userId/$path').delete();
  }

  Future<void> deleteTranscriptFile(String userId, String path) async {
    return _storageReference.child('school_transcripts/$userId/$path').delete();
  }

  //Supporting Material Methods

  Future<void> deletePassportFile(String userId, String path) async {
    return _storageReference
        .child('supporting_materials/passports/$userId/$path')
        .delete();
  }

  Future<void> deleteStatementFile(String userId, String path) async {
    return _storageReference
        .child('supporting_materials/personal_statements/$userId/$path')
        .delete();
  }

  Future<void> deleteOtherFile(String userId, String path) async {
    return _storageReference
        .child('supporting_materials/others/$userId/$path')
        .delete();
  }

  //Ends Here

  Future<void> deleteApplicationPhoto(String path) async {
    return _storageReference.child('application_pictures/$path').delete();
  }

  Future<String> getImageUrl(String imageId) async {
    ImagePicker picker = ImagePicker();
    PickedFile imagePicked =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);
    File imageFile = File(imagePicked.path);
    UploadTask uploadTask =  uploadProfilePic(imageId, imageFile);
    return  await ( await uploadTask).ref.getDownloadURL();
  }

  Future<String> getApplicationPhotoUrl(String imageId, File imageFile) async {
    UploadTask uploadTask =
         uploadApplicationPhoto(imageId, imageFile);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUploadTranscriptsUrl(String userId, File files) async {
    UploadTask uploadTask = uploadTranscriptFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUploadLanguageUrl(String userId, File files) async {
    UploadTask uploadTask = uploadLanguageFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUploadReferenceUrl(String userId, File files) async {
    UploadTask uploadTask = uploadReferenceFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  //Supporting Materials Methods
  Future<String> getUploadPassportUrl(String userId, File files) async {
    UploadTask uploadTask =  uploadPassportFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUploadStatementsUrl(String userId, File files) async {
    UploadTask uploadTask =  uploadStatementFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUploadOthersUrl(String userId, File files) async {
    UploadTask uploadTask = uploadOtherFile(userId, files);
    return await (await uploadTask).ref.getDownloadURL();
  }

  //Ends Here

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

  Future<List<String>> getOnlyReferenceUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('references/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }
  //Supporting Material Methods

  Future<List<String>> getOnlyPassportUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('supporting_materials/passports/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }

  Future<List<String>> getOnlyStatementUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('supporting_materials/personal_statements/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }

  Future<List<String>> getOnlyOthersUrl(
      String userId, List<String> path) async {
    List<String> urls = [];
    for (var filename in path) {
      urls.add(await _storageReference
          .child('supporting_materials/others/$userId/$filename')
          .getDownloadURL());
    }
    return urls;
  }
  //Ends Here
}
