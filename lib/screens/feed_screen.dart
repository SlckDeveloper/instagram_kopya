import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone2/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/instagram_text_icon.svg",
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline),),
        ],
      ),
      body: const PostCard(),
    );
  }
}
