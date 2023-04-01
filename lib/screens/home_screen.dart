import 'package:flutter/material.dart';
import 'package:instagram_clone2/screens/home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreenWidgets());
  }
}
