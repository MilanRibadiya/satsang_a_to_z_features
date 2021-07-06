import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class ApiCheck extends StatefulWidget {
  @override
  _ApiCheckState createState() => _ApiCheckState();
}

class _ApiCheckState extends State<ApiCheck> {
  String dailyDarshanUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/dailydarshan/7/";

  Future<List<DarshanModel>> getDarshanUrl() async {
    var result = await http.get(Uri.parse(dailyDarshanUrl));
    var jsonData = json.decode(result.body);
    List<DarshanModel> darshanList = [];
    for (int i = 0; i < jsonData.length; i++) {
      var darshan = DarshanModel.fromJson(jsonData[i]);
      darshanList.add(darshan);
    }
    return darshanList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          child: FutureBuilder(
              future: getDarshanUrl(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 200.0,
                    width: 350.0,
                    color: Colors.blue,
                  );
                }
                return Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          height: 183,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 215,
                                  height: 220,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 25),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.5, right: 7, left: 10, bottom: 5),
                                              child: Transform.rotate(
                                                angle: pi / 20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    alignment: Alignment.centerRight,
                                                    imageUrl: snapshot.data[index].images[2],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, right: 10, left: 10, bottom: 5),
                                              child: Transform.rotate(
                                                angle: pi / -20,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    alignment: Alignment.centerLeft,
                                                    imageUrl: snapshot.data[index].images[0],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                child: Container(
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot.data[index].images[1],
                                                    fit: BoxFit.fill,
                                                  ),
                                                  height: 150,
                                                  width: 120,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: mediumColor,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data[index].day.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: "baloobhai",
                                                        fontWeight: FontWeight.w800,
                                                        height: 1,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data[index].month.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: "baloobhai",
                                                        fontWeight: FontWeight.w400,
                                                        height: 1,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class DarshanModel {
  int day;
  int month;
  int year;
  List<String> images;

  DarshanModel({this.day, this.month, this.year, this.images});

  DarshanModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['images'] = this.images;
    return data;
  }
}
