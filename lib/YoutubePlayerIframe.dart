import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerIframe extends StatefulWidget {
  @override
  _YoutubePlayerIframeState createState() => _YoutubePlayerIframeState();
}

class _YoutubePlayerIframeState extends State<YoutubePlayerIframe> {
  ScrollController _scrollController;
  String videoListUrl = "https://satsang-a-to-z-api.kalakunjmandir.in/guruji/video/";

  Future<List<VideoListModel>> getVideoList() async {
    var result = await http.get(Uri.parse(videoListUrl));
    var jsonData = json.decode(result.body);
    List<VideoListModel> videoList = [];
    for (var i in jsonData) {
      VideoListModel model =
          VideoListModel(i["id"], i["name"], i["url"], i["thumbnail"], i["is_new"], i["is_favourite"]);
      videoList.add(model);
    }
    return videoList;
  }

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "pv1YSnoijno",
    params: YoutubePlayerParams(showControls: true, strictRelatedVideos: true),
  );

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, size: Size(392.72, 838.90)),
          child: FutureBuilder(
            future: getVideoList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: Colors.grey,
                  height: 300,
                  width: double.infinity,
                );
              }

              /*return Container(
                child: CustomScrollView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  slivers: [],
                ),
              );*/
              return Container(
                child: Column(
                  children: [
                    Container(
                      height: 225,
                      width: double.infinity,
                      color: Colors.black,
                      child: YoutubePlayerIFrame(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    Expanded(
                      child: CustomScrollView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        slivers: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[1].name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[1].name,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length - 1,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 90,
                                      child: Row(
                                        children: [
                                          Image.network(
                                            snapshot.data[index + 1].thumbnail,
                                            width: 160,
                                            height: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot.data[index].name +
                                                          "Swaminarayan Hari Sahajanand",
                                                      overflow: TextOverflow.fade,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: 'baloobhai',
                                                          fontWeight: FontWeight.w600,
                                                          height: 1),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot.data[index].name + "Swaminarayan",
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 17, fontFamily: 'baloobhai', height: 1),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Visibility(
                                                        visible:
                                                            snapshot.data[index].isNew == true ? true : false,
                                                        child: Icon(
                                                          Icons.fiber_new,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      Icon(
                                                        snapshot.data[index].isNew == true
                                                            ? Icons.favorite
                                                            : Icons.favorite_border_rounded,
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class VideoListModel {
  int id;
  String name, videoUrl, thumbnail;
  bool isNew, isFav;

  VideoListModel(this.id, this.name, this.videoUrl, this.thumbnail, this.isNew, this.isFav);
}
