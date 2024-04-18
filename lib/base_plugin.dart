import 'messages.g.dart';

class BasePlugin {
  static final HostMessageApi _api = HostMessageApi();
  static Future<String>  flutter2Native(String message, int type) async {
    return await _api.flutter2Native(message, type);
  }
  static Future<String>  flutter2NativeAsync(String message, int type) async {
    return await _api.flutter2NativeAsync(message, type);
  }
}