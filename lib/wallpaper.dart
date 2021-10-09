import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:satsang_a_to_z_feature/HomePage.dart';
import 'package:satsang_a_to_z_feature/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> with SingleTickerProviderStateMixin {
  String mobileWallpaperUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/wallpaper/mobile";
  String desktopWallpaperUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/wallpaper/desktop";

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallpaper",
          style: TextStyle(fontFamily: "baloobhai"),
        ),
        leading: Icon(Icons.arrow_back),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, size: Size(392.72, 838.90)),
        child: SafeArea(
          child: Column(
            /*children: [
              Container(
                color: Colors.purple,
                child: TabBar(controller: tabController, tabs: [
                  Row(
                    children: [
                      Icon(Icons.phone_iphone_rounded),
                      SizedBox(width: 5),
                      Text('Mobile'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.desktop_mac),
                      SizedBox(width: 5),
                      Text('Desktop'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 5),
                      Text('HOme'),
                    ],
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  WallpaperPage(mobileWallpaperUrl),
                  WallpaperPage(desktopWallpaperUrl),
                  HomePage(),
                ]),
              )
            ],*/
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 18, right: 18),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: /*Color(0xff993955)*/ primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: /*Color(0xffffcfdc)*/ secondaryLightColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 4.0,
                    unselectedLabelColor: secondaryLightColor,
                    tabs: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone_iphone_rounded),
                            SizedBox(width: 5),
                            Text(
                              'Mobile',
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.desktop_mac),
                          SizedBox(width: 5),
                          Text(
                            'Desktop',
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.desktop_mac),
                          SizedBox(width: 5),
                          Text(
                            'Home',
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      /*Row(
                        children: [
                          Icon(Icons.home),
                          SizedBox(width: 5),
                          Text('HOme'),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    WallpaperPage(mobileWallpaperUrl, true),
                    WallpaperPage(desktopWallpaperUrl, false),
                    HomePage(),
                    /*HomePage(),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WallpaperPage extends StatefulWidget {
  String s;
  bool i;
  @override
  _WallpaperPageState createState() => _WallpaperPageState();

  WallpaperPage(String s, bool i) {
    this.s = s;
    this.i = i;
  }
}

class _WallpaperPageState extends State<WallpaperPage> with AutomaticKeepAliveClientMixin<WallpaperPage> {
  Future wallFuture;
  String _wallpaperFile = 'Unknown';
  bool get wantKeepAlive => true;
  var height = 200.0;
  final random = Random();

  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails;

  Future<List<WallModel>> getWallUrl() async {
    var result = await http.get(Uri.parse(widget.s));
    var jsonData = json.decode(result.body);
    List<WallModel> wallList = [];
    for (var i in jsonData) {
      WallModel model = WallModel(i["image"]);
      wallList.add(model);
    }
    return wallList;
  }

  Future<void> setWallpaperFromFile(String url, int place) async {
    setState(() {
      _wallpaperFile = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.HOME_SCREEN);
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
    wallFuture = getWallUrl();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, size: Size(392.72, 838.90)),
      child: Column(children: [
        FutureBuilder(
          future: this.wallFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: widget.i == true ? 2 : 1,
                  padding: EdgeInsets.only(top: 25, bottom: 20, left: 32, right: 32),
                  itemCount: 10,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.white,
                      child: Container(
                        height: widget.i == true
                            ? random.nextInt(300).toDouble() + 150
                            : random.nextInt(200).toDouble() + 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) {
                    return new StaggeredTile.fit(1);
                  },
                ),
              );
            }

            return Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: widget.i == true ? 2 : 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.only(top: 25, bottom: 20, left: 32, right: 32),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Swaminarayan");
                      showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (_) => MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.0, size: Size(392.72, 838.90)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                GestureDetector(
                                                  onDoubleTapDown: _handleDoubleTapDown,
                                                  onDoubleTap: _handleDoubleTap,
                                                  child: InteractiveViewer(
                                                    transformationController: _transformationController,
                                                    child: CachedNetworkImage(
                                                      width: double.infinity,
                                                      imageUrl: snapshot.data[index].imgUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Wrap(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () => setWallpaperFromFile(
                                                                  snapshot.data[index].imgUrl, 1),
                                                              child: Container(
                                                                height: widget.i == true ? 50 : 38,
                                                                decoration: BoxDecoration(
                                                                  color: primaryColor.withOpacity(0.8),
                                                                  border: Border.all(color: Colors.white),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.wallpaper,
                                                                      size: widget.i == true ? 35 : 28,
                                                                      color: Colors.white,
                                                                    ),
                                                                    Text(
                                                                      "Set As\nWallpaper",
                                                                      textAlign: TextAlign.center,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: "baloobhai",
                                                                        height: 1,
                                                                        fontSize: widget.i == true ? 18 : 16,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                downloadImage(snapshot.data[index].imgUrl);
                                                              },
                                                              child: Container(
                                                                height: widget.i == true ? 50 : 38,
                                                                decoration: BoxDecoration(
                                                                  color: primaryColor.withOpacity(0.8),
                                                                  border: Border.all(color: Colors.white),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.download_outlined,
                                                                      size: widget.i == true ? 35 : 28,
                                                                      color: Colors.white,
                                                                    ),
                                                                    Text(
                                                                      "Download",
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: "baloobhai",
                                                                        fontSize: widget.i == true ? 18 : 16,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InteractiveViewer(
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data[index].imgUrl.toString(),
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
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        //   ..translate(-position.dx * 2, -position.dy * 2)
        //   ..scale(3.0);
        // Fox a 2x zoom
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }
}

class WallModel {
  String imgUrl;

  WallModel(this.imgUrl);
}

Future<void> downloadImage(String url) async {
  Dio dio = Dio();

  try {
    var dir = await getExternalStorageDirectories(type: StorageDirectory.pictures);
    dio.download(url, "${dir.toSet()}/wall1.jpeg", onReceiveProgress: (rec, total) {
      print("Rec: $rec , Total: $total");
    });
  } catch (e) {
    print(e);
  }
}
