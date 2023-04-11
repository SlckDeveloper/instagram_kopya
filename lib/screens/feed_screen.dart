import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone2/utils/colors.dart';
import 'package:instagram_clone2/utils/global_veriables.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: width > webScreenSize
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              title: SvgPicture.asset(
                "assets/instagram_text_icon.svg",
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.messenger_outline),
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),

        ///-----1-----
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 15 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                );
              });
        },
      ),
    );
  }
}

/// -1- /// Firestore'dan veri çekerken dönen veri Future ise .get() metodunu kullanıyoruz, fakat
/// dönen veri Stream ise .snapshot() metodunu kullanıyoruz.
/// Collection'a ait tüm document'lerdeki verileri çekiyoruz --> ..collection("posts").snapshots()
/// Belirli bir document'e ait veriler için --> .collection("posts").doc("docId").snapshots(),
