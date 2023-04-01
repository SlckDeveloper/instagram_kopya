//Reference ref eşitiğinin karşısındaki ikinci child değeri normalde _auth.currentUser!.uid olması gerekirken null değeri döndürdüğü için kullanamadık
//ikinci child değeri resim dosyasının ismi olacağından mutlaka farklı bir değer olmalıdır, sabit bir değer yazıldığında her kullanıcıya aynı ismi vereceğinden
//sadece tek bir resim yüklemesi yapılabilir ve herkesin profil fotosu son yüklenen resim olur.
//videoda https://youtu.be/mEPm9w5QlJM?t=6045 kontrol et (1:40:00)


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageMethods{

  final FirebaseStorage _storage = FirebaseStorage.instance;
 final FirebaseAuth _auth = FirebaseAuth.instance;

  //Adding image to firebase storage
Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async{
print("---------------------------------------------_auth.currentUser!.uid:");
  Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
print("---------------------------------------------ref: "+ ref.toString());
  UploadTask uploadTask = ref.putData(file);
print("---------------------------------------------uploadTask: "+ uploadTask.toString());
  TaskSnapshot snap = await uploadTask;
print("---------------------------------------------snap: "+ snap.toString());
  String downloadURL = await snap.ref.getDownloadURL();
print("---------------------------------------------downloadURL: "+ downloadURL);
  return downloadURL;
}
}