package com.mathsquirrels.outoftheloop

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Keep secret cards out of Android's task preview and screen captures.
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
