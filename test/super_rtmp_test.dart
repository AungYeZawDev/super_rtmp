import 'package:flutter_test/flutter_test.dart';
import 'package:super_rtmp/models/android_play_manager.dart';
import 'package:super_rtmp/super_rtmp.dart';
import 'package:super_rtmp/super_rtmp_platform_interface.dart';
import 'package:super_rtmp/super_rtmp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSuperRtmpPlatform
    with MockPlatformInterfaceMixin
    implements SuperRtmpPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> changeModel(PlayerFactory playerFactory) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Future init() {
    throw UnimplementedError();
  }

  @override
  Future<void> initIJKPlayController(String url) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isPlaying() {
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    throw UnimplementedError();
  }
}

void main() {
  final SuperRtmpPlatform initialPlatform = SuperRtmpPlatform.instance;

  test('$MethodChannelSuperRtmp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSuperRtmp>());
  });

  test('getPlatformVersion', () async {
    SuperRtmp superRtmpPlugin = SuperRtmp();
    MockSuperRtmpPlatform fakePlatform = MockSuperRtmpPlatform();
    SuperRtmpPlatform.instance = fakePlatform;

    expect(await superRtmpPlugin.getPlatformVersion(), '42');
  });
}
