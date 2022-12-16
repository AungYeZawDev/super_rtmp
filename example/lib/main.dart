import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:super_rtmp/models/android_play_manager.dart';
import 'package:super_rtmp/super_rtmp.dart';
import 'package:super_rtmp/widget/video_player_rtmp_ext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _superRtmpPlugin = SuperRtmp();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _superRtmpPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  static const line = 'rtmp://mobliestream.c3tv.com:554/live/goodtv.sdp';

  final IJKPlayerController controller = IJKPlayerController.network(line);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("live broadcase")),
      body: AspectRatio(
        aspectRatio: width / height,
        child: VideoPlayerRtmpExtWidget(
          controller: controller,
          viewCreated: (IJKPlayerController _) async {
            if (controller.isAndroid) {
              await controller.setPlayManager(PlayerFactory.exo2PlayerManager);
            }

            await controller.play();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint(_platformVersion),
        child: const Icon(Icons.add),
      ),
    ));
  }
}
