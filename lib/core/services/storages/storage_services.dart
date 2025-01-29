import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'hivedb_constants.dart';

class StorageServices {
  static Future<bool> isOpenFirstTime() async {
    var appDataDb = await Hive.openBox(HiveDbConstants.appData);
    try {
      bool? isfirsttime = await appDataDb.get(HiveDbConstants.openAppFirstTime);
      return isfirsttime ?? true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  static Future<void> setOpenAppFirstTime(bool value) async {
    var appDataDb = await Hive.openBox(HiveDbConstants.appData);
    try {
      await appDataDb.put(HiveDbConstants.openAppFirstTime, value);
    } catch (e) {
      Logger().e(e);
    }
  }

  //delete openAppFirstTime
  static Future<void> deleteOpenAppFirstTime() async {
    var appDataDb = await Hive.openBox(HiveDbConstants.appData);
    try {
      await appDataDb.delete(HiveDbConstants.openAppFirstTime);
    } catch (e) {
      Logger().e(e);
    }
  }

  static Future<bool> hasQusetions() async {
    var appDataDb = await Hive.openBox(HiveDbConstants.appData);
    try {
      Logger().d('Checking if hasQuestions is true');
      bool? isfirsttime = await appDataDb.get(HiveDbConstants.hasQusetion);
      Logger().d('hasQuestions value: $isfirsttime');
      return isfirsttime ?? false;
    } catch (e) {
      Logger().e('Error checking hasQuestions: $e');
      return false;
    }
  }

  static Future<void> setHasQusetions() async {
    var appDataDb = await Hive.openBox(HiveDbConstants.appData);
    try {
      Logger().d('Setting hasQuestions to true');
      await appDataDb.put(HiveDbConstants.hasQusetion, true);
      Logger().d('Successfully set hasQuestions to true');
    } catch (e) {
      Logger().e(
        'Error setting hasQuestions to true: $e',
      );
    }
  }
}
