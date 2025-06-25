import 'package:bestforming_cac/core/constants/colours.dart';
import 'package:bestforming_cac/core/constants/fonts.dart';
import 'package:bestforming_cac/core/helper/utils.dart';
import 'package:bestforming_cac/src/features/courses/data/models/video_library_model.dart';
import 'package:bestforming_cac/src/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_textview.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class VideoDetailScreen extends StatefulWidget {
  const VideoDetailScreen({super.key});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  BetterPlayerController? _kBetterPlayerController;
  VideoData? _kVideoData;
  bool _kIsTextExpanded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
        if (arguments != null) {
          setState(() {
            _kVideoData = arguments['dataItem'];
            Utils.log('id ${_kVideoData?.id}');
            _kBetterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(
                autoPlay: true,
                fit: BoxFit.fill,
                autoDetectFullscreenDeviceOrientation: false,
                deviceOrientationsAfterFullScreen: [
                  DeviceOrientation.portraitUp
                ],
                fullScreenByDefault: false,
                controlsConfiguration:
                    BetterPlayerControlsConfiguration.cupertino(),
                eventListener: (p0) async {
                  switch (p0.betterPlayerEventType) {
                    case BetterPlayerEventType.openFullscreen:
                      await _kSetOrientationToLandscape();
                      break;
                    case BetterPlayerEventType.hideFullscreen:
                      await _kSetOrientationToPortrait();
                      break;
                    default:
                      break;
                  }
                },
              ),
              betterPlayerDataSource: BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                videoFormat: BetterPlayerVideoFormat.hls,
                _kVideoData?.bunnyVideo ?? '',
                useAsmsSubtitles: true,
                useAsmsTracks: true,
                subtitles: _kVideoData?.subtitleFile != null
                    ? [
                        BetterPlayerSubtitlesSource(
                          type: BetterPlayerSubtitlesSourceType.network,
                          name: "DE",
                          selectedByDefault: true,
                          urls: [
                            _kVideoData?.subtitleFile,
                          ],
                        ),
                      ]
                    : null,
              ),
            );
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<CoursesBloc>(),
      child: _kVideoData != null
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.getColor(context).bgColor,
                title: AI1stTextView(
                  text: _kVideoData?.title ?? '',
                  fontFamily: Fonts.futuraNowHeadlineBold,
                ),
                centerTitle: false,
              ),
              backgroundColor: AppColors.getColor(context).bgColor,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_kBetterPlayerController != null)
                      BetterPlayer(controller: _kBetterPlayerController!),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AI1stTextView(
                        text: Utils.getFormattedTime(_kVideoData?.date),
                        fontFamily: Fonts.futuraNowHeadlineLight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AI1stTextView(
                        text: _kVideoData?.title ?? '',
                        maxLine: 2,
                        fontFamily: Fonts.futuraNowHeadlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AI1stTextView(
                        text: _kVideoData?.excerpt ?? '',
                        maxLine: _kIsTextExpanded ? 10 : 2,
                        fontFamily: Fonts.futuraNowHeadlineRegular,
                        onTap: () {
                          setState(() {
                            _kIsTextExpanded = !_kIsTextExpanded;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }

  Future<void> _kSetOrientationToPortrait() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _kSetOrientationToLandscape() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
