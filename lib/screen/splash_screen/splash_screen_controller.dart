import 'dart:async';
import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shortzz/common/controller/base_controller.dart';
import 'package:shortzz/common/controller/firebase_firestore_controller.dart';
import 'package:shortzz/common/extensions/string_extension.dart';
import 'package:shortzz/common/manager/logger.dart';
import 'package:shortzz/common/manager/session_manager.dart';
import 'package:shortzz/common/service/api/common_service.dart';
import 'package:shortzz/common/service/api/user_service.dart';
import 'package:shortzz/common/service/network_helper/network_helper.dart';
import 'package:shortzz/common/widget/no_internet_sheet.dart';
import 'package:shortzz/common/widget/restart_widget.dart';
import 'package:shortzz/languages/dynamic_translations.dart';
import 'package:shortzz/model/general/settings_model.dart';
import 'package:shortzz/screen/auth_screen/login_screen.dart';
import 'package:shortzz/screen/dashboard_screen/dashboard_screen.dart';
import 'package:shortzz/screen/gif_sheet/gif_sheet_controller.dart';
import 'package:shortzz/screen/select_language_screen/select_language_screen.dart';

class SplashScreenController extends BaseController {
  late StreamSubscription _subscription;
  bool isOnline = true;

  @override
  void onReady() {
    print('🎮 SPLASH_CTRL: SplashScreenController onReady called');
    super.onReady();

    try {
      print('🎮 SPLASH_CTRL: Creating GifSheetController...');
      Get.put(GifSheetController());
      print('✅ SPLASH_CTRL: GifSheetController created successfully');

      print('🔥 SPLASH_CTRL: Creating FirebaseFirestoreController...');
      Get.put(FirebaseFirestoreController());
      print('✅ SPLASH_CTRL: FirebaseFirestoreController created successfully');

      print('⚙️ SPLASH_CTRL: Starting fetchSettings...');
      Future.wait([fetchSettings()]);
      print('✅ SPLASH_CTRL: fetchSettings started successfully');

      print('🌐 SPLASH_CTRL: Setting up network connection listener...');
      _subscription = NetworkHelper().onConnectionChange.listen((status) {
        print('🌐 SPLASH_CTRL: Network status changed: $status');
        isOnline = status;
        if (isOnline) {
          print('✅ SPLASH_CTRL: Back online, closing no internet sheet');
          Get.back();
        } else {
          print('❌ SPLASH_CTRL: Offline, showing no internet sheet');
          Get.to(() => const NoInternetSheet(),
              transition: Transition.downToUp);
        }
      });
      print('✅ SPLASH_CTRL: Network listener setup complete');
    } catch (e, st) {
      print('❌ SPLASH_CTRL: Error in onReady: $e');
      print('📋 SPLASH_CTRL: Stack trace: $st');
    }
  }

  @override
  void onClose() {
    super.onClose();
    _subscription.cancel();
  }

