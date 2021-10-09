import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerFlutter extends StatefulWidget {
  @override
  _YoutubePlayerFlutterState createState() => _YoutubePlayerFlutterState();
}

class _YoutubePlayerFlutterState extends State<YoutubePlayerFlutter> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'pv1YSnoijno',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
      forceHD: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
        ),
        onReady: () {
          _controller.addListener(() {});
        },
      ),
    );
  }
}
