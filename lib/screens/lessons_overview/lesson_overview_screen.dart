library lessons_overview_screen;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:learnify/components/recent_messages.dart';
import 'package:learnify/components/team_member.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/components/overview_header.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/chatting_card.dart';
import 'package:learnify/components/get_premium_card.dart';
import 'package:learnify/components/list_profil_image.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/components/lesson_card.dart';
import 'package:learnify/screens/shared_ui_functions.dart';
import 'package:learnify/utils/size_config.dart';

part 'ui_functions.dart';

class LessonOverviewScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const LessonOverviewScreen({
    super.key,
    required this.themeProvider,
  });

  @override
  State<LessonOverviewScreen> createState() => _LessonOverviewScreenState();
}

class _LessonOverviewScreenState extends State<LessonOverviewScreen> {
  final DashboardController controller = DashboardController();
  SharedUiFunctions sharedUiFunctions = SharedUiFunctions();
  final SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    // controller.addSampleLessons();

    return ResponsiveBuilder(
      mobileBuilder: ((context, constraints) => mob(
            context,
            constraints,
          )),
      tabletBuilder: ((context, constraints) => mob(
            context,
            constraints,
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
                  sharedUiFunctions.buildHeader(
                      themeProvider: widget.themeProvider),
                  const SizedBox(height: kSpacing * 2),
                  buildLessonOverview(
                    themeProvider: widget.themeProvider,
                    data: controller.getLessons(),
                    crossAxisCount: 6,
                    crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
                    context: context,
                    sizeConfig: sizeConfig,
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
                    themeProvider: widget.themeProvider,
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: kSpacing),
                  _buildTeamMember(
                    data: controller.getMember(),
                    themeProvider: widget.themeProvider,
                  ),
                  const SizedBox(height: kSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    child: GetPremiumCard(
                      onPressed: () {},
                      themeProvider: widget.themeProvider,
                    ),
                  ),
                  const SizedBox(height: kSpacing),
                  const Divider(thickness: 1),
                  const SizedBox(height: kSpacing),
                  _buildRecentMessages(
                    data: controller.getChatting(),
                    themeProvider: widget.themeProvider,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mob(context, constraints) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
          sharedUiFunctions.buildHeader(themeProvider: widget.themeProvider),
          const SizedBox(height: kSpacing / 2),
          const Divider(),
          sharedUiFunctions.buildProfile(
            data: controller.getProfiles()[0],
            themeProvider: widget.themeProvider,
          ),
          const SizedBox(height: kSpacing),
          // buildLessonOverview(
          //   themeProvider: widget.themeProvider,
          //   data: controller.getLessons(),
          //   headerAxis: Axis.vertical,
          //   crossAxisCount: 6,
          //   crossAxisCellCount: 6,
          //   context: context,
          //   sizeConfig: sizeConfig,
          // ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }
}
