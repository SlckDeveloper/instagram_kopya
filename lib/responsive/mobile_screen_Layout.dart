//import 'package:instagram_clone2/models/user.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone2/utils/colors.dart';
import 'package:instagram_clone2/utils/global_veriables.dart';
//import 'package:instagram_clone2/providers/user_provider.dart';
//import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  //-----1-----
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

/// -1- /// Bu alanda normalde setState kullanımı vardı fakat bunun yerine Provider ile veri
/// değişikliğini belirtiyoruz.
// String username ="";
//  @override
//  void initState() {
//    super.initState();
//    getUserName();
//  }
//
//  void getUserName() async {
//    DocumentSnapshot snap = await FirebaseFirestore.instance
//        .collection("users")
//        .doc(FirebaseAuth.instance.currentUser!.uid)
//        .get();
//
//        setState(() {
//          username = (snap.data() as Map<String, dynamic>)["username"];
//        });
//  }
