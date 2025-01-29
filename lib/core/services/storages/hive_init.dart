import 'package:edupluz_future/core/services/storages/hivedb_constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveInit() async {
  var hiveDbPath = await getApplicationDocumentsDirectory();
  Hive.init(hiveDbPath.path);
  await Hive.openBox(HiveDbConstants.appData);
}
