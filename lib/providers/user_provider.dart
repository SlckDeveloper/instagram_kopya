import 'package:flutter/widgets.dart';
import 'package:instagram_clone2/models/user.dart';
import 'package:instagram_clone2/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  User? _user; 
final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!; ///-----W-1-----///

  Future<void> refreshUser() async{
User user = await _authMethods.getUserDetails();
notifyListeners(); //-----1-----
  }
}


/// -1- /// notifyListeners(); bir veri değiştiğinde değişikliği haber veren fonksiyon. Class'ı dinler.
/// Class'lar içinde çağrılır ve class içerisindeki veri (user) değiştiğinde haber verir.
/// ValueListenableBuilder konusuna göz atabilirsin.

///  -W-1- ///Bu metodu kullanan add_post_screen.dart dosyasındaki built metodunun hemen altında yer alan User user=
/// atamasına null değer gönderiyor olabilir.