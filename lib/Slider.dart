import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class Slider_Page extends StatefulWidget {
  @override
  _Slider_PageState createState() => _Slider_PageState();
}

class _Slider_PageState extends State<Slider_Page> {
  String _url = "https://dhanrajsakariya.tk/slider";

  StreamController _streamController;
  Stream _stream;

  int _current = 0;

  Future<void> _lauchUrl;

  var _connectionStatus = "unknown";
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();

    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint(result.toString());
    });

    _streamController = StreamController();
    _stream = _streamController.stream;
    getUrl();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

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

  getUrl() async {
    Response reponse = await get(Uri.parse(_url));
    _streamController.add(json.decode(reponse.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: _stream,
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
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
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
                                    color: i == _current
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
        ],
      ),
    );
  }
}
