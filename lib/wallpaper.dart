import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  String _url = "https://dhanrajsakariya.tk/wallpaper/mobile";

  StreamController _streamController;
  Stream _stream;

  String _wallpaperFile = 'Unknown';

  getWallpaper() async {
    Response response = await get(Uri.parse(_url));
    _streamController.add(json.decode(response.body));
  }

  Future<void> setWallpaperFromFile(String url, int place) async {
    setState(() {
      _wallpaperFile = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, place);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFile = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          StreamBuilder(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 180.0,
                  width: 350.0,
                  color: Colors.grey,
                );
              }

              return Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot.data[index]['url'].toString(),
                              ),
                              GestureDetector(
                                onTap: () => showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        title: Text(
                                          "Satsang A to Z",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                        message: Text("Which place we are set this Wallpaper ?"),
                                        cancelButton: CupertinoActionSheetAction(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        actions: [
                                          CupertinoActionSheetAction(
                                              child: Text("Home Screen"),
                                              onPressed: () {
                                                setWallpaperFromFile(
                                                    snapshot.data[index]['url'].toString(), 1);
                                                Navigator.of(context).pop();
                                              }),
                                          CupertinoActionSheetAction(
                                              child: Text("Lock Screen"),
                                              onPressed: () {
                                                setWallpaperFromFile(
                                                    snapshot.data[index]['url'].toString(), 2);
                                                Navigator.of(context).pop();
                                              }),
                                          CupertinoActionSheetAction(
                                              child: Text("Both"),
                                              onPressed: () {
                                                setWallpaperFromFile(
                                                    snapshot.data[index]['url'].toString(), 3);
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      );
                                    }),
                                child: Container(
                                    height: 50,
                                    color: Color.fromRGBO(189, 189, 189, 0.8),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: Text(
                                      "Download",
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
