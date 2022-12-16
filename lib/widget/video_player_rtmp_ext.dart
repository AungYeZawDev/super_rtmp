

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:super_rtmp/super_rtmp.dart';

import '../models/android_play_manager.dart';

const uikitviewId = 'video-player-rtmp-widget-ios';
const androidViewId = 'video-player-rtmp-widget-android';


typedef ViewCreated = void Function(IJKPlayerController controller);

typedef CallUI = void Function();

class VideoPlayerRtmpExtWidget extends StatefulWidget {
  final IJKPlayerController controller;
  final Widget? initWidget;
  final ViewCreated? viewCreated;
  const VideoPlayerRtmpExtWidget({Key? key, this.initWidget, this.viewCreated, required this.controller}) : super(key: key);


  @override
  State<VideoPlayerRtmpExtWidget> createState() => _VideoPlayerRtmpExtWidgetState();
}

class _VideoPlayerRtmpExtWidgetState extends State<VideoPlayerRtmpExtWidget> {

  late SuperRtmp _platformController;
  IJKPlayerController get controller => widget.controller;



  @override
  void initState() {
    _bindController();
    super.initState();
  }


  @override
  void didUpdateWidget(covariant VideoPlayerRtmpExtWidget oldWidget) {
    if(widget.controller != oldWidget.controller){
      _bindController();
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return coreWidget;
  }

  Widget get coreWidget{
    if(Platform.isAndroid){
      return _buildAndroidWidget;
    }else if(Platform.isIOS){
      return _buildIosWidget;
    }
    return const Text('This platform is not supported');
  }
  Widget get _buildIosWidget {
    if (kDebugMode) {
      print('构建iOS视图中....');
    }
    return UiKitView(viewType: uikitviewId,onPlatformViewCreated: _platformSetup);
  }
  Widget get _buildAndroidWidget {
    return AndroidView(viewType:androidViewId,onPlatformViewCreated: _platformSetup);
  }
  Future<void> _platformSetup(int id) async {
    _platformController = SuperRtmp(viewId: id);
    await _init();
    widget.viewCreated?.call(widget.controller);
  }
  Future<void> _init() async {
   await _platformController.init();
   if(controller.playUrl!=null){
     await _platformController.initIJKPlayController(controller.playUrl!);
   }
  }
  void _bindController(){
    widget.controller._bindState(this);
  }
  Future<void> play() async {
   await _platformController.play();
  }

  @override
  void dispose() {
    _platformController.dispose();
    super.dispose();
  }
}
class IJKPlayerController {
  String? playUrl;

  IJKPlayerController({this.playUrl});

  // ignore: library_private_types_in_public_api
  late _VideoPlayerRtmpExtWidgetState state;
  void _bindState(_VideoPlayerRtmpExtWidgetState viewState) {
    state = viewState;
  }
  factory IJKPlayerController.network(String url) {
    return IJKPlayerController(playUrl: url);
  }
  Future<void> pause() async {
    await state._platformController.pause();
  }
  Future<void> play() async {
    await state.play();
  }
  Future<void> stop() async {
    await state._platformController.stop();
  }
  Future<bool> get isPlaying async =>  await state._platformController.isPlaying();
  Future<void> setPlayManager(PlayerFactory playerFactory) async {
    await state._platformController.changeModel(playerFactory);
  }

  bool get isAndroid => Platform.isAndroid;

}