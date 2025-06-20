import 'dart:io';

import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/fonts.dart';
import 'package:ai1st_package/core/constants/strings.dart';
import 'package:ai1st_package/core/helper/utils.dart';
import 'package:ai1st_package/core/routes/route_constants.dart';
import 'package:ai1st_package/core/routes/router.dart';
import 'package:ai1st_package/src/features/courses/data/models/course_detail_model.dart';
import 'package:ai1st_package/src/features/courses/data/models/course_list_model.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/course_detail_use_case.dart';
import 'package:ai1st_package/src/features/courses/domain/usecases/mark_topic_complete_use_case.dart';
import 'package:ai1st_package/src/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:ai1st_package/src/shared/safe_gesture_detector.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_button.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_card_view.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  BetterPlayerController? _kBetterPlayerController;
  final List<LessonData> _kLessons = [];
  final _kCourseBloc = GetIt.I.get<CoursesBloc>();
  CourseData? _kCourseData;
  TopicData? _kCurrentTopic;
  CourseDetailData? _kCourseDetailData;
  bool _kIsTextExpanded = false;
  File? docPath;
  LessonData? _kCurrentLesson;
  bool _kShowProgress = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      if (arguments != null) {
        setState(
          () {
            _kCourseData = arguments['dataItem'];
            if (arguments['topic'] != null) {
              _kCurrentTopic = arguments['topic'];
              _setupPlayer();
            }
            Utils.log('id ${_kCourseData?.id}');
            _kCallCourseDetailApi();
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _kCourseBloc,
      child: BlocListener<CoursesBloc, CoursesState>(
        listener: (context, state) {
          Utils.log('state is $state');
          switch (state) {
            case CoursesLoading():
              if (_kShowProgress) {
                Utils.showLoaderDialog(context);
              }
              break;
            case CourseDetailStateSuccess():
              setState(() {
                if (_kShowProgress) {
                  Utils.dismissLoaderDialog(context);
                }
                _kCourseDetailData = state.courseDetailEntity.data;
                _kLessons.clear();
                _kLessons.addAll(state.courseDetailEntity.data?.lessons ?? []);
                if (_kCurrentTopic == null) {
                  _kCurrentTopic = _kLessons.first.topics?.first;
                  _setupPlayer();
                }
                for (var element in _kLessons) {
                  _kCurrentLesson = element;
                  break;
                }
              });
              break;
            case CourseDetailStateFailed():
              if (_kShowProgress) {
                Utils.dismissLoaderDialog(context);
              }
              Utils.showSnackBar(context, state.dioException.message!);
              break;
            case MarkTopicCompleteStateSuccess():
              _kShowProgress = false;
              _kCallCourseDetailApi();
              break;
            case MarkTopicCompleteStateFailed():
              Utils.showSnackBar(context, Strings.somethingWentWrong);
              break;
            default:
              break;
          }
        },
        child: _kBetterPlayerController != null
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.getColor(context).bgColor,
                  title: AI1stTextView(
                    text: _kCourseDetailData?.title ?? '',
                    fontFamily: Fonts.futuraNowHeadlineBold,
                  ),
                  centerTitle: false,
                ),
                backgroundColor: AppColors.getColor(context).bgColor,
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_kBetterPlayerController != null)
                              BetterPlayer(
                                key: ValueKey('video_${_kCurrentTopic?.id}'),
                                // make sure _videoId changes per video
                                controller: _kBetterPlayerController!,
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AI1stTextView(
                                    text: _kCurrentTopic?.title?.trim() ?? '',
                                    maxLine: _kIsTextExpanded ? 100 : 2,
                                    fontFamily: Fonts.futuraNowHeadlineMedium,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AI1stTextView(
                                    text: _kCurrentTopic?.content?.trim() ?? '',
                                    maxLine: _kIsTextExpanded ? 100 : 2,
                                    onTap: () {
                                      setState(() {
                                        _kIsTextExpanded = !_kIsTextExpanded;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      if ((_kCourseDetailData?.lessons ?? [])
                                          .isNotEmpty)
                                        Expanded(
                                          child: AI1stTextView(
                                            text:
                                                '${_kCourseDetailData?.lessons?.length.toString()} ${Strings.lessons.tr()}',
                                          ),
                                        ),
                                      /* AI1stTextView(
                                    text: '3h 52m',
                                  ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: _kLessons.length,
                                          itemBuilder: (context, i) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                AI1stCardView(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  elevation: 1.0,
                                                  height: null,
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                            dividerColor: Colors
                                                                .transparent),
                                                    child: ExpansionTile(
                                                      tilePadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      controller: _kLessons[i]
                                                          .expansionTileController,
                                                      initiallyExpanded:
                                                          _kCurrentLesson?.id ==
                                                              _kLessons[i].id,
                                                      childrenPadding:
                                                          EdgeInsets.zero,
                                                      title: AI1stTextView(
                                                        text: _kLessons[i]
                                                                .title ??
                                                            '',
                                                        fontFamily: Fonts
                                                            .futuraNowHeadlineMedium,
                                                      ),
                                                      children: <Widget>[
                                                        Column(
                                                          children:
                                                              _buildExpandableContent(
                                                            _kLessons[i],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
                                  if ((_kCourseDetailData?.certificateUrl ?? '')
                                      .isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 60.0,
                                        ),
                                        AI1stTextView(
                                          text: Strings.certificateLabel,
                                          fontFamily:
                                              Fonts.futuraNowHeadlineMedium,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AI1stButton(
                                          text: Strings.downloadCertificate,
                                          onTap: () {
                                            navigateTo(
                                              context: context,
                                              route: RouteConstants
                                                  .downloadCertificate,
                                              arguments: {
                                                'url': _kCourseDetailData
                                                        ?.certificateUrl ??
                                                    ''
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              )
            : Container(
                color: AppColors.getColor(context).bgColor,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
      ),
    );
  }

  void _setupPlayer() async {
    setState(() {
      _kBetterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          fit: BoxFit.fill,
          autoDetectFullscreenDeviceOrientation: false,
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          fullScreenByDefault: false,
          eventListener: (p0) async {
            switch (p0.betterPlayerEventType) {
              case BetterPlayerEventType.initialized:
                // _kIsFinished = false;
                break;
              case BetterPlayerEventType.openFullscreen:
                await _kSetOrientationToLandscape();
                break;
              case BetterPlayerEventType.hideFullscreen:
                await _kSetOrientationToPortrait();
                /*await _kSetOrientationToPortrait().then(
                  (value) {
                    if (_kIsFinished) {
                      if (!(_kCurrentTopic?.taskComplete ?? false)) {
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          _kAssignNextTopic(callApi: true);
                        });
                      } else {
                        _kAssignNextTopic();
                      }
                    }
                  },
                );*/
                break;
              case BetterPlayerEventType.finished:
                // _kIsFinished = true;
                if (!(_kCurrentTopic?.taskComplete ?? false)) {
                  _kCallFinishedApi();
                }
              case BetterPlayerEventType.exception:
                Utils.log('exception');
                break;
              default:
                break;
            }
          },
        ),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          videoFormat: BetterPlayerVideoFormat.hls,
          _kCurrentTopic?.bunnyVideo ?? '',
          useAsmsSubtitles: true,
          useAsmsTracks: true,
          subtitles: _kCurrentTopic?.subtitleFile != null
              ? [
                  BetterPlayerSubtitlesSource(
                    type: BetterPlayerSubtitlesSourceType.network,
                    name: "DE",
                    selectedByDefault: true,
                    urls: [
                      _kCurrentTopic?.subtitleFile,
                    ],
                  ),
                ]
              : null,
        ),
      );
    });
  }

  _buildExpandableContent(LessonData lesson) {
    List<Widget> columnContent = [];

    for (int i = 0; i < (lesson.topics ?? []).length; i++) {
      TopicData topic = (lesson.topics ?? [])[i];
      columnContent.add(
        SafeGestureDetector(
          onTap: () {
            if (topic.id == _kCurrentTopic?.id) {
              if (!(_kBetterPlayerController?.isPlaying() ?? false)) {
                setState(() {
                  _kBetterPlayerController?.play();
                });
              }
            } else {
              setState(() {
                if (topic.isUnlock ?? false) {
                  _kCurrentLesson = lesson;
                  _kCurrentTopic = topic;
                  _setupPlayer();
                } else {
                  Utils.showSnackBar(context, Strings.videoIsLocked);
                }
              });
            }
          },
          child: ListTile(
            title: Row(
              children: [
                if (_kCurrentTopic?.id == topic.id)
                  Icon(
                    Icons.play_arrow,
                    color: AppColors.getColor(context).colorRed,
                  ),
                SizedBox(
                  width: 3.0,
                ),
                Expanded(
                  child: AI1stTextView(
                    text: topic.title ?? '',
                  ),
                ),
                SizedBox(
                  width: 3.0,
                ),
                if (!(topic.isUnlock ?? false)) Icon(Icons.lock_outline)
              ],
            ),
          ),
        ),
      );
    }

    return columnContent;
  }

  Future<void> _kCallFinishedApi() async {
    _kCourseBloc.add(
      MarkTopicCompleteEvent(
        markTopicCompleteParams: MarkTopicCompleteParams(
          courseId: _kCourseDetailData!.id.toString(),
          topicId: _kCurrentTopic!.id.toString(),
        ),
      ),
    );
  }

  /*void _kAssignNextTopic({bool callApi = false}) {
    bool found = false;

    for (int i = 0; i < _kLessons.length; i++) {
      List<TopicData> topics = _kLessons[i].topics ?? [];

      for (int j = 0; j < topics.length; j++) {
        if (topics[j].id == _kCurrentTopic?.id) {
          found = true;

          // Check if this is not the last topic in the current course
          if (j < topics.length - 1) {
            setState(() {
              _kCurrentTopic = topics[j + 1];
              _kCalculateNextTopic();
              _setupPlayer();
            });
            return;
          }

          // If this was the last topic in the current course
          // Check if there is a next course
          if (i < _kLessons.length - 1 &&
              (_kLessons[i + 1].topics ?? []).isNotEmpty) {
            setState(() {
              for (var element in _kLessons) {
                element.expansionTileController?.collapse();
              }
              _kLessons[i + 1].expansionTileController?.expand();
              _kCurrentLesson = _kLessons[i + 1];
              _kCurrentTopic = _kLessons[i + 1].topics!.first;
              _kCalculateNextTopic();
              if (callApi) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    _kCallFinishedApi();
                  },
                );
              }
              _setupPlayer();
            });
            return;
          } else {
            Utils.log("No more topics available.");
            _kCurrentLesson?.expansionTileController?.expand();
            _kCurrentLesson = _kLessons.first;
            _kCurrentTopic = _kCurrentLesson?.topics?.first;
            _kCalculateNextTopic();
            _kCallCourseDetailApi();
            // _setupPlayer();
            return;
          }
        }
      }
    }

    if (!found) {
      Utils.log("Current topic not found in the course list.");
    }
  }*/

  void _kCallCourseDetailApi() {
    _kCourseBloc.add(
      CourseDetailEvent(
        params: CourseDetailParams(
          id: _kCourseData!.id.toString(),
          isEnroll: _kCourseData!.progressPercent == 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _kBetterPlayerController?.dispose();
    super.dispose();
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

  Future<void> downloadPDF(BuildContext context, String url) async {
    final dio = Dio();
    if (!url.contains('https')) {
      url = 'https://$url';
    }
    await dio.get(url, options: Options(responseType: ResponseType.bytes)).then(
      (value) async {
        final bytes = value.data;
        final directory = (await getApplicationDocumentsDirectory()).path;
        docPath = await File('$directory/quote.pdf').create();
        await docPath?.writeAsBytes(bytes);
        setState(() {});
      },
    );
  }
}
