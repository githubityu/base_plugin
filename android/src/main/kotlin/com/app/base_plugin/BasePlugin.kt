package com.app.base_plugin

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import greeting.Greeting
import greeting.WalletResponse
import org.json.JSONObject

fun WalletResponse.toJSONObject(): JSONObject {
    val jsonObject = JSONObject()
    jsonObject.put("address", address)
    jsonObject.put("mnemonic", mnemonic)
    jsonObject.put("privateKey", privateKey)
    jsonObject.put("publicKey", publicKey)
    jsonObject.put("keystore", keystore)
    return jsonObject
}

/** BasePlugin */
class BasePlugin : FlutterPlugin, HostMessageApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var flutterMessageApi: FlutterMessageApi
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        print("onAttachedToEngine")
        HostMessageApi.setUp(flutterPluginBinding.binaryMessenger, this)
        flutterMessageApi = FlutterMessageApi(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        HostMessageApi.setUp(binding.binaryMessenger, null)
    }

    override fun flutter2Native(message: String, type: Long): String {
        print("flutter2Native=message=start=>$message=type=$type")
        flutterMessageApi.native2Flutter("input params=>2222", callback = {
            print("response=>${it.getOrNull()}")
        }, typeArg = 1)
        when (type) {
            1L -> {
                val wallet = Greeting.createWalletF1("111111")
                return wallet.toJSONObject().toString()
            }
            2L -> {
                return Greeting.sayHi("flutter2Native=message=$message=type=$type")
            }

            else -> {
                return "flutter2Native=message=$message=type=$type"
            }
        }
    }

    override fun flutter2NativeAsync(
        message: String,
        type: Long,
        callback: (Result<String>) -> Unit
    ) {
        fun d(e: Result<String>) {
            print("d")
        }
        print("flutter2NativeAsync=message=$message=type=$type")
        flutterMessageApi.native2FlutterAsync("2222", callback = {
            print("222")
        }, typeArg = 2)
        callback(Result.success("flutter2NativeAsync=message=$message=type=$type"));
    }
}
