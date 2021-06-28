import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satsang_a_to_z_feature/Slider.dart';
import 'package:satsang_a_to_z_feature/colors.dart';
import 'package:satsang_a_to_z_feature/other_feature.dart';
import 'package:satsang_a_to_z_feature/registration.dart';
// import 'package:satsang_a_to_z_feature/Slider.dart';
import 'package:satsang_a_to_z_feature/wallpaper.dart';
// import 'package:satsang_a_to_z_feature/Live_Katha.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: sliderPage());


  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor)
    );

  }
}
