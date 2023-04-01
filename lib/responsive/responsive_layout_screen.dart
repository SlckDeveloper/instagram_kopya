import 'package:flutter/material.dart';
import 'package:instagram_clone2/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > webSreensize) {
        /// Web screen
        return webScreenLayout;
      }
        /// Mobile phone screen
      return mobileScreenLayout;
    });
  }
}
