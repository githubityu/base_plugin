import 'package:base_plugin/messages.g.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:base_plugin/base_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  implements FlutterMessageApi{
  String _platformVersion = 'Unknown';
  final _basePlugin = BasePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    FlutterMessageApi.setUp(this);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await BasePlugin.flutter2Native("33344", 0) ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }

  @override
  String native2Flutter(String message, int type) {
    print("native2Flutter=$message $type");
    return "native2Flutter=$message";
  }

  @override
  Future<String> native2FlutterAsync(String message, int type) {
    print("native2FlutterAsync=$message  $type");
    return Future(() => "native2FlutterAsync=$message");
  }
}
