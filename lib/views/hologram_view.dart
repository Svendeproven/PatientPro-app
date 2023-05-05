import 'package:exam_app/models/hologram.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// View for hologram
class HologramView extends StatefulWidget {
  final Hologram hologram;

  /// Constructor
  ///
  /// [hologram] is the hologram to show
  /// [key] is the key
  const HologramView({super.key, required this.hologram});

  @override
  State<HologramView> createState() => _HologramViewState();
}

class _HologramViewState extends State<HologramView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.hologram.filepath);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // override build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.hologram.title),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }
}
