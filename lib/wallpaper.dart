import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:satsang_a_to_z_feature/colors.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  String _url = "https://satsang-a-to-z-api.kalakunjmandir.in/wallpaper";

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
        appBar: AppBar(
          title: Text(
            "Wallpaper",
            style: TextStyle(fontFamily: "baloobhai"),
          ),
          backgroundColor: primaryColor,
        ),
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
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          print("Swaminarayan");
                          showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                    child: InteractiveViewer(
                                      child: CachedNetworkImage(
                                          imageUrl: snapshot.data[index]['image'].toString()),
                                    ),
                                  ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data[index]['image'].toString(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) {
                    return new StaggeredTile.fit(1);
                  },
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
