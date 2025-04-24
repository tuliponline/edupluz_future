import 'dart:io';

import 'package:edupluz_future/core/providers/firebase/card_landscape_detail_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class RemoteConfigService {
  final _logger = Logger();

  Future<bool> isMaintenance() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    try {
      await remoteConfig.fetchAndActivate();
      bool isMaintenance = remoteConfig.getBool('is_maintenance');
      _logger.d("isMaintenance in remote configs $isMaintenance");
      return isMaintenance;
    } catch (exception) {
      _logger.e(" Failed to fetch remote config. $exception");
      return false;
    }
  }

  Future<String> romoteVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    // bool isProd = remoteConfig.getBool('isProd');
    String removeVersion = "0.0.0";
    try {
      await remoteConfig.fetchAndActivate();
      if (Platform.isAndroid) {
        removeVersion = remoteConfig.getString('android_version');
      } else if (Platform.isIOS) {
        removeVersion = remoteConfig.getString('ios_version');
      }
      Logger().d("removeVersion in remote config $removeVersion");
      return removeVersion;
    } catch (exception) {
      Logger().e(" Failed to fetch remote config. $exception");
      return removeVersion;
    }
  }

  Future<bool> isShowPatchDialog() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    try {
      await remoteConfig.fetchAndActivate();
      bool isShowUpdatePatchDialog =
          remoteConfig.getBool('is_show_patch_dialog');
      Logger().d("isShowPatchDialog in remote config $isShowUpdatePatchDialog");
      return isShowUpdatePatchDialog;
    } catch (exception) {
      Logger().e(" Failed to fetch isPatchDialog remote config. $exception");
      return false;
    }
  }

  Future<bool> cardLandscapeDetail(WidgetRef ref) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    try {
      await remoteConfig.fetchAndActivate();
      bool isShowCardLandscapeDetail =
          remoteConfig.getBool('card_landscape_detail');
      ref.read(cardLandscapeDetailProvider.notifier).state =
          isShowCardLandscapeDetail;
      return isShowCardLandscapeDetail;
    } catch (exception) {
      Logger()
          .e(" Failed to fetch cardLandscapeDetail remote config. $exception");
      return false;
    }
  }

  Future<bool> openBizCourses() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    try {
      await remoteConfig.fetchAndActivate();
      bool isOpenBiz = remoteConfig.getBool('open_biz');
      return isOpenBiz;
    } catch (exception) {
      Logger().e(" Failed to fetch openBiz remote config. $exception");
      return false;
    }
  }
}
