import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone2/models/user.dart' as model; 
import 'package:instagram_clone2/resources/storage_methods.dart';

class AuthMethods {
  //-----4-----

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<model.User> getUserDetails() async{
  User currentUser = _auth.currentUser!;
  DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser!.uid).get();
  return model.User.fromSnap(snap);
}


  ///sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file, //-----1-----
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) //-----5----
      {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoURL = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false); //-----6------

        //add user to firestore database
        model.User user = model.User(email: email, username: username, uid: cred.user!.uid, bio: bio, photoUrl: photoURL, followers: [], following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());//-----3-----
          
        res = "success";
      }
    } catch (err) {
      //-----2------
      res = err.toString();
    }
    return res;
  }

  ///logging in user
  Future<String> loginUser(
      {required String eMail, required String password}) async {
    String res = "Some error occurred";
    try {
      if (eMail.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: eMail, password: password);

        res = "success";
      } else {
        res = "Please enter all the fields!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

///createUserWithEmailAndPassword() metodu ile kullanıcının sadece email ve password bilgilerini kullanarak kayıt işlemi yapıyoruz --> FirebaseAuth
///Fakat diğer bilgilerini de kayıt etmemiz gerekiyor, bunun için veritabanı kısmına (Firestore Database) username, bio ve file değişkenlerini de eklemeliyiz.

/// -1- /// Resim dosyasını almak için File tipinde (Uint8List) ve file adında bir değişken tanımladık

/// -2- /// try-catch bloklarına FirabaseAuthException hata yakalama satırları eklenerek daha açıklayıcı yönlendirmelerle giriş yapılması sağlanabilir
//on FirebaseAuthException catch  (e) {
//   print('Failed with error code: ${e.code}');
//   print(e.message);
///https://firebase.flutter.dev/docs/auth/error-handling/   bu siteye göz at..

/// -3- /// Kullanıcı verilerini veri tabanına yüklemenin başka bir yöntemi:
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

/// -4- /// Classlar iki önemli özelliğe sahiptir: properties ve methods; özellikler class içerisinde tanımlanan basit değişkenler olup class'ın nasıl görünüceği ile
///ilgilidir. Metodlar ise class içerisinde tanımlanan fonksiyonlar olup class'a fonksiyonellik katar. Başka bir dart dosyasından ilgili class'a erişmek için
///önce o class'ın bir örneği oluşturulur ve o örnek üzerinden nokta operatörü ile ilgili özellik ve metodlara ulaşılabilir;
/// AuthMethods degiskenAdi = AuthMethods(); ---> degiskenAdi.ozellik1;  degiskenAdi.method1();

/// -5- /// file, required olduğu için normalde null olamaz fakat yine de kontrollere ekledik

/// -6- /// Burada photoURL değşkenine null değer dönme ihtimali olabilir, kullanıldığı yerlerde nullcheck
/// işlemi yapılması daha uygun olabilir.