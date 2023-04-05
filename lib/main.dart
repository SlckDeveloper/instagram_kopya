//import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone2/providers/user_provider.dart';
import 'package:instagram_clone2/responsive/mobile_screen_Layout.dart';
import 'package:instagram_clone2/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone2/responsive/web_screen_layout.dart';
import 'package:instagram_clone2/screens/login_screen.dart';
import 'package:instagram_clone2/screens/signup_screen.dart';
import 'package:instagram_clone2/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  if (kIsWeb) { //-----3-----
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
    
        
        theme: ThemeData.dark() //-----2-----
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
       
        home: LoginScreen(),
      ),
    );
  }
}


/// -1- Burada normalde Text("${snapshot.error}") olması gerekiyordu, fakat hata verdiği için düz metin girdim 
/// video=> 2:12:00 https://youtu.be/mEPm9w5QlJM?t=7921

///  -2- utils clasörüne tanımlayacağımız color'lar ile "theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: myColorFromUtilsFolder)"
///şeklinde kullanımlar yaparak özelleştirebiliriz.

/// -3- Firebase'i mobil platformlar ve web için iki farklı şekilde konfigüre etmeliyiz.
 
/* home: propertisine atanacak değer...
  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("snapshot error happenede:") //-----1-----
                  ,
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
        */