library exercice_screen;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learnify/components/quiz_card.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/components/overview_header.dart';
import 'package:learnify/models/comment_model.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/components/comment_item.dart';
import 'package:learnify/components/lesson_chapters.dart';
import 'package:learnify/models/questions.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/components/lesson_card.dart';
import 'package:learnify/screens/home/components/quiz_body.dart';
import 'package:learnify/screens/shared_ui_functions.dart';
import 'package:learnify/utils/size_config.dart';
import 'package:provider/provider.dart';

part 'ui_functions.dart';

class ExerciceScreen extends StatefulWidget {
  const ExerciceScreen({
    super.key,
    required this.lessonName,
  });

  final String lessonName;

  @override
  State<ExerciceScreen> createState() => _ExerciceScreenState();
}

class _ExerciceScreenState extends State<ExerciceScreen>
    with SingleTickerProviderStateMixin {
  final DashboardController controller = DashboardController();
  SizeConfig sizeConfig = SizeConfig();
  SharedUiFunctions sharedUiFunctions = SharedUiFunctions();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return ResponsiveBuilder(
      mobileBuilder: ((context, constraints) => mob(
            context,
            constraints,
            themeProvider,
            sizeConfig,
          )),
      tabletBuilder: ((context, constraints) => mob(
            context,
            constraints,
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
                  QuizBody(
                    sizeConfig: sizeConfig,
                    questions: controller.getQuestionList(
                      controller.quizQuestions1,
                    ),
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
                  const SizedBox(height: kSpacing),
                  _buildQuizCards(
                    lessonName: widget.lessonName,
                    data: controller.getQuizCardsData(),
                    themeProvider: themeProvider,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mob(context, constraints, themeProvider, config) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
          _buildQuizBody(
            sizeConfig: sizeConfig,
            questions: controller.getQuestionList(controller.quizQuestions1),
          )
        ],
      ),
    );
  }
}
