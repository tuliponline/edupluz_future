import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class CerService {
  Future<void> saveCertificate(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/certificate.jpg';
    final file = File(path);
    await file.writeAsBytes(data);
    final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(data),
        quality: 60,
        name: "certificate.jpg");
    Logger().d(result);
    if (result == null) {
      EasyLoading.showError("ดาวน์โหลดไม่สําเร็จ");
    } else {
      EasyLoading.showSuccess("ดาวน์โหลดสําเร็จ");
    }
  }
}
