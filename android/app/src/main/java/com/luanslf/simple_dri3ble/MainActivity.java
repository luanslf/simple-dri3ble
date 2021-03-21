package com.luanslf.simple_dri3ble;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import androidx.annotation.NonNull;

import android.content.SharedPreferences;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "storage";
    private final String preferencesKey = "preferences";
    MethodChannel channel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        channel.setMethodCallHandler((call,  result) -> {
            if (call.method.equals("delete")) {
                String key = call.argument("key");
                SharedPreferences preferences = getSharedPreferences(preferencesKey, MODE_PRIVATE);
                SharedPreferences.Editor editor = preferences.edit();
                editor.remove(key);
                result.success(editor.commit());
            } else if (call.method.equals("put")) {
                String key = call.argument("key");
                String value = call.argument("value");
                SharedPreferences preferences = getSharedPreferences(preferencesKey, MODE_PRIVATE);
                SharedPreferences.Editor editor = preferences.edit();
                editor.putString(key, value);
                result.success(editor.commit());
            } else if (call.method.equals("get")) {
                String key = call.argument("key");
                SharedPreferences preferences = getSharedPreferences(preferencesKey, MODE_PRIVATE);
                String data = preferences.getString(key, "");
                result.success(data);
            } else if (call.method.equals("clear")) {
                SharedPreferences preferences = getSharedPreferences(preferencesKey, MODE_PRIVATE);
                SharedPreferences.Editor editor = preferences.edit();
                editor.clear();
                result.success(editor.commit());
            } else {
                result.notImplemented();
            }
        });
    }
}
