import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final isPass; //Giriş alanının password alanı veya e-mail alanı olup olmadığını kontrol etmek için..
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.textInputType,
    required this.hintText,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}

///TextField içerisinde bulunan controller parametresi TextEditingController tipinde bir nesne alır ve biz bu sayede TextField içeisindeki yazıyı okuyabiliriz.
///Bunun için öncelikle ismini bizim verdiğimiz, mesela textEditingController adında bir TextEditingController oluşturuyoruz.
///TextField içerisinde controller parametresine ismini bizim verdiğimiz textEditingController‘ı atıyoruz.
///Artık yazının içerisindeki veriyi okuyabilen bir controller’ımız var.
///Kod satırlarının herhangi bir yerinde textEditingController.text diyerek TextField içerisine yazılmış olan yazıya erişmiş oluyoruz.