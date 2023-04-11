import 'package:flutter/material.dart';
import 'package:instagram_clone2/providers/user_provider.dart';
import 'package:instagram_clone2/utils/global_veriables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

@override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false); //-----1-----
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > webScreenSize) {
        /// Web screen
        return widget.webScreenLayout;
      }
        /// Mobile phone screen
      return widget.mobileScreenLayout;
    });
  }
}


/// -1- /// listen:false ifadesi gereksiz rebuiltleri önlemek için dinlemenin yapılmayacağını gösterir.
/// Bunun yerine, sonrasında, dinlemenin refreshUser(); metodu kullanılarak yapılacağını belirtiyoruz
/// Yani kullanıcı verileri değiştikçe, bu değişim provider ile _userProvider'a aktarılsın