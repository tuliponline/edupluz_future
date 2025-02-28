import 'package:edupluz_future/routes/router.dart';
import 'package:flutter_alice_http/alice.dart';

final navigatorKey = NavigationService.navigatorKey;
final Alice alice = Alice(
  navigatorKey: navigatorKey,
  showNotification: true,
  showInspectorOnShake: true,
  darkTheme: true,
);
