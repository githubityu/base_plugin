import 'package:pigeon/pigeon.dart';


// 输出配置
// 控制台执行：dart  run pigeon --input pigeons/message.dart
@ConfigurePigeon(PigeonOptions(
  dartOut: './lib/messages.g.dart',
  dartPackageName: 'base_plugin',
  kotlinOut: 'android/src/main/kotlin/com/app/base_plugin/Messages.g.kt',
  kotlinOptions: KotlinOptions(
    // copyrightHeader: ['zero'],
    package: 'com.app.base_plugin',
  ),
  swiftOut: 'ios/Runner/Messages.g.swift',
  swiftOptions: SwiftOptions(),
))
@HostApi()
abstract class HostMessageApi {
  String flutter2Native(String message, int type);

  @async
  String flutter2NativeAsync(String message, int type);
}

@FlutterApi()
abstract class FlutterMessageApi {
  String native2Flutter(String message, int type);

  @async
  String native2FlutterAsync(String message, int type);
}

