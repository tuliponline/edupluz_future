import 'package:logger/logger.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class ShorebirdService {
  Logger logger = Logger();
  final updater = ShorebirdUpdater();
  Future<int?> checkPatchVersion() async {
    try {
      return updater.readCurrentPatch().then((currentPatch) {
        logger.i('The current patch number is: ${currentPatch?.number}');
        return currentPatch?.number;
      });
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<ShorebirdUpdater?> checkForUpdates() async {
    // Check whether a new update is available.
    final status = await updater.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      try {
        // Perform the update
        // await updater.update();

        return updater;
      } on UpdateException catch (error) {
        logger.e(error);
        return null;
      }
    } else {
      return null;
    }
  }
}
