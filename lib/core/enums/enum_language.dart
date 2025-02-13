enum LanguageEnum {
  th,
  en,
  ;

  String get name {
    return toString().split('.').last;
  }
}
