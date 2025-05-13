package com.example.yandex_map

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MapKitFactory.setLocale("ru_RU") // или "en_US", если английский
        MapKitFactory.setApiKey("2aebb2e1-6862-44d8-90e6-c4d9ae677400")
    }
}
