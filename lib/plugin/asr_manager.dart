import 'package:flutter/services.dart';

class AsrManager {
  static const MethodChannel _channel = const MethodChannel('asr_plugin');

  //开始录音
  static Future<String> start({required Map params}) async {
    return await _channel.invokeMethod('start', params ?? {});
  }
  //开始录音
  static Future<String> stop({required Map params}) async {
    return await _channel.invokeMethod('stop', params ?? {});
  }
  //开始录音
  static Future<String> cancel({required Map params}) async {
    return await _channel.invokeMethod('cancel', params ?? {});
  }
}
