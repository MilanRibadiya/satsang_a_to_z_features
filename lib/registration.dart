import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class Registration_Page extends StatefulWidget {
  @override
  _Registration_PageState createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {
  double screenHeight, screenWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth=size.width;
    screenHeight=size.height;

    return SafeArea(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            width: screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/registration_1.png"),
            )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Text(
                "REGISTRATION",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Euclid",
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
