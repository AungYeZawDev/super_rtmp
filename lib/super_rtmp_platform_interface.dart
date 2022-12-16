import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:super_rtmp/models/android_play_manager.dart';

import 'super_rtmp_method_channel.dart';

abstract class SuperRtmpPlatform extends PlatformInterface {
  /// Constructs a SuperRtmpPlatform.
  SuperRtmpPlatform() : super(token: _token);

  static final Object _token = Object();

  
  Future<dynamic> init();
  Future<void> initIJKPlayController(String url);
  Future<void> play();
  void dispose();
  Future<void> pause();
  Future<bool> isPlaying();
  Future<void> stop();
  Future<void> changeModel(PlayerFactory playerFactory);



  static SuperRtmpPlatform _instance = MethodChannelSuperRtmp();

  /// The default instance of [SuperRtmpPlatform] to use.
  ///
  /// Defaults to [MethodChannelSuperRtmp].
  static SuperRtmpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SuperRtmpPlatform] when
  /// they register themselves.
  static set instance(SuperRtmpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
