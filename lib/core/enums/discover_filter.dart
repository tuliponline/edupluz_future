enum DiscoverFilter {
  all,
  popular,
  newest,
  free;

  String get name => toString().split('.').last;
}
