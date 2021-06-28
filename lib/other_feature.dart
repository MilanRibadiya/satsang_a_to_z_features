import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Other_Feature extends StatefulWidget {
  @override
  _Other_FeatureState createState() => _Other_FeatureState();
}

class _Other_FeatureState extends State<Other_Feature> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/logo.png'),
          IconButton(
            icon: Icon(CupertinoIcons.share),
            onPressed: () {
              Share.share("Share our App \n https://play.google.com/store/apps/details?id=com.kalakunjmandir.satsang_a_to_z ");
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.star_fill),
            onPressed: () {
              Share.share("Share our App \n https://play.google.com/store/apps/details?id=com.kalakunjmandir.satsang_a_to_z ");
            },
          )
        ],
      ),
    );
  }
}
