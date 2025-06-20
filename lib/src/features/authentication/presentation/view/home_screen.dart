import 'package:ai1st_package/core/constants/colours.dart';
import 'package:ai1st_package/core/constants/constants.dart';
import 'package:ai1st_package/core/constants/fonts.dart';
import 'package:ai1st_package/core/constants/media_res.dart';
import 'package:ai1st_package/core/constants/strings.dart';
import 'package:ai1st_package/core/helper/prefs.dart';
import 'package:ai1st_package/core/helper/theme_utils.dart';
import 'package:ai1st_package/core/helper/utils.dart';
import 'package:ai1st_package/core/routes/route_constants.dart';
import 'package:ai1st_package/core/routes/router.dart';
import 'package:ai1st_package/src/features/courses/data/models/course_list_model.dart';
import 'package:ai1st_package/src/features/courses/data/models/video_library_model.dart';
import 'package:ai1st_package/src/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:ai1st_package/src/shared/safe_gesture_detector.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_button.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_network_image_widget.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_progress_bar.dart';
import 'package:ai1st_package/src/shared/widgets/ai_1st_textview.dart';
import 'package:ai1st_package/src/shared/widgets/stacked_card_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _kScaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _kTabController;
  final PageController _kPageController = PageController();
  bool _kDarkModeSwitch = false;
  bool _kNotificationsSwitch = false;
  final _kCoursesBloc = GetIt.I.get<CoursesBloc>();
  final List<VideoData> _kVideoLibraryList = [];
  final List<CourseData> _kCourseList = [];

  @override
  void initState() {
    _kTabController = TabController(length: 2, vsync: this);
    setState(() {
      _kDarkModeSwitch = Prefs.getBool(key: Constants.isDarkMode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _kCoursesBloc..add(VideoLibraryEvent()),
      child: BlocListener<CoursesBloc, CoursesState>(
        listener: (context, state) {
          switch (state) {
            case CoursesLoading():
              Utils.showLoaderDialog(context);
              break;
            case VideoLibraryStateSuccess():
              _kCoursesBloc.add(CourseListEvent());
              setState(() {
                _kVideoLibraryList.clear();
                _kVideoLibraryList
                    .addAll(state.videoLibraryEntity.data?.videos ?? []);
              });
              break;
            case VideoLibraryStateFailed():
              Utils.dismissLoaderDialog(context);
              Utils.showSnackBar(context, state.dioException.message ?? '');
              break;
            case CourseListStateSuccess():
              setState(() {
                Utils.dismissLoaderDialog(context);
                _kCourseList.clear();
                _kCourseList.addAll(state.courseListEntity.data?.courses ?? []);
              });
              break;
            case CourseListStateFailed():
              Utils.dismissLoaderDialog(context);
              Utils.showSnackBar(context, state.dioException.message ?? '');
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          key: _kScaffoldKey,
          appBar: AppBar(
            backgroundColor: AppColors.getColor(context).bgColor,
            leadingWidth: 100,
            toolbarHeight: 70,
            leading: Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                MediaRes.icLogoPadded,
                color: AppColors.getColor(context).primaryColor,
              ),
            ),
            actions: [
              SafeGestureDetector(
                onTap: () {
                  _kScaffoldKey.currentState?.openEndDrawer();
                },
                child: SizedBox.square(
                  dimension: 40.0,
                  child: Icon(CupertinoIcons.line_horizontal_3),
                ),
              ),
              SizedBox(
                width: 15.0,
              )
            ],
            /*title: AI1stTextView(
              text: Strings.welcomeToAi1st,
              // text: '${Strings.welcome.tr()}, ${Prefs.getString(key: Constants.displayName)}',
              fontFamily: Fonts.interBold,
            ),
            centerTitle: false,*/
          ),
          endDrawer: Drawer(
            width: 290.sp,
            child: _kDrawerWidget(context),
          ),
          backgroundColor: AppColors.getColor(context).bgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TabBar(
                  controller: _kTabController,
                  indicatorColor: AppColors.getColor(context).colorRed,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.getColor(context).primaryColor,
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor:
                      AppColors.getColor(context).primaryColor,
                  tabs: const [
                    Tab(
                      child: Row(
                        children: [
                          AI1stTextView(
                            text: Strings.updates,
                            fontFamily: Fonts.futuraNowHeadlineBlackItalic,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          AI1stTextView(
                            text: Strings.courses,
                            fontFamily: Fonts.futuraNowHeadlineBlackItalic,
                          ),
                          Expanded(
                            child: SizedBox.shrink(),
                          ),
                        ],
                      ),
                    )
                  ],
                  onTap: (value) {
                    setState(() {
                      _kPageController.animateToPage(
                        value,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    });
                  },
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _kPageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      setState(() {
                        _kTabController.animateTo(value);
                      });
                    },
                    children: [
                      _kLibraryView(context),
                      _kCoursesView(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kLibraryView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _kVideoLibraryList.length,
            itemBuilder: (context, index) {
              return SafeGestureDetector(
                onTap: () {
                  navigateTo(
                    context: context,
                    route: RouteConstants.videoDetail,
                    arguments: {
                      'dataItem': _kVideoLibraryList[index],
                    },
                    then: (p0) async {
                      await _kSetOrientationToPortrait().then(
                        (value) {
                          _kCallApi();
                        },
                      );
                    },
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Stack(
                          children: [
                            AI1stNetworkImageWidget(
                              imageUrl:
                                  _kVideoLibraryList[index].featuredImage ?? '',
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: AI1stTextView(
                                  text:
                                      _kVideoLibraryList[index].duration ?? '',
                                  color: AppColors.getColor(context).colorWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AI1stTextView(
                      text: Utils.getFormattedTime(
                          _kVideoLibraryList[index].date),
                      fontFamily: Fonts.futuraNowHeadlineLight,
                    ),
                    AI1stTextView(
                      text: _kVideoLibraryList[index].title ?? '',
                      maxLine: 2,
                      fontFamily: Fonts.futuraNowHeadlineMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  Widget _kCoursesView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _kCourseList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Stack(
                    children: [
                      StackedCardView(
                        imageUrl: _kCourseList[index].featuredImage ?? '',
                      ),
                      Positioned(
                        bottom: 18,
                        right: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AI1stButton(
                              width: 180.0,
                              height: 40.0,
                              padding: 10.0,
                              text: (_kCourseList[index].isEnrolled ?? false)
                                  ? Strings.continueWatching
                                  : Strings.startNow,
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  route: RouteConstants.courseDetail,
                                  arguments: {
                                    'dataItem': _kCourseList[index],
                                    'topic': (_kCourseList[index].nextStep ??
                                                [])
                                            .isEmpty
                                        ? null
                                        : _kCourseList[index].nextStep?.first,
                                  },
                                  then: (p0) async {
                                    await _kSetOrientationToPortrait().then(
                                      (value) {
                                        _kCallApi();
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        AI1stTextView(
                          text: _kCourseList[index].title ?? '',
                          maxLine: 2,
                          fontFamily: Fonts.futuraNowHeadlineMedium,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            if (_kCourseList[index].progressPercent != 0)
                              Expanded(
                                child: Ai1stProgressBar(
                                  progress:
                                      _kCourseList[index].progressPercent ??
                                          0.0,
                                ),
                              ),
                            if (_kCourseList[index].progressPercent != 0)
                              SizedBox(
                                width: 3.0,
                              ),
                            AI1stTextView(
                              text:
                                  '${(_kCourseList[index].completedSteps ?? 0)}/${_kCourseList[index].totalSteps} ${Strings.lessons.tr()}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        // Ai1stProgressBar(progress: 37),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  Widget _kDrawerWidget(BuildContext context) {
    return Container(
      color: AppColors.getColor(context).bgColor,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 70.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              MediaRes.icLogoPadded,
              width: 70.0,
              height: 70.0,
              color: AppColors.getColor(context).primaryColor,
            ),
          ),
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(MediaRes.icUserPlaceHolder),
                radius: 30,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AI1stTextView(
                      text: Prefs.getString(key: Constants.displayName),
                      fontFamily: Fonts.interBold,
                      maxLine: 2,
                    ),
                    AI1stTextView(
                      text: Prefs.getString(key: Constants.email),
                      fontFamily: Fonts.interRegular,
                      maxLine: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),*/
          /*SizedBox(
            height: 30.0,
          ),
          SafeGestureDetector(
            onTap: () {
              navigateTo(context: context, route: RouteConstants.editProfile);
            },
            child: Row(
              children: [
                Image.asset(
                  MediaRes.icEditProfile,
                  width: 25.0,
                  height: 25.0,
                  color: AppColors.getColor(context).primaryColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                AI1stTextView(
                  text: Strings.editProfile,
                  fontFamily: Fonts.futuraNowHeadlineMediumItalic,
                )
              ],
            ),
          ),*/
          /*SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Image.asset(
                MediaRes.icMyCourses,
                width: 25.0,
                height: 25.0,
                fit: BoxFit.cover,
                color: AppColors.getColor(context).primaryColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              AI1stTextView(
                text: Strings.myCourses,
              )
            ],
          ),*/
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Image.asset(
                MediaRes.icNotification,
                width: 25.0,
                height: 25.0,
                color: AppColors.getColor(context).primaryColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              AI1stTextView(
                text: Strings.notifications,
                fontFamily: Fonts.futuraNowHeadlineMedium,
              ),
              Spacer(),
              Switch.adaptive(
                value: _kNotificationsSwitch,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.getColor(context).colorRed,
                onChanged: (value) {
                  setState(() {
                    _kNotificationsSwitch = !_kNotificationsSwitch;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              Image.asset(
                MediaRes.icDarkMode,
                width: 25.0,
                height: 25.0,
                color: AppColors.getColor(context).primaryColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              AI1stTextView(
                text: Strings.darkMode,
                fontFamily: Fonts.futuraNowHeadlineMedium,
              ),
              Spacer(),
              Switch.adaptive(
                value: _kDarkModeSwitch,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.getColor(context).colorRed,
                onChanged: (value) {
                  setState(() {
                    ThemeUtils.changeTheme();
                    _kDarkModeSwitch = !_kDarkModeSwitch;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          SafeGestureDetector(
            onTap: () {
              Utils.logOut(context);
            },
            child: Row(
              children: [
                Image.asset(
                  MediaRes.icLogout,
                  width: 25.0,
                  height: 25.0,
                  color: AppColors.getColor(context).primaryColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                AI1stTextView(
                  text: Strings.logout,
                  fontFamily: Fonts.futuraNowHeadlineMediumItalic,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: AI1stTextView(
              text: 'v1.0.0',
              fontFamily: Fonts.futuraNowHeadlineLight,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  void _kCallApi() {
    _kCoursesBloc.add(VideoLibraryEvent());
  }

  Future<void> _kSetOrientationToPortrait() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
