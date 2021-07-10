import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satsang_a_to_z_feature/colors.dart';

class NiyamProfile extends StatefulWidget {
  @override
  _NiyamProfileState createState() => _NiyamProfileState();
}

class _NiyamProfileState extends State<NiyamProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: new Container(
            decoration: new BoxDecoration(
              color: primaryColor,
              image: new DecorationImage(
                image: new ExactAssetImage('assets/images/splash_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 2.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0, right: 35.0, left: 35.0),
                child: new Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.87),
                    ),
                    child: LayoutBuilder(builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraint.maxHeight),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0, bottom: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/images/app_logo.png",
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_pin,
                                        size: 45,
                                        color: primaryColor,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: primaryColor),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Swaminarayan",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontFamily: "baloobhai",
                                                      fontSize: 17),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.elderly_rounded,
                                        size: 45,
                                        color: primaryColor,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: primaryColor),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "18",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontFamily: "baloobhai",
                                                      fontSize: 17),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone_iphone_rounded,
                                        size: 45,
                                        color: primaryColor,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: primaryColor),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "9999999999",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontFamily: "baloobhai",
                                                      fontSize: 17),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: "baloobhai",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0),
                                          child: Icon(
                                            CupertinoIcons.arrow_right,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
