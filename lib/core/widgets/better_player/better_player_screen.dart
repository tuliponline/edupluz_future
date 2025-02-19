import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/widgets/better_player/better_player_config.dart';
import 'package:edupluz_future/core/widgets/better_player/better_player_data_source.dart';
import 'package:flutter/material.dart';

class BetterPlayerScreen extends StatefulWidget {
  final String url;

  final Function(BetterPlayerController)? betterPlayerController;
  const BetterPlayerScreen(
      {super.key, required this.url, this.betterPlayerController});

  @override
  State<BetterPlayerScreen> createState() => _BetterPlayerScreenState();
}

class _BetterPlayerScreenState extends State<BetterPlayerScreen> {
  BetterPlayerController? _betterPlayerController;

  _initPlayer() {
    _betterPlayerController = BetterPlayerController(
      PlayerConfig.betterPlayerControlsConfiguration,
      betterPlayerDataSource: PlayerDataSorce(
              url:
                  "https://edupluz-demoud20fpf.stream-playlist.byteark.com/streams/Ud21H0Mvz8V0/playlist.m3u8")
          .dataSource,
    );

    if (widget.betterPlayerController != null) {
      widget.betterPlayerController!(_betterPlayerController!);
    }
  }

  @override
  void initState() {
    _initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController!,
    );
  }
}
