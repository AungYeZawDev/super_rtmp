import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:super_rtmp/exceptions/exception.dart';
import 'package:super_rtmp/models/android_play_manager.dart';

import 'super_rtmp_platform_interface.dart';

/// An implementation of [SuperRtmpPlatform] that uses method channels.
class MethodChannelSuperRtmp extends SuperRtmpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('super_rtmp');

  final int? viewId;
  MethodChannelSuperRtmp({this.viewId});

  String get _methodChannelName {
    return 'video-player-rtmp-ext-$viewId';
  }

 late final MethodChannel _methodChannel = MethodChannel(_methodChannelName);

  @override
  Future<void> init() async {
    final r = await _methodChannel.invokeMethod("init");
    if(r==false){
      throw InitException(r.toString());
    }
  }

  @override
  Future<void> initIJKPlayController(String url) async {
    final args = {
      "url":url
    };
    await _methodChannel.invokeMethod('init-controller',args);
  }

  @override
  Future<void> play() async {
    await  _methodChannel.invokeMethod("controller-play");
  }

  @override
  void dispose() {
    _methodChannel.invokeMethod("controller-dispose");
  }

  @override
  Future<void> pause() async {
    _methodChannel.invokeMethod("controller-pause");
  }

  @override
  Future<bool> isPlaying() async {
   return await _methodChannel.invokeMethod("controller-get-state");
  }

  @override
  Future<void> stop() async {
    await _methodChannel.invokeMethod("controller-stop");
  }

  @override
  Future<void> changeModel(PlayerFactory playerFactory) async {
    await _methodChannel.invokeMethod("android-change-mode",{"mode":playerFactory.mode});
  }


  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
