import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:satsang_a_to_z_feature/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  String sliderUrl = "https://dhanrajsakariya.tk/slider";
  String dailyDarshanUrl = "https://dhanrajsakariya.tk/dailydarshan/26-06-2021";
  String upcomingEventUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/upcoming/";

  StreamController sliderController, dailyDarshanController;
  Stream sliderStream, dailyDarshanStream;

  int current = 0;

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  List socialMedia = [
    [
      "assets/images/youtube.png",
      "Youtube",
      "https://www.youtube.com/c/Gunatit1008byKalakunjMandirSurat",
    ],
    [
      "assets/images/website.png",
      "Website",
      "https://kalakunjmandir.com/",
    ],
    [
      "assets/images/instagram.png",
      "Instagram",
      "https://instagram.com/gunatit1008bykalakunjmandir",
    ],
    [
      "assets/images/whatsapp.png",
      "Whatsapp",
      "https://wa.me/918460652000",
    ],
    [
      "assets/images/facebook.png",
      "Facebook",
      "https://www.facebook.com/Gunatit1008-By-Kalakunj-Mandir-1505813716160964",
    ],
    [
      "assets/images/telegram.png",
      "Telegram",
      "https://t.me/Gunatit1008byKalakunjMandir",
    ],
    [
      "assets/images/twitter.png",
      "Twitter",
      "https://twitter.com/Kalakunj_Mandir",
    ]
  ];

  @override
  void initState() {
    super.initState();

    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint(result.toString());
    });

    sliderController = StreamController();
    sliderStream = sliderController.stream;
    dailyDarshanController = StreamController();
    dailyDarshanStream = dailyDarshanController.stream;
    getSliderUrl();
    // getDailyDarshanUrl();

    // getDarshanFuture();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  /*Future<String> getDarshanFuture() async {
    print("In Async");
    await http.post(Uri.parse(dailyDarshanUrl)).then((response) {
      print("In Get");
      getDarshan = json.decode(response.body);
    });
  }*/

  Future<List<DarshanModel>> getDarshanUrl() async {
    var result = await http.get(Uri.parse(dailyDarshanUrl));
    var jsonData = json.decode(result.body);
    List<DarshanModel> darshanList = [];
    for (var i in jsonData) {
      DarshanModel model = DarshanModel(i["image"]);
      darshanList.add(model);
    }
    return darshanList;
  }

  Future<List<UpComingModel>> getUpcomingUrl() async {
    var result = await http.get(Uri.parse(upcomingEventUrl));
    var jsonData = json.decode(result.body);
    List<UpComingModel> upcomingList = [];
    for (var i in jsonData) {
      UpComingModel model = UpComingModel(i["image"], i["name"], i["date"]);
      upcomingList.add(model);
    }
    return upcomingList;
  }

  Future<void> __launchBrowser(String _url) async {
    await launch(
      _url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'},
    );
  }

  getSliderUrl() async {
    Response sliderResponse = await get(Uri.parse(sliderUrl));
    sliderController.add(json.decode(sliderResponse.body));
  }

  /*Future<void> getDailyDarshanUrl() async {
    Response darshanResponse = await get(Uri.parse(dailyDarshanUrl));
    dailyDarshanController.add(json.decode(darshanResponse.body));

    var list1 = json.decode(darshanResponse.body);
    print(list1[1]['image']);
    for (int i = 0; i < list1.length; i++) {
      if(await canLaunch(list1[i]['image'])){
        darshanList.add(list1[i]['image'].toString());
        debugPrint(darshanList[i].toString());
      }

    }
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*bottomNavigationBar: CurvedNavigationBar(
          color: mediumColor,
          backgroundColor: Color.fromRGBO(148, 30, 30, 0),
          height: 60,
          index: 2,
          items: [
            Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            Icon(
              Icons.ac_unit_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.ac_unit_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
          ],
        ),*/
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      "assets/images/home_title.png",
                    ),
                    fit: BoxFit.fill,
                  )),
                  child: Row(
                    children: [
                      Container(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(55.0),
                            topRight: const Radius.circular(55.0),
                          ),
                        ),
                        height: 85,
                        width: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.menu_open,
                            color: primarySwatch[900],
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0, right: 45),
                                child: Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Text(
                                          "SATSANG A TO Z",
                                          style: TextStyle(
                                            fontFamily: "baloobhai",
                                            fontSize: 28,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Text(
                                          "HOME",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "baloobhai",
                                            color: Colors.white,
                                            height: 1,
                                            letterSpacing: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 22),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "30 June 2021",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontFamily: "baloobhai",
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "શ્રાવણ વદ 6",
                                              style: TextStyle(
                                                fontSize: 18,
                                                height: 1,
                                                fontFamily: "baloobhai",
                                                color: primaryColor,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: StreamBuilder(
                    stream: sliderStream,
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 180.0,
                          width: 350.0,
                          color: Colors.grey,
                        );
                      }

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CarouselSlider.builder(
                              options: CarouselOptions(
                                autoPlay: true,
                                height: 180.0,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(seconds: 1),
                                autoPlayCurve: Curves.easeInOut,
                                enlargeCenterPage: true,
                                onPageChanged: (sliderIndex, reason) {
                                  setState(() {
                                    current = sliderIndex;
                                  });
                                },
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index, realIdx) {
                                return GestureDetector(
                                  onTap: () {
                                    __launchBrowser(snapshot.data[index]['click_url']);
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data[index]['url'].toString(),
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                );
                              }),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < snapshot.data.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                      child: AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          height: i == current ? 9 : 7,
                                          width: i == current ? 16 : 7,
                                          decoration: BoxDecoration(
                                              color: i == current ? Colors.white : Colors.grey[400],
                                              borderRadius: BorderRadius.circular(5))),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: FutureBuilder(
                          future: getDarshanUrl(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 200.0,
                                width: 350.0,
                                color: Colors.pink,
                              );
                            }
                            return Container(
                              height: 220,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  FeatureTitle("Daily Darshan"),
                                  Container(
                                    height: 163,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(7.0),
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
                                                                imageUrl: snapshot.data[2].dUrl))),
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
                                                                imageUrl: snapshot.data[0].dUrl))),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot.data[1].dUrl,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: FutureBuilder(
                          future: getUpcomingUrl(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 180.0,
                                width: 350.0,
                                color: Colors.blue,
                              );
                            }
                            return Container(
                              height: 220,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  FeatureTitle("Upcoming Events"),
                                  Container(
                                    height: 170,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: double.infinity,
                                              width: 178,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[350],
                                                      blurRadius: 5,
                                                      offset: Offset(3, 5),
                                                    ),
                                                  ]),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      CachedNetworkImage(
                                                        height: 100,
                                                        imageUrl: snapshot.data[index].img,
                                                        imageBuilder: (context, imageProvider) => Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                topRight: Radius.circular(10)),
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context, url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Container(
                                                            height: 70,
                                                            width: 120,
                                                            alignment: Alignment.centerLeft,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      left: 8.0,
                                                                      top: 3,
                                                                    ),
                                                                    child: Text(
                                                                      snapshot.data[index].detail,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.start,
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        fontFamily: "poppins",
                                                                        fontWeight: FontWeight.w800,
                                                                        color: primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    snapshot.data[index].detail,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                      fontSize: 10,
                                                                      color: Colors.grey,
                                                                      fontFamily: "poppins",
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 8.0,
                                                      top: 8.0,
                                                      bottom: 12.0,
                                                    ),
                                                    child: Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Container(
                                                        height: 56,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(7),
                                                          color: mediumColor,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "26",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 18,
                                                                    fontFamily: "baloobhai",
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 1,
                                                                width: 30,
                                                                color: secondaryExtraLightColor,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "September",
                                                                  overflow: TextOverflow.ellipsis,
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 15,
                                                                    fontFamily: "baloobhai",
                                                                  ),
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
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 120,
                    child: Column(
                      children: [
                        FeatureTitle("Connect with Us"),
                        Container(
                          height: 80,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: socialMedia.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    __launchBrowser(socialMedia[index][2].toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      child: Image.asset(
                                        socialMedia[index][0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DarshanModel {
  String dUrl;

  DarshanModel(this.dUrl);
}

class UpComingModel {
  String img, detail, date;

  UpComingModel(this.img, this.detail, this.date);
}

class FeatureTitle extends StatelessWidget {
  String title;

  FeatureTitle(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 16,
            color: mediumColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontFamily: "baloobhai",
                color: mediumColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: mediumColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 1.5,
                width: double.infinity,
                color: secondaryLightColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
