import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ValueChanger extends StatefulWidget {
  @override
  _ValueChangerState createState() => _ValueChangerState();
}

class _ValueChangerState extends State<ValueChanger> {
  String sliderUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/slider/";

  StreamController sliderController;
  Stream sliderStream;

  var pos = ValueNotifier(0);

  getSliderUrl() async {
    Response sliderResponse = await get(Uri.parse(sliderUrl));
    sliderController.add(json.decode(sliderResponse.body));
  }

  @override
  void initState() {
    sliderController = StreamController();
    sliderStream = sliderController.stream;
    getSliderUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        pos.value = sliderIndex;
                      });
                    },
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index, realIdx) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data[index]['image'].toString(),
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
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < snapshot.data.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: ValueListenableBuilder(
                          valueListenable: pos,
                          child: Dots(),
                          builder: (context, p, c) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 800),
                              height: i == p ? 9 : 7,
                              width: i == p ? 16 : 7,
                              decoration: BoxDecoration(
                                  color: i == p ? Colors.white : Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5)),
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

AnimatedContainer Dots() {
  return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)));
}
