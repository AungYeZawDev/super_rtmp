import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_rtmp/super_rtmp_method_channel.dart';

void main() {
  MethodChannelSuperRtmp platform = MethodChannelSuperRtmp();
  const MethodChannel channel = MethodChannel('super_rtmp');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
