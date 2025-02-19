import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';

class PlayerDataSorce {
  String url;
  PlayerDataSorce({
    required this.url,
  });

  bool isIos = Platform.isIOS;

  late BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network, url,
      videoFormat: BetterPlayerVideoFormat.hls);
}
