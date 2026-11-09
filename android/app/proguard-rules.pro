# ---------------------------------------------------------------------------
# R8 / reflection attributes (release build has minifyEnabled + shrinkResources).
# Without these, R8 strips generic signatures, annotations and inner-class
# metadata that Firebase Auth, Play Integrity, Stripe and Kotlin reflection read
# at runtime. Failures only appear in the signed release build, never in debug.
#
# Dart json_serializable / freezed / hive models are AOT-compiled Dart and are
# NOT touched by R8; the reflection-sensitive models here are the NATIVE SDK
# ones below.
# ---------------------------------------------------------------------------
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

-keep class kotlin.Metadata { *; }
-keepclassmembers class kotlin.Metadata { public <methods>; }
-keepclassmembers class **$WhenMappings { <fields>; }
-keepclassmembers class **$Companion { <methods>; }
-keepclassmembers class * {
    @androidx.annotation.Keep <fields>;
    @androidx.annotation.Keep <methods>;
}

# Flutter engine / JNI lookup + generated plugin registrant.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Play Integrity (com.google.android.play.core is NOT under gms/firebase).
-keep class com.google.android.play.core.integrity.** { *; }
-dontwarn com.google.android.play.core.integrity.**

# Flutter's engine ships FlutterPlayStoreSplitApplication and
# PlayStoreDeferredComponentManager, which reference the OLD Play Core split
# install / splitcompat APIs. This app does NOT use deferred components (no
# `deferred-components` block in pubspec.yaml, no `com.google.android.play:core`
# dependency, default ${applicationName} in the manifest), so those code paths
# are unreachable. AGP's "Missing classes detected while running R8" check still
# fails the release bundle unless we explicitly acknowledge them. These are the
# same -dontwarn entries AGP writes to missing_rules.txt; do NOT add the
# deprecated com.google.android.play:core artifact just to silence them.
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Native MethodChannel payload helpers live in the app package; keep field and
# method names so channel arguments survive obfuscation.
-keep class com.bishal.invoice.** { *; }

# Firebase rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.installations.** { *; }
-keep class com.google.firebase.iid.** { *; }

# Firebase Analytics
-keep class com.google.firebase.analytics.** { *; }

# Keep Firebase model classes
-keepclassmembers class * {
    @com.google.firebase.database.PropertyName <methods>;
    @com.google.firebase.database.PropertyName <fields>;
}

# Keep Firebase Auth
-keep class com.google.firebase.auth.** { *; }

# Stripe PaymentSheet
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
-dontwarn kotlinx.parcelize.Parceler$DefaultImpls
-dontwarn kotlinx.parcelize.Parceler
-dontwarn kotlinx.parcelize.Parcelize
-keep class com.stripe.** { *; }
