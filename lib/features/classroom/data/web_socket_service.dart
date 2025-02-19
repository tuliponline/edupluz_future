import 'dart:convert';

import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:edupluz_future/features/classroom/domain/metric_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  // bool isClose = false;
  // final _channel = IOWebSocketChannel.connect(
  //     "${dotenv.get(AppEnv.webSocketBasePath)}/edupluz/course/v1/courses/progress");

  void sendProgress(MetricModel progress) {
    // if (!isClose) {
    //   try {
    //     _channel.sink.add(jsonEncode(progress));
    //   } catch (e) {
    //     Logger().e("WebSocketService sendProgress Error: $e");
    //   }
    // } else {
    //   Logger().d("WebSocketService isClose: $isClose");
    // }
  }

  void dispose() {
    // isClose = true;
    // _channel.sink.close();
  }
}
