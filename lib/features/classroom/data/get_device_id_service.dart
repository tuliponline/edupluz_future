import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:edupluz_future/features/classroom/provider/device_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

getDeviceId(WidgetRef ref) async {
  String? deviceId;
  if (ref.watch(deviceIdProvider.notifier).state != null) {
    deviceId = ref.read(deviceIdProvider);
  } else {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    } else {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    }

    ref.read(deviceIdProvider.notifier).state = deviceId;
  }
  return deviceId;
}
