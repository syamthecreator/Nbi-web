import 'dart:ui_web' as ui_web;
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

final Set<String> _registeredViews = {};

Widget getVideoAdView({
  required String videoAsset,
  required String videoId,
  required bool isPlaying,
  required Widget fallback,
}) {
  final viewType = 'ad-video-$videoId';
  if (!_registeredViews.contains(viewType)) {
    _registeredViews.add(viewType);
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final video = web.document.createElement('video') as web.HTMLVideoElement
        ..id = 'video-$videoId'
        ..autoplay = true
        ..loop = true
        ..muted = true
        ..playsInline = true;

      video.style.width = '100%';
      video.style.height = '100%';
      video.style.objectFit = 'cover';
      video.style.display = 'block';
      video.style.border = 'none';
      video.style.backgroundColor = '#000000';

      final s1 = web.document.createElement('source') as web.HTMLSourceElement
        ..src = videoAsset.startsWith('/') ? videoAsset : 'assets/$videoAsset'
        ..type = 'video/mp4';
      final s2 = web.document.createElement('source') as web.HTMLSourceElement
        ..src = videoAsset
        ..type = 'video/mp4';
      video.appendChild(s1);
      video.appendChild(s2);

      return video;
    });
  }

  // Handle play/pause via DOM if rendered
  final existingVideo = web.document.getElementById('video-$videoId') as web.HTMLVideoElement?;
  if (existingVideo != null) {
    if (isPlaying) {
      existingVideo.play();
    } else {
      existingVideo.pause();
    }
  }

  return HtmlElementView(viewType: viewType);
}
