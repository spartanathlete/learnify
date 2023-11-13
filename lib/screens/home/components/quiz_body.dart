import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnify/controllers/question_controller.dart';
import 'package:learnify/models/questions.dart';
import 'package:learnify/utils/size_config.dart';

import 'progress_bar.dart';
import 'question_card.dart';

class QuizBody extends StatelessWidget {
  final SizeConfig sizeConfig;
  final List<Question> questions;

  const QuizBody({
    super.key,
    required this.sizeConfig,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);

    // So that we have acccess our controller
    QuestionController questionController = Get.put(QuestionController());

    log(
      'Height : ${sizeConfig.actualScreenHeight}',
      name: 'QuizBody',
    );
    log(
      'Width : ${sizeConfig.actualScreenWidth}',
      name: 'QuizBody',
    );

    return SizedBox(
      height: sizeConfig.actualScreenHeight,
      width: sizeConfig.actualScreenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ProgressBar(),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              () => Text.rich(
                TextSpan(
                  text: "Question ${questionController.questionNumber.value}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: const Color(0xFF8B94BC)),
                  children: [
                    TextSpan(
                      text: "/${questionController.questions.length}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: const Color(0xFF8B94BC)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(thickness: 1.5),
          const SizedBox(height: 20.0),
          Expanded(
            child: PageView.builder(
              // Block swipe to next qn
              physics: const NeverScrollableScrollPhysics(),
              controller: questionController.pageController,
              onPageChanged: questionController.updateTheQnNum,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                log("length: ${questions.length}");
                log("index: $index");
                if (index <= questions.length) {
                  return QuestionCard(
                    question: questions[index],
                  );
                } else {
                  log("Else block initialized");
                  // questionController.onClose();
                  return Center(
                    child: Column(
                      children: [
                        const Spacer(flex: 3),
                        Text(
                          "Score",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: const Color(0xFF8B94BC)),
                        ),
                        const Spacer(),
                        Text(
                          "${questionController.correctAns}/${questionController.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: const Color(0xFF8B94BC)),
                        ),
                        const Spacer(flex: 3),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                hoverColor: const Color.fromARGB(0, 0, 0, 0),
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                hoverColor: const Color.fromARGB(0, 0, 0, 0),
                onPressed: () {},
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                hoverColor: const Color.fromARGB(0, 0, 0, 0),
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          )
        ],
      ),
    );
  }
}
