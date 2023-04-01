import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone2/responsive/mobile_screen_Layout.dart';
import 'package:instagram_clone2/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone2/responsive/web_screen_layout.dart';
import 'package:instagram_clone2/screens/login_screen.dart';
import 'package:instagram_clone2/screens/signup_screen.dart';
import 'package:instagram_clone2/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Firebase'i mobil platformlar ve web için iki farklı şekilde konfigüre etmeliyiz
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBfvMG94CaT6159nNgCHbCnOEly_PY05mc",
            appId: "1:283908848628:web:827915f995897bbf28d7a1",
            messagingSenderId: "283908848628",
            projectId: "instagram-kopya",
            storageBucket: "instagram-kopya.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      ///utils clasörüne tanımlayacağımız color'lar ile "theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: myColorFromUtilsFolder)"
      ///şeklinde kullanımlar yaparak özelleştirebiliriz.
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      home: SignupScreen(),
      );

  }
}