package com.bishal.invoice

import android.content.Context
import android.content.SharedPreferences
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.WindowInsetsController
import android.view.WindowManager
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.google.firebase.FirebaseApp
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterFragmentActivity() {
    private val systemUiChannel = "com.bishal.invoice/system_ui"
    private val appCheckChannel = "com.bishal.invoice/app_check"
    private val deviceSecurityChannel = "com.bishal.invoice/device_security"
    private val debugSecretKey = "com.google.firebase.appcheck.debug.DEBUG_SECRET"
    private val debugStoreTemplate = "com.google.firebase.appcheck.debug.store.%s"

    override fun onCreate(savedInstanceState: Bundle?) {
        // FLAG_SECURE: block screenshots and screen recordings of NDIS PII.
        // Persists for the window lifetime; no per-screen handling needed.
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, systemUiChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "hideSystemUI" -> {
                    hideSystemUI()
                    result.success(null)
                }
                "showSystemUI" -> {
                    showSystemUI()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, appCheckChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstallerPackageName" -> {
                    result.success(getInstallerPackageName())
                }
                "seedDebugSecret" -> {
                    val token = call.argument<String>("token")
                    if (token.isNullOrBlank()) {
                        result.error("INVALID_ARGUMENT", "token is required", null)
                    } else {
                        seedDebugSecret(token)
                        result.success(null)
                    }
                }
                "getDebugSecret" -> {
                    result.success(getDebugSecret())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deviceSecurityChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSecurityPosture" -> {
                    result.success(getSecurityPosture())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun hideSystemUI() {
        Log.d("SystemUI", "Hiding system UI")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Use modern WindowInsetsController for API 30+
            window.insetsController?.let { controller ->
                controller.hide(WindowInsetsCompat.Type.systemBars())
                controller.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        } else {
            // Use WindowInsetsControllerCompat for older versions
            WindowCompat.setDecorFitsSystemWindows(window, false)
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.hide(WindowInsetsCompat.Type.systemBars())
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        }
    }

    private fun showSystemUI() {
        Log.d("SystemUI", "Showing system UI")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Use modern WindowInsetsController for API 30+
            window.insetsController?.show(WindowInsetsCompat.Type.systemBars())
        } else {
            // Use WindowInsetsControllerCompat for older versions
            WindowCompat.setDecorFitsSystemWindows(window, true)
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.show(WindowInsetsCompat.Type.systemBars())
        }
    }

    private fun getInstallerPackageName(): String? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                packageManager.getInstallSourceInfo(packageName).installingPackageName
            } else {
                @Suppress("DEPRECATION")
                packageManager.getInstallerPackageName(packageName)
            }
        } catch (e: Exception) {
            Log.w("AppCheck", "Unable to read installer package", e)
            null
        }
    }

    private fun debugSecretPrefs(): SharedPreferences? {
        return try {
            val persistenceKey = FirebaseApp.getInstance().persistenceKey
            getSharedPreferences(
                String.format(debugStoreTemplate, persistenceKey),
                Context.MODE_PRIVATE
            )
        } catch (e: Exception) {
            Log.w("AppCheck", "Unable to resolve App Check debug store", e)
            null
        }
    }

    private fun seedDebugSecret(token: String) {
        val prefs = debugSecretPrefs() ?: return
        prefs.edit().putString(debugSecretKey, token).apply()
        Log.d("AppCheck", "Seeded fixed debug secret")
    }

    private fun getDebugSecret(): String? {
        val prefs = debugSecretPrefs() ?: return null
        return prefs.getString(debugSecretKey, null)
    }

    /**
     * Best-effort rooted-device / emulator detection for NDIS PII protection.
     * Root checks are inherently bypassable — this raises the bar and feeds
     * the startup warning, it is not a guarantee. Returns a map consumed by
     * Dart's DeviceSecurity service.
     */
    private fun getSecurityPosture(): Map<String, Any> {
        val reasons = mutableListOf<String>()

        // su binaries in well-known locations
        val suPaths = arrayOf(
            "/system/bin/su", "/system/xbin/su", "/sbin/su",
            "/system/sd/xbin/su", "/data/local/xbin/su",
            "/data/local/bin/su", "/su/bin/su",
            "/system/bin/.ext/su", "/magisk/.core/bin/su"
        )
        if (suPaths.any { File(it).exists() }) {
            reasons.add("su_binary")
        }
        if (File("/system/app/Superuser.apk").exists()) {
            reasons.add("superuser_apk")
        }
        // Test-keys ROMs (custom/engineering builds)
        if (Build.TAGS != null && Build.TAGS.contains("test-keys")) {
            reasons.add("test_keys")
        }
        // Magisk manager app present
        try {
            @Suppress("DEPRECATION")
            packageManager.getPackageInfo("com.topjohnwu.magisk", 0)
            reasons.add("magisk_package")
        } catch (_: Exception) {
            // Not installed — expected on stock devices
        }

        // Emulator indicators (informational, not a compromise signal)
        val fingerprint = Build.FINGERPRINT ?: ""
        val model = Build.MODEL ?: ""
        val emulator = fingerprint.startsWith("generic") ||
            fingerprint.startsWith("unknown") ||
            model.contains("google_sdk") ||
            model.contains("Emulator") ||
            model.contains("Android SDK built for x86")

        val debuggable = (applicationInfo.flags and
            android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0

        return mapOf(
            "compromised" to reasons.isNotEmpty(),
            "reasons" to reasons,
            "emulator" to emulator,
            "debuggable" to debuggable
        )
    }
}
