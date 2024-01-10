package com.example.minute_player

import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL: String = "samples.flutter.dev/battery" ;
//
//
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel(call.argument("args") ?: "default")

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
//
    private fun getBatteryLevel( args:String): Int {
        if(args == "toast"){
            Toast.makeText(this,"hello from arg call ",Toast.LENGTH_LONG).show();


        } else{
            Toast.makeText(this,"hello without arg call ",Toast.LENGTH_LONG).show();

        }
        print(args)



        return 100
    }

}


