


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone2/resources/storage_methods.dart';

class AuthMethods {
  //kullanıcı kayıt
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //kullanıcı verileri
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  ///sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    //Resim dosyasını almak için File tipinde (Uint8List) ve file adında bir değişken tanımladık
  }) async {
    String res = "Some error occured";
    print("-----------------1 async içine girildi");


    try {
      print("-----------------2 try içine girildi");
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null)
      //file, required olduğu için normalde null olamaz fakat yine de kontrollere ekledik
      {
        print("-----------------3 if içine girildi");

        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("-----------------3.1 usercredential oluşturuldu");
        String? photoURL = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        print("-----------------4 foto yüklendi");

        //add user to firestore database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoURL,
        });
        print("-----------------5 firestora veri yazıldı");
        res = "success";
      }
    } catch (err) {
      print("-----------------6 hata yakalandı");
      res = err.toString();
          }
    print("-----------------7 return sağlandı");
    return res;
  }
}

///createUserWithEmailAndPassword() metodu ile kullanıcının sadece email ve password bilgilerini kullanarak kayıt işlemi yapıyoruz --> FirebaseAuth
///Fakat diğer bilgilerini de kayıt etmemiz gerekiyor, bunun için veritabanı kısmına (Firestore Database) username, bio ve file değişkenlerini de eklemeliyiz.

/// Kullanıcı verilerini veri tabanına yüklemenin başka bir yöntemi:
// await _firestore.collection('users').add({
//  'username': username,
//  'uid': cred.user!.uid,
//  'email': email,
//  'bio': bio,
//  'followers': [],
//  'following': []
// });
///.set() kullanarak userID(uid) ve documentID'nin birbirine eşit olmasını sağlayabiliriz. .add() kullandığımızda ise documentID, firebase tarafından
///otomatik oluşturulur. .set() ile birlikte kullanılan .doc() ile documentID değerini kendimiz blirleyebiliriz.

///Classlar iki önemli özelliğe sahiptir: properties ve methods; özellikler class içerisinde tanımlanan basit değişkenler olup class'ın nasıl görünüceği ile
///ilgilidir. Metodlar ise class içerisinde tanımlanan fonksiyonlar olup class'a fonksiyonellik katar. Başka bir dart dosyasından ilgili class'a erişmek için
///önce o class'ın bir örneği oluşturulur ve o örnek üzerinden nokta operatörü ile ilgili özellik ve metodlara ulaşılabilir;
/// AuthMethods degiskenAdi = AuthMethods(); ---> degiskenAdi.ozellik1;  degiskenAdi.method1();

///try-catch bloklarına FirabaseAuthException hata yakalama satırları eklenerek daha açıklayıcı yönlendirmelerle giriş yapılması sağlanabilir
//on FirebaseAuthException catch  (e) {
//   print('Failed with error code: ${e.code}');
//   print(e.message);
///https://firebase.flutter.dev/docs/auth/error-handling/   bu siteye göz at..

