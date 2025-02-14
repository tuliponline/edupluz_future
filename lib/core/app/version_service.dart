import 'dart:async';
import 'dart:math';

import 'package:edupluz_future/core/providers/app/app_version_provider.dart';
import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  Future<String> currentAppVersion({required WidgetRef ref}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appVersion = packageInfo.version;
    ref.read(appVersionProvider.notifier).state = appVersion;
    Logger().d("appVersion: $appVersion");
    return appVersion;
  }

  Future<String> ronoteAppVersion() async {
    String remoteVersion = await RemoteConfigService().romoteVersion();
    Logger().d("remoteVersion: $remoteVersion");
    return remoteVersion;
  }

  Future<VersionStatus> compareVersions({required WidgetRef ref}) async {
    String appVersion = await currentAppVersion(ref: ref);
    String remoteConfigVersion = await ronoteAppVersion();

    final appVersionParts = appVersion.split('.').map(int.parse).toList();
    final remoteConfigVersionParts =
        remoteConfigVersion.split('.').map(int.parse).toList();
    for (int i = 0;
        i < min(appVersionParts.length, remoteConfigVersionParts.length);
        i++) {
      if (appVersionParts[i] < remoteConfigVersionParts[i]) {
        return VersionStatus.lower;
      } else if (appVersionParts[i] > remoteConfigVersionParts[i]) {
        return VersionStatus.higher;
      }
    }
    if (appVersionParts.length < remoteConfigVersionParts.length) {
      return VersionStatus.lower;
    } else if (appVersionParts.length > remoteConfigVersionParts.length) {
      return VersionStatus.higher;
    }
    return VersionStatus.equal;
  }
}

enum VersionStatus {
  lower,
  equal,
  higher,
}
