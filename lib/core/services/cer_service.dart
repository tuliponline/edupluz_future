import 'dart:async';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class CerService {
  Future<void> saveCertificate(Uint8List data) async {
    try {
      final result = await ImageGallerySaverPlus.saveImage(data,
          quality: 100,
          name: "certificate_${DateTime.now().millisecondsSinceEpoch}");

      if (result['isSuccess']) {
        Logger().d("Certificate saved to gallery successfully");
      } else {
        throw Exception('Failed to save to gallery');
      }
    } catch (e) {
      Logger().e(e);
      throw Exception('Failed to save certificate');
    }
  }
}
