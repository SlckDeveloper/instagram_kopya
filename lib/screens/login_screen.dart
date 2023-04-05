import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone2/models/user.dart' as model;
import 'package:instagram_clone2/resources/auth_methods.dart';
import 'package:instagram_clone2/responsive/mobile_screen_Layout.dart';
import 'package:instagram_clone2/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone2/responsive/web_screen_layout.dart';
import 'package:instagram_clone2/screens/signup_screen.dart';
import 'package:instagram_clone2/utils/colors.dart';
import 'package:instagram_clone2/utils/utils.dart';
import 'package:instagram_clone2/widgets/text_field_input.dart';


//import '../models/user.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        eMail: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      if (!mounted) return;
      model.User currentUser =  await AuthMethods().getUserDetails();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(user: currentUser),
                  webScreenLayout: WebScreenLayout()) ));
    } else {
      if (!mounted) return; //-----signup_screen.dart----->2
      showSnackBar(context, res);
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),

            ///svg image
            SvgPicture.asset(
              'assets/instagram-text-icon.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),

            ///text field input for e-mail
            TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: "Enter your e-mail"),
            const SizedBox(
              height: 24,
            ),

            ///text field input for password
            TextFieldInput(
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              hintText: "Pasword",
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            ///button for login
            InkWell(
              onTap: loginUser,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: primaryColor,
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ), //aşağıdan ve yuakrıdan padding vermek için vertical:12 kullanıldı
                        ),
                        color: blueColor,
                      ),
                      child: const Text("Log in"),
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),

            ///transitioning to signing up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

///Oluluşturmuş olduğumuz TextFieldInput class'ına ait textEditingController: özelliği, TextField widget'ının controller: özelliğne atandığı için tipi de
///TextEditingController olarak belirlenmiştir(bkz. text_field_input.dart dosyası, açıklama satırları). Yani _emailController değişkeni TextFieldInput ile
///belirtilen alana kullanıcı tarafaından girilen metin değerini tutar(_emailController.text). Aynı şekilde _passwordController değişkeni extFieldInput ile
///belirtilen alana kullanıcı tarafaından girilen metin(şifre) değerini tutar(_passwordController.text).

///InkWell ve GestureDetector widget'ları interaktiflik özelliği olmayan widget'lara interaktiflik özelliği (örneğin tıklanma özelliği) eklemek için kullanılır.
///GestureDetector daha fazla kontrol sağlasa da(sürükle bırak gibi), biribirleri ile hemen hemen aynıdır.
///InkWell ile sarmalanan widget üzerine tıklandığında bir tıklama efekti (mürekkep dağılması gibi) sağlarken, GestureDetector'da bu efekt yoktur.