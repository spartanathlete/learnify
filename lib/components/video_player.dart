import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/providers/section_provider.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/shimmer.dart';
import 'package:learnify/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final LessonModel lessonData;
  final ThemeProvider themeProvider;
  final SizeConfig sizeConfig;

  const VideoPlayerScreen({
    super.key,
    required this.lessonData,
    required this.themeProvider,
    required this.sizeConfig,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  double _currentSliderValue = 0.0; // Add this variable to track slider value.
  Duration _videoPosition = Duration.zero; // To track the video position.

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.lessonData.lessonUrl!,
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    // Add a listener to update the slider value as the video plays.
    _controller.addListener(() {
      setState(() {
        _videoPosition = _controller.value.position;
        _currentSliderValue = _controller.value.position.inSeconds.toDouble();
      });
    });

    // Periodically call a function to update the progress
    // Here, we're using a timer to call the updateProgress function every second.
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateProgress();
    });
  }

  // Function to update the progress.
  void updateProgress() {
    if (_controller.value.isPlaying) {
      // Here, you can use _videoPosition and _videoDuration to track the progress.
      // For example, you can calculate the percentage of progress:
      log('VedPos: ${_videoPosition.inSeconds}');
      Provider.of<SectionProvider>(context, listen: false)
          .setSliderValue(_videoPosition.inSeconds);
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.lessonData.subTitle!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.sizeConfig.blockSizeVertical * 2,
                    color: (widget.themeProvider.isDarkTheme)
                        ? null
                        : const Color.fromARGB(255, 39, 38, 67),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else if (kIsWeb) {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: ExampleUiLoadingAnimation(),
                );
              } else {
                return const Placeholder();
              }
            },
          ),
          Row(
            children: [
              Flexible(
                flex: 12,
                child: Slider(
                  thumbColor: const Color.fromARGB(0, 255, 255, 255),
                  value: _currentSliderValue,
                  min: 0.0,
                  max: _controller.value.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    // Seek to the desired position when the user drags the slider.
                    setState(() {
                      final newPosition = Duration(seconds: value.toInt());
                      _controller.seekTo(newPosition);
                    });
                  },
                ),
              ),
              // Flexible(
              //   flex: 0,
              //   child: Text(
              //     'min${(_currentSliderValue / 60).toString()}',
              //   ),
              // ),
            ],
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       // Calculate the new position to seek to.
                  //       Duration newPosition = _controller.value.position -
                  //           const Duration(seconds: 10);
                  //       // Ensure that the new position is not negative.
                  //       if (newPosition.isNegative) {
                  //         newPosition = Duration.zero;
                  //       }
                  //       // Seek to the new position.
                  //       _controller.seekTo(newPosition);
                  //     });
                  //   },
                  //   icon: const Icon(Icons.replay_10),
                  // ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // setState(() {
                      //   // Calculate the new position to seek to.
                      //   Duration newPosition = _controller.value.position +
                      //       const Duration(seconds: 10);
                      //   // Ensure that the new position is within the video duration.
                      //   if (newPosition > _controller.value.duration) {
                      //     newPosition = _controller.value.duration;
                      //   }
                      //   // Seek to the new position.
                      //   _controller.seekTo(newPosition);
                      // });
                    },
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     CustomIconButton(
              //       icon: Icons.comment,
              //       total: widget.lessonData.totalComments,
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //                 ChangeNotifierProvider<SectionProvider>(
              //               create: (context) => SectionProvider(),
              //               builder: (context, child) => CommentScreen(
              //                 lessonData: widget.lessonData,
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //       themeProvider: widget.themeProvider,
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
