package com.example.custom_light_plugin

import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.engine.plugins.FlutterPlugin

private const val TOGGLE_EVENT_NAME = "toggle_lights"

/** CustomLightPlugin */
class CustomLightPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var isFlashOn = false

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "custom_light_plugin")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == TOGGLE_EVENT_NAME) {
            toggleFlashlight(result)
        } else {
            result.notImplemented()
        }
    }

    private fun toggleFlashlight(result: Result) {
        try {
            val cameraManager = applicationContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
            val cameraId = cameraManager.cameraIdList[0]
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)

            val flashAvailable = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE) ?: false

            if (flashAvailable) {
                isFlashOn = !isFlashOn
                cameraManager.setTorchMode(cameraId, isFlashOn)
                result.success("Flashlight toggled successfully")
            } else {
                result.error("NO_FLASH_AVAILABLE", "Flashlight is not available on this device", null)
            }
        } catch (e: CameraAccessException) {
            result.error("CAMERA_ACCESS_EXCEPTION", e.message, null)
        } catch (e: Exception) {
            result.error("TOGGLE_FAILED", e.message, null)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
