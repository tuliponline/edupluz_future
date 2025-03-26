import 'package:better_player_plus/better_player_plus.dart';

class PlayerDataSorce {
  String url;
  PlayerDataSorce({
    required this.url,
  });

  late BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network, url,
      videoFormat: BetterPlayerVideoFormat.other);
}
