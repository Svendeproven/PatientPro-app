import 'package:exam_app/models/hologram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// View model for holograms
class HologramsViewModel {
  // The list of holograms
  final List<Hologram> _holograms = [
    Hologram(
      title: "Hjertet",
      filepath: "assets/videos/hjertet.mp4",
      image: SvgPicture.asset(
        "assets/images/heart-organ.svg",
        width: 32,
        height: 32,
        theme: const SvgTheme(currentColor: Colors.white),
      ),
    ),
    Hologram(
      title: "Lever",
      filepath: "assets/videos/lever.mp4",
      image: SvgPicture.asset(
        "assets/images/liver.svg",
        width: 32,
        height: 32,
        theme: const SvgTheme(currentColor: Colors.white),
      ),
    ),
    Hologram(
      title: "Tyk tarm",
      filepath: "assets/videos/tyk-tarm.mp4",
      image: SvgPicture.asset(
        "assets/images/large-intestine.svg",
        width: 32,
        height: 32,
        theme: const SvgTheme(currentColor: Colors.white),
      ),
    ),
    Hologram(
      title: "Livmoder",
      filepath: "assets/videos/livmoder.mp4",
      image: SvgPicture.asset(
        "assets/images/uterus.svg",
        width: 32,
        height: 32,
        theme: const SvgTheme(currentColor: Colors.white),
      ),
    ),
  ];

  /// Get holograms
  List<Hologram> get holograms => _holograms;

  /// Add hologram
  ///
  /// [hologram] is the hologram to add
  void addHologram(Hologram hologram) {
    _holograms.add(hologram);
  }

  /// Get hologram by index
  ///
  /// [index] is the index of the hologram
  /// Returns a [Hologram]
  Hologram? getHologram(int index) {
    return _holograms[index];
  }
}
