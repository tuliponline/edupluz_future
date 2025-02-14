// import 'dart:io';

// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:logger/logger.dart';

// class InternetCheckService {
//   static Future<bool> isConnected() async {
//     try {
//       bool result = await InternetConnectionChecker().hasConnection;
//       if (result == true) {
//         Logger().d("Internet Connected");
//         return true;
//       } else {
//         Logger().e('No internet :( Reason:');
//         return false;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
// }
