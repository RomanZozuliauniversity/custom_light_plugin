import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_light_plugin_platform_interface.dart';

/// An implementation of [CustomLightPluginPlatform] that uses method channels.
class MethodChannelCustomLightPlugin extends CustomLightPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_light_plugin');

  @override
  Future<void> toggle() async {
    try {
      await methodChannel.invokeMethod('toggle_lights');
    } on PlatformException catch (e) {
      print("Failed to toggle lights: '${e.message}'.");
    }
  }
}
