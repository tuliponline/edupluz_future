import 'package:firebase_remote_config/firebase_remote_config.dart';
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
}
