import 'package:flutter/material.dart';
import 'package:instagram_clone2/resources/auth_methods.dart';
import 'package:instagram_clone2/resources/storage_methods.dart';
class HomeScreenWidgets extends StatefulWidget {
 const HomeScreenWidgets({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidgets> createState() => _HomeScreenWidgetsState();
}

class _HomeScreenWidgetsState extends State<HomeScreenWidgets> {
  String? pic;

void profilePic() async{
      pic = await StorageMethods().downloadProfilePicWithURL();
   setState(() {
     pic;
   });
        }

        @override
  void initState() {
    profilePic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Center(child: pic == null ? const Image(image: AssetImage("assets/animalprofile.jpg")) : Image(image: NetworkImage(pic!)),);
  }
}
