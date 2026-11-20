import 'package:flutter/widgets.dart';
import 'video_ad_player_stub.dart'
    if (dart.library.html) 'video_ad_player_web.dart';

Widget buildVideoAdView({
  required String videoAsset,
  required String videoId,
  required bool isPlaying,
  required Widget fallback,
}) =>
    getVideoAdView(
      videoAsset: videoAsset,
      videoId: videoId,
      isPlaying: isPlaying,
      fallback: fallback,
    );
