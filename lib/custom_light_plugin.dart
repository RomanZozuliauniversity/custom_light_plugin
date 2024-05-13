import 'custom_light_plugin_platform_interface.dart';

class CustomLightPlugin {
  static Future<void> toggle() => CustomLightPluginPlatform.instance.toggle();
}
