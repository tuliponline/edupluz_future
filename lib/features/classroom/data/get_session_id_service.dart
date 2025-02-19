import 'package:edupluz_future/features/classroom/provider/session_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

getSessionId(WidgetRef ref) async {
  String? sessionId;
  if (ref.watch(sessionIdProvider.notifier).state != null) {
    sessionId = ref.read(sessionIdProvider);
  } else {
    sessionId = const Uuid().v1();
    ref.read(sessionIdProvider.notifier).state = sessionId;
  }

  return sessionId;
}
