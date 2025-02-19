import 'package:edupluz_future/features/classroom/data/web_socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService();
});
