import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerConfig {
  static const BetterPlayerConfiguration betterPlayerControlsConfiguration =
      BetterPlayerConfiguration(
    autoPlay: true,
    aspectRatio: 16 / 9,
    fit: BoxFit.contain,
    autoDispose: true,
    deviceOrientationsAfterFullScreen: [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
    controlsConfiguration: BetterPlayerControlsConfiguration(
      playerTheme: BetterPlayerTheme.material,
      enablePlaybackSpeed: true,
      enableAudioTracks: false,
      enableSubtitles: false,
      enableQualities: true,
      showControlsOnInitialize: false,
    ),
  );
}
