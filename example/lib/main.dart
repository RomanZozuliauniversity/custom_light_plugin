import 'package:flutter/material.dart';
import 'package:custom_light_plugin/custom_light_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: ElevatedButton(
            onPressed: CustomLightPlugin.toggle,
            child: Text('Toggle light'),
          ),
        ),
      ),
    );
  }
}
