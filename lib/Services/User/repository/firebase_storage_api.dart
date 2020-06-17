import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageAPI{

  final StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<StorageUploadTask> uploadFile(String path, File image) async {
    return _storageReference.child('profile_pictures/$path').putFile(image);
  }

  Future<String> getImageUrl(String imageId) async {
    ImagePicker picker = ImagePicker();
    PickedFile imagePicked = await picker.getImage(source: ImageSource.gallery);
    File imageFile = File(imagePicked.path);
    StorageUploadTask uploadTask = await uploadFile(imageId, imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}