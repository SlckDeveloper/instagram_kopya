//iOS için kamera izinleri ayarlarının yapılması gerekiyor, aksi halde fotoğraf seçmek için kamera ikonuna basıldığında uygulama çökecektir.

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  ImagePicker imagePicker= ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if(file != null) {
    return await file.readAsBytes(); //-----1-----
  }
}

showSnackBar(String content, BuildContext context){ //-----2-----
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}



/// -1- ///_file.readAsBytes(); metodu seçilen dosyayı Future<Uint8List> tipinde geriye döndürür. O yüzden dosya tipimizi auth_methods.dart dosyamızda
///"required Uint8List file" şekinde tanımladık.

/// -2- ///Kullanıcıya hatalı işlemler için ekranda uyarı yazıları çıkarmak için bir SnackBar widget'ı barındıran showSnackBar fonksiyonu oluşturuldu.

///String değeri Uint8List tipine çeviren fonksiyon: (bunun yerine, indirdiğimiz image_picker paketini kullandık)
/*
final String defaultProfileImageURL = "https://i.pinimg.com/474x/72/c4/3c/72c43c0e10161d3f741681380cfa2986.jpg";
:::::::::::::::::::::::::::::::::::::::::::::String değeri Uint8List tipine çeviren fonksiyon::::::::::::::::::::::::::::::::::::::::::::::::::
Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
  final Uint8List uint8list = Uint8List.fromList(codeUnits);

  return uint8list;
}*/