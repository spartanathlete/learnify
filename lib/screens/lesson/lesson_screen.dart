library lesson_screen;

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/components/overview_header.dart';
import 'package:learnify/models/comment_model.dart';
import 'package:learnify/models/lesson_chap_model.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/components/comment_item.dart';
import 'package:learnify/components/lesson_chapters.dart';
import 'package:learnify/components/video_player.dart';
import 'package:learnify/providers/section_provider.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/lesson_chapter_card.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/components/lesson_card.dart';
import 'package:learnify/screens/shared_ui_functions.dart';
import 'package:learnify/utils/size_config.dart';
import 'package:provider/provider.dart';

part 'ui_functions.dart';

class LessonScreen extends StatefulWidget {
  final LessonModel lessonData;

  const LessonScreen({
    super.key,
    required this.lessonData,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  final DashboardController controller = DashboardController();
  final TextEditingController commentController = TextEditingController();
  SizeConfig sizeConfig = SizeConfig();
  bool showReplyInput = false;
  final Duration _animationDuration = const Duration(milliseconds: 500);
  TextEditingController replyController = TextEditingController();
  late AnimationController _animationController;

  SharedUiFunctions sharedUiFunctions = SharedUiFunctions();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sectionProvider = Provider.of<SectionProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    // controller.getSubComments(
    //   lessonID: widget.lessonData.id!,
    //   mainCommentID: 's317rMjrB5bCKuznLtyY',
    // );

    return ResponsiveBuilder(
      mobileBuilder: ((context, constraints) => mob(
            context,
            constraints,
            sectionProvider,
            themeProvider,
            sizeConfig,
          )),
      tabletBuilder: ((context, constraints) => mob(
            context,
            constraints,
            sectionProvider,
            themeProvider,
            sizeConfig,
          )),
      desktopBuilder: (context, constraints) => SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 9,
              child: Column(
                children: [
                  const SizedBox(height: kSpacing),
                  sharedUiFunctions.buildHeader(themeProvider: themeProvider),
                  const SizedBox(height: kSpacing * 2),
                  VideoPlayerScreen(
                    sizeConfig: sizeConfig,
                    lessonData: widget.lessonData,
                    themeProvider: themeProvider,
                  ),
                  buildCommentsSection(
                    config: sizeConfig,
                    themeProvider: themeProvider,
                    controller: controller,
                    commentController: commentController,
                    lessonID: widget.lessonData.id!,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: kSpacing / 2),
                  sharedUiFunctions.buildProfile(
                    data: controller.getProfiles()[0],
                    themeProvider: themeProvider,
                  ),
                  // const Divider(thickness: 1),
                  // const SizedBox(height: kSpacing),
                  // _buildTeamMember(data: controller.getMember()),
                  // const SizedBox(height: kSpacing),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                  //   child: GetPremiumCard(onPressed: () {}),
                  // ),
                  // const SizedBox(height: kSpacing),
                  // const Divider(thickness: 1),
                  const SizedBox(height: kSpacing),
                  _buildLessonChapters(
                    data: controller.getLessonChaps(
                      lessonID: widget.lessonData.id!,
                    ),
                    sectionProvider: sectionProvider,
                    themeProvider: themeProvider,
                    context: context,
                    sizeConfig: sizeConfig,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mob(context, constraints, sectionProvider, themeProvider, config) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
          sharedUiFunctions.buildHeader(themeProvider: themeProvider),
          const SizedBox(height: kSpacing / 2),
          const Divider(),
          sharedUiFunctions.buildProfile(
              data: controller.getProfiles()[0], themeProvider: themeProvider),
          const SizedBox(height: kSpacing),
          VideoPlayerScreen(
            sizeConfig: config,
            lessonData: widget.lessonData,
            themeProvider: themeProvider,
          ),
          const SizedBox(height: kSpacing),
          // buildCommentsSection(
          //   config,
          //   themeProvider,
          //   controller,
          //   commentController,
          //   widget.lessonData.id!,
          // ),
          // _buildLessonChapters(
          //   data: controller.getLessonChapters(),
          //   sectionProvider: sectionProvider,
          //   themeProvider: themeProvider,
          // )
        ],
      ),
    );
  }
}
