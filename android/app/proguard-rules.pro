-keep class kotlin.Metadata { *; }

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