import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class sliderPage extends StatefulWidget {
  @override
  _sliderPageState createState() => _sliderPageState();
}

class _sliderPageState extends State<sliderPage> {
  String sliderUrl = "https://dhanrajsakariya.tk/slider";
  String dailyDarshanUrl = "https://dhanrajsakariya.tk/dailydarshan/26-06-2021";

  StreamController sliderController, dailyDarshanController;
  Stream sliderStream, dailyDarshanStream;

  int current = 0;

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  List<String> darshanList = [];

  List getDarshan;

  @override
  void initState() {
    super.initState();

    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint(result.toString());
    });

    sliderController = StreamController();
    sliderStream = sliderController.stream;
    dailyDarshanController = StreamController();
    dailyDarshanStream = dailyDarshanController.stream;
    getSliderUrl();
    getDailyDarshanUrl();

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

  Future<void> __launchBrowser(String _url) async {
    if (await canLaunch(_url)) {
      await launch(
        _url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      debugPrint('Could not launch $_url');
    }
  }

  getSliderUrl() async {
    Response sliderResponse = await get(Uri.parse(sliderUrl));
    sliderController.add(json.decode(sliderResponse.body));
  }

  Future<void> getDailyDarshanUrl() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            StreamBuilder(
              stream: sliderStream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 180.0,
                    width: 350.0,
                    color: Colors.grey,
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: 180.0,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.ease,
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
                              __launchBrowser(
                                  snapshot.data[index]['click_url']);
                            },
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data[index]['url'].toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < snapshot.data.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: i == current
                                          ? Colors.black
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(5))),
                            )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Column(
              children: [
                StreamBuilder(
                    stream: dailyDarshanStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 180.0,
                          width: 350.0,
                          color: Colors.pink,
                        );
                      }
                      return Container(
                        height: 300,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: darshanList[index],
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
