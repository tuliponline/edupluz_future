import 'package:edupluz_future/core/services/storages/hivedb_constants.dart';
import 'package:edupluz_future/core/services/storages/login_model/login_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveInit() async {
  var hiveDbPath = await getApplicationDocumentsDirectory();
  Hive
    ..init(hiveDbPath.path)
    ..registerAdapter(LoginAdapter());
  await Hive.openBox(HiveDbConstants.appData);
}
