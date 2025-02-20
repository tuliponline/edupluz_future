enum DiscoverFilter {
  all,
  popular,
  newest;

  String get name => toString().split('.').last;
}
