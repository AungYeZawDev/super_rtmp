// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/foundation.dart';
import 'package:super_rtmp/models/android_play_manager.dart';
import 'package:super_rtmp/super_rtmp_method_channel.dart';
import 'package:flutter/services.dart';
import 'super_rtmp_platform_interface.dart';

class SuperRtmp {

  final int? viewId;
  SuperRtmp({this.viewId});

 late final channel = MethodChannelSuperRtmp(viewId: viewId);
 late final eventChanel = EventChannel('video-player-rtmp-ext-event-$viewId');

 Future<void> init() async {
   try{
     await channel.init();
   }catch(e){
     if (kDebugMode) {
       print(e);
     }
   }
 }
 Future<void> initIJKPlayController(String url) async {
   await channel.initIJKPlayController(url);
 }
 Future<void> play() async {
   await channel.play();
 }
 Future<void> pause() async {
   await channel.pause();
 }
 Future<bool> isPlaying() async {
   return await channel.isPlaying();
 }
 Future<void> stop() async {
   await channel.stop();
 }
 Future<void> changeModel(PlayerFactory playerFactory) async {
   await channel.changeModel(playerFactory);
 }
 void dispose() {
   channel.dispose();
 }

  Future<String?> getPlatformVersion() {
    return SuperRtmpPlatform.instance.getPlatformVersion();
  }
}
