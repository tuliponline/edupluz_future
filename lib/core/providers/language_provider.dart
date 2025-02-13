import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/enum_language.dart';

final languageProvider = StateProvider<LanguageEnum>((ref) {
  return LanguageEnum.th;
});
