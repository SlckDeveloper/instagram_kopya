//Reference ref eşitiğinin karşısındaki ikinci child değeri normalde _auth.currentUser!.uid olması gerekirken null değeri döndürdüğü için kullanamadık
//ikinci child değeri resim dosyasının ismi olacağından mutlaka farklı bir değer olmalıdır, sabit bir değer yazıldığında her kullanıcıya aynı ismi vereceğinden
//sadece tek bir resim yüklemesi yapılabilir ve herkesin profil fotosu son yüklenen resim olur.
//videoda https://youtu.be/mEPm9w5QlJM?t=6045 kontrol et (1:40:00)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);


if(isPost){
  String id = const Uuid().v1();
  ref = ref.child(id);
}

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();

    return downloadURL;
  }

  //Getting image URL from firebase storage
  Future<String> downloadProfilePicWithURL() async {

   String downloadURL = await _storage.ref().child("profilePics").child(_auth.currentUser!.uid).getDownloadURL();
print("----------------------------------------------------------------------------------"+downloadURL);
    return downloadURL;
  }
}
