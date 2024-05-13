import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_light_plugin_method_channel.dart';

abstract class CustomLightPluginPlatform extends PlatformInterface {
  /// Constructs a CustomLightPluginPlatform.
  CustomLightPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomLightPluginPlatform _instance = MethodChannelCustomLightPlugin();

  /// The default instance of [CustomLightPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomLightPlugin].
  static CustomLightPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomLightPluginPlatform] when
  /// they register themselves.
  static set instance(CustomLightPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> toggle() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
