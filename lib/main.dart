import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shortzz/common/manager/firebase_notification_manager.dart';
import 'package:shortzz/common/manager/logger.dart';
import 'package:shortzz/common/manager/session_manager.dart';
import 'package:shortzz/common/service/subscription/subscription_manager.dart';
import 'package:shortzz/common/widget/restart_widget.dart';
import 'package:shortzz/languages/dynamic_translations.dart';
import 'package:shortzz/screen/splash_screen/splash_screen.dart';
import 'package:shortzz/utilities/theme_res.dart';
import 'firebase_options.dart';

import 'common/service/network_helper/network_helper.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Loggers.success("Handling a background message: ${message.data}");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isIOS) {
    FirebaseNotificationManager.instance.showNotification(message);
  }
}

Future<void> main() async {
  print('🚀 MAIN: Starting app initialization...');

  try {
    print('🔧 MAIN: Ensuring Flutter binding is initialized...');
    WidgetsFlutterBinding.ensureInitialized();
    print('✅ MAIN: Flutter binding initialized successfully');

    print('🔥 MAIN: Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ MAIN: Firebase initialized successfully');

    print('📱 MAIN: Registering Firebase background message handler...');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    print('✅ MAIN: Firebase background handler registered');

    print('💾 MAIN: Initializing GetStorage...');
    await GetStorage.init('shortzz');
    print('✅ MAIN: GetStorage initialized successfully');

    // Init RevenueCat (handle errors gracefully)
    print('💰 MAIN: Initializing SubscriptionManager...');
    try {
      await SubscriptionManager.shared.initPlatformState();
      print('✅ MAIN: SubscriptionManager initialized successfully');
    } catch (e, st) {
      print('❌ MAIN: SubscriptionManager init error: $e');
      Loggers.error('SubscriptionManager init error: $e\n$st');
    }

    // Init Ads (ignore async wait if needed)
    print('📺 MAIN: Initializing Mobile Ads...');
    try {
      MobileAds.instance.initialize();
      print('✅ MAIN: Mobile Ads initialized successfully');
    } catch (e, st) {
      print('❌ MAIN: Mobile Ads init error: $e');
      Loggers.error('Mobile Ads init error: $e\n$st');
    }

    // Init Branch SDK
    print('🌿 MAIN: Initializing Branch SDK...');
    try {
      await FlutterBranchSdk.init();
      print('✅ MAIN: Branch SDK initialized successfully');
    } catch (e, st) {
      print('❌ MAIN: Branch SDK init error: $e');
      Loggers.error('Branch SDK init error: $e\n$st');
    }

    print('🌐 MAIN: Initializing NetworkHelper...');
    try {
      NetworkHelper().initialize();
      print('✅ MAIN: NetworkHelper initialized successfully');
    } catch (e, st) {
      print('❌ MAIN: NetworkHelper init error: $e');
      Loggers.error('NetworkHelper init error: $e\n$st');
    }

    // Load Translations
    print('🌍 MAIN: Loading translations...');
    try {
      Get.put(DynamicTranslations());
      print('✅ MAIN: Translations loaded successfully');
    } catch (e, st) {
      print('❌ MAIN: Translations loading error: $e');
      Loggers.error('Translations loading error: $e\n$st');
    }

    // Run app
    print('🎯 MAIN: Starting app widget...');
    runApp(const RestartWidget(child: MyApp()));
    print('✅ MAIN: App widget started successfully');
  } catch (e, st) {
    print('💥 MAIN: Fatal crash during app startup: $e');
    print('📋 MAIN: Stack trace: $st');
    Loggers.error('Fatal crash during app startup: $e\n$st');

    // Try to run a minimal app to show error
    try {
      runApp(MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('App Initialization Failed',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Error: $e', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ));
    } catch (fallbackError) {
      print('💥 MAIN: Even fallback app failed: $fallbackError');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('🎨 MYAPP: Building MyApp widget...');

    try {
      print('🔍 MYAPP: Getting DynamicTranslations...');
      final translations = Get.find<DynamicTranslations>();
      print('✅ MYAPP: DynamicTranslations found successfully');

      print('👤 MYAPP: Getting user language settings...');
      final userLang = SessionManager.instance.getLang();
      final fallbackLang = SessionManager.instance.getFallbackLang();
      print(
          '✅ MYAPP: Language settings - User: $userLang, Fallback: $fallbackLang');

      print('🎨 MYAPP: Building theme...');
      final lightTheme = ThemeRes.lightTheme(context);
      final darkTheme = ThemeRes.darkTheme(context);
      print('✅ MYAPP: Themes built successfully');

      print('🏠 MYAPP: Creating GetMaterialApp...');
      return GetMaterialApp(
        builder: (context, child) {
          print('🔧 MYAPP: Builder called with child: ${child.runtimeType}');
          return ScrollConfiguration(behavior: MyBehavior(), child: child!);
        },
        onReady: () {
          print('✅ MYAPP: GetMaterialApp is ready!');
          // InternetConnectionManager.instance.listenNoInternetConnection();
        },
        translations: translations,
        locale: Locale(userLang),
        fallbackLocale: Locale(fallbackLang),
        themeMode: ThemeMode.light,
        darkTheme: darkTheme,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      );
    } catch (e, st) {
      print('❌ MYAPP: Error building MyApp: $e');
      print('📋 MYAPP: Stack trace: $st');

      // Return a simple error screen
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('MyApp Build Failed',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Error: $e', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
