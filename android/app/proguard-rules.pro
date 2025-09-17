# Add project specific ProGuard rules here.
# By default, the flags in "proguard-android.txt" from the SDK are used.
# You can remove the junk code from your app by uncommenting this and adding your own rules.

# For sqflite
-keep class io.flutter.plugins.sqflite.* { *; }
-keep class com.tekartik.sqflite.* { *; }
-keep class com.tekartik.sqflite_common.* { *; }
-keep class com.tekartik.sqflite_ffi.* { *; }

# For path_provider (often used with sqflite)
-keep class io.flutter.plugins.pathprovider.* { *; }

# For any other plugins that might be affected by R8/ProGuard
# -keep class com.your.package.name.** { *; }