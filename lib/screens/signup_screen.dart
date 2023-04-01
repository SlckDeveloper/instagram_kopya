import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone2/resources/auth_methods.dart';
import 'package:instagram_clone2/utils/utils.dart';

import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  ///Uygulama kapandığında TextField içeriklerinin boşaltılması için dispose() metodu override edilerek değişken değerleri sıfırlanır.
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery); //-----1-----
    if (im != null) {
      setState(() {
        _image = im;
      });
    } else {
      print(
          "-------------------------galeriden dönen im değişken değeri null!!");
    }
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      isLoading = false;
    });
    if (res != "success") {
      if (!mounted) return; //-----2-----
      showSnackBar(res, context);
    } else {
      if (!mounted) return; //-----2-----
      showSnackBar("Successfully registered", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
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

            ///circle avatar to accept and show our selected file
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                //-----3-----
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage("assets/animalprofile.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 24,
            ),

            ///text field input for e-mail
            TextFieldInput(
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
                hintText: "Enter your user name"),
            const SizedBox(
              height: 24,
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

            ///text field input for password
            TextFieldInput(
              textEditingController: _bioController,
              textInputType: TextInputType.text,
              hintText: "Your bio",
            ),
            const SizedBox(
              height: 24,
            ),

            ///button for login
            InkWell(
              onTap: signUpUser,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.tealAccent,
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
                  child: const Text("Don't have an account? "),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("  Sign Up",
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

/// -1- pickImage() metodu, dynamic tipinde değer döndürdüğünden Uint8List tipinde bir değişkene atayabildik.

/// -2- Dart dili asenkron bir bloğun içerisinde context kullanılmasını sakıncalı görüyor ve bunun için bir if kontrolü ile context.mounted'i kontrol ederek
///kullanmamızı veya sadece senkron bloklar içerisinde kullanmamızı tavsiye ediyor

/// -3- Stack pencere öğesi, ekrana birden çok pencere öğesi katmanı yerleştirmemize olanak tanır.
///Widgetlar bir katman şeklinde birbirlerinin üzerinde konumlandırılabilirler
///Widget, birden fazla çocuğu alır ve bunları aşağıdan yukarıya doğru sıralar. Yani ilk öğe en alttaki ve sonuncu öğe en üstteki öğedir.
///Positioned widget'ı ile CircleAvatar widget'ının üzereine bir katman şeklinde IconButton eklenmiştir.