  Future<void> fetchSettings() async {
    print('⚙️ FETCH_SETTINGS: Starting fetchSettings...');

    try {
      print('⏱️ FETCH_SETTINGS: Waiting 500ms...');
      await Future.delayed(const Duration(milliseconds: 500));
      print('✅ FETCH_SETTINGS: Delay completed');

      print('🌐 FETCH_SETTINGS: Fetching global settings...');
      bool showNavigate = await CommonService.instance.fetchGlobalSettings();
      print(
          '✅ FETCH_SETTINGS: Global settings fetched, showNavigate: $showNavigate');

      if (showNavigate) {
        print('🔍 FETCH_SETTINGS: Getting DynamicTranslations...');
        final translations = Get.find<DynamicTranslations>();
        print('✅ FETCH_SETTINGS: DynamicTranslations found');

        print('🌍 FETCH_SETTINGS: Getting languages from settings...');
        var languages = SessionManager.instance.getSettings()?.languages ?? [];
        print('✅ FETCH_SETTINGS: Found ${languages.length} languages');

        List<Language> downloadLanguages =
            languages.where((element) => element.status == 1).toList();
        print(
            '✅ FETCH_SETTINGS: ${downloadLanguages.length} languages to download');

        print('📥 FETCH_SETTINGS: Downloading and parsing languages...');
        var downloadedFiles =
            await downloadAndParseLanguages(downloadLanguages);
        print('✅ FETCH_SETTINGS: Languages downloaded and parsed');

        print('🔄 FETCH_SETTINGS: Adding translations...');
        translations.addTranslations(downloadedFiles);
        print('✅ FETCH_SETTINGS: Translations added');

        print('🔍 FETCH_SETTINGS: Finding default language...');
        var defaultLang =
            languages.firstWhereOrNull((element) => element.isDefault == 1);

        if (defaultLang != null) {
          print(
              '✅ FETCH_SETTINGS: Setting fallback language: ${defaultLang.code}');
          SessionManager.instance.setFallbackLang(defaultLang.code ?? 'en');
        } else {
          print('⚠️ FETCH_SETTINGS: No default language found');
        }

        print('🔄 FETCH_SETTINGS: Restarting app...');
        RestartWidget.restartApp(Get.context!);

        print('👤 FETCH_SETTINGS: Checking login status...');
        if (SessionManager.instance.isLogin()) {
          print(
              '✅ FETCH_SETTINGS: User is logged in, fetching user details...');
          UserService.instance
              .fetchUserDetails(userId: SessionManager.instance.getUserID())
              .then((value) {
            if (value != null) {
              print(
                  '✅ FETCH_SETTINGS: User details found, navigating to dashboard');
              Get.off(() => DashboardScreen(myUser: value));
            } else {
              print(
                  '❌ FETCH_SETTINGS: User details not found, navigating to login');
              Get.off(() => const LoginScreen());
            }
          });
        } else {
          print(
              '❌ FETCH_SETTINGS: User not logged in, navigating to language selection');
          Get.off(() => const SelectLanguageScreen(
              languageNavigationType: LanguageNavigationType.fromStart));
        }
      } else {
        print('❌ FETCH_SETTINGS: showNavigate is false, not proceeding');
      }
    } catch (e, st) {
      print('❌ FETCH_SETTINGS: Error in fetchSettings: $e');
      print('📋 FETCH_SETTINGS: Stack trace: $st');
    }
  }

  Future<Map<String, Map<String, String>>> downloadAndParseLanguages(
      List<Language> languages) async {
    const int maxConcurrentDownloads = 3; // Limit concurrent downloads
    final Set<Future<void>> activeDownloads = {}; // Track active downloads
    final languageData = <String, Map<String, String>>{};

    for (var language in languages) {
      if (language.code != null && language.csvFile != null) {
        // Start the download and add it to the active set
        final downloadTask = downloadAndProcessLanguage(language, languageData);
        activeDownloads.add(downloadTask);

        // Limit concurrency
        if (activeDownloads.length >= maxConcurrentDownloads) {
          // Wait for any download to complete
          await Future.any(activeDownloads);

          // Remove completed tasks from the set
          activeDownloads
              .removeWhere((task) => task == Future.any(activeDownloads));
        }
      }
    }

    // Wait for all remaining downloads to complete
    await Future.wait(activeDownloads);

    return languageData;
  }

  Future<void> downloadAndProcessLanguage(
      Language language, Map<String, Map<String, String>> languageData) async {
    try {
      final response =
          await http.get(Uri.parse(language.csvFile?.addBaseURL() ?? ''));
      if (response.statusCode == 200) {
        final csvContent = utf8.decode(response.bodyBytes);
        // Parse the CSV into a map
        final parsedMap = _parseCsvToMap(csvContent);
        languageData[language.code!] = parsedMap;

        Loggers.info('Downloaded and parsed: ${language.code}');
      } else {
        Loggers.error(
            'Failed to download ${language.code}: ${response.statusCode}');
      }
    } catch (e) {
      Loggers.error('Error downloading ${language.code}: $e');
    }
  }

  Map<String, String> _parseCsvToMap(String csvContent) {
    final rows = const CsvToListConverter().convert(csvContent);
    final map = <String, String>{};

    for (var row in rows) {
      if (row.length >= 2) {
        map[row[0].toString()] = row[1].toString();
      }
    }
    return map;
  }
}
