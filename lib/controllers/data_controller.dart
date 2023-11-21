import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnify/components/quiz_card.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/models/comment_model.dart';
import 'package:learnify/models/lesson_model.dart';
import 'package:learnify/models/user_model.dart';
import 'package:learnify/components/chatting_card.dart';
import 'package:learnify/components/lesson_chapter_card.dart';
import 'package:learnify/components/project_card.dart';
import 'package:learnify/models/questions.dart';

class DashboardController {
  static final _database = FirebaseFirestore.instance;
  static final _lessonsColRef = _database.collection('lessons');

  void addSampleLessons() async {
    List<Map<String, dynamic>> sampleLessonsData = [
      {
        'title': 'Lesson 3',
        'subTitle': 'Parallel Lines Cut by a Transversal',
        'lessonUrl':
            'https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/Conditional%20Statements%2C%20Inductive%20%26%20Deductive%20Reasoning%20(Complete%20Geometry%20Course%20Lesson%202).mp4?alt=media&token=c1e5c138-9a6d-4a3b-934e-3b97ed5fdb78',
        'comments': [],
        'likes': [],
        'type': 'Geometry',
      },
      {
        'title': 'Lesson 1',
        'subTitle': 'Conditional Statements, Inductive & Deductive Reasoning',
        'lessonUrl':
            'https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/Geometry%20Lesson%201%20-%20Points%2C%20Lines%2C%20and%20Planes.mp4?alt=media&token=8466a952-87a3-4b06-9cc2-1eb702316b06',
        'comments': [],
        'likes': [],
        'type': 'Geometry',
      },
      // Add more lessons as needed
    ];

    for (var lessonData in sampleLessonsData) {
      await _lessonsColRef.add(lessonData);
    }

    print('Sample lessons added to Firestore.');
  }

  Stream<List<LessonModel>> getLessons() {
    log('message');
    // Stream<List<LessonModel>> result = const Stream.empty();
    return _lessonsColRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        log('title => ${doc.data()["title"]}');
        log('subTitle => ${doc.data()["subTitle"]}');
        log('lessonUrl => ${doc.data()["lessonUrl"]}');
        log('type => ${doc.data()["type"]}');
        log('pubDate => ${doc.data()["pubDate"]}');
        return LessonModel.fromJson(map: doc.data(), id: doc.id);
      }).toList();
    });
  }

  // Future<List<LessonModel>> getLessons() async {
  //   final snapshot = await _lessonsColRef.get();
  //   return snapshot.docs.map((doc) {
  //     final data = doc.data();
  //     final id = doc.id;
  //     return LessonModel.fromJson(map: data, id: id);
  //   }).toList();
  // }

  List<Question> getQuestionList(List<Map<String, dynamic>> source) {
    return source
        .map(
          (questionMap) => Question(
            id: questionMap['id'],
            question: questionMap['question'],
            answer: questionMap['answer_index'],
            options: questionMap['options'],
          ),
        )
        .toList();
  }

  List<Map<String, dynamic>> quizQuestions1 = [
    {
      "id": 1,
      "question":
          "Flutter est un kit de développement de logiciel UI open source créé par ______",
      "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
      "answer_index": 1,
    },
    {
      "id": 2,
      "question":
          "Quel est le langage de programmation principal utilisé pour le développement Flutter ?",
      "options": ['Dart', 'Python', 'JavaScript', 'Java'],
      "answer_index": 0,
    },
    {
      "id": 3,
      "question":
          "Quel widget dans Flutter est utilisé pour construire le contenu principal de l'application ?",
      "options": ['MaterialApp', 'Scaffold', 'Container', 'AppBar'],
      "answer_index": 1,
    },
  ];

  List<Map<String, dynamic>> quizQuestions2 = [
    {
      "id": 1,
      "question": "Quelle est la capitale de la France ?",
      "options": ['Paris', 'Londres', 'Berlin', 'Madrid'],
      "answer_index": 0,
    },
    {
      "id": 2,
      "question": "Combien de continents existent sur Terre ?",
      "options": ['4', '5', '6', '7'],
      "answer_index": 1,
    },
    {
      "id": 3,
      "question": "Quelle est la plus grande planète du système solaire ?",
      "options": ['Vénus', 'Terre', 'Jupiter', 'Mars'],
      "answer_index": 2,
    },
  ];

  List<Map<String, dynamic>> quizQuestions3 = [
    {
      "id": 1,
      "question": "Quel est le plus grand fleuve du monde ?",
      "options": ['Le Nil', 'L\'Amazone', 'Le Mississippi', 'Le Yangtsé'],
      "answer_index": 1,
    },
    {
      "id": 2,
      "question": "Combien de côtés a un hexagone ?",
      "options": ['5', '6', '7', '8'],
      "answer_index": 1,
    },
    {
      "id": 3,
      "question": "Quelle est la plus petite planète du système solaire ?",
      "options": ['Vénus', 'Mercure', 'Mars', 'Pluton'],
      "answer_index": 1,
    },
  ];

  List<QuizCardData> getQuizCardsData() {
    return quizList
        .map(
          (quiz) => QuizCardData(
            inProgress: true,
            name: quiz.name,
            length: quiz.questions.length,
            success: false,
          ),
        )
        .toList();
  }

  List<CommentModel> getComments() {
    return getProfiles().map((UserModel) {
      int count = 1;
      return CommentModel(
        user: UserModel,
        comment: "This is comment number $count",
        pubDate: DateTime.now().toString(),
        replies: [],
      );
    }).toList();
  }

  // List<CommentModel> commentsList = [
  //   CommentModel(
  //     user: const UserModel(
  //       photo: AssetImage(ImageRasterPath.avatar1),
  //       name: "kadhem",
  //       email: "email@kadhem.com",
  //     ),
  //     comment: "what is ithis",
  //     dateTime: DateTime.now(),
  //     replies: [
  //       CommentModel(
  //         user: const UserModel(
  //           photo: AssetImage(ImageRasterPath.avatar1),
  //           name: "kadhem",
  //           email: "email@kadhem.com",
  //         ),
  //         comment: "what is ithis",
  //         dateTime: DateTime.now(),
  //         replies: [],
  //       ),
  //     ],
  //   ),
  //   CommentModel(
  //     user: const Profile(
  //       photo: AssetImage(ImageRasterPath.avatar1),
  //       name: "kadhem",
  //       email: "email@kadhem.com",
  //     ),
  //     comment: "what is ithis",
  //     dateTime: DateTime.now(),
  //     replies: [
  //       CommentModel(
  //         user: const Profile(
  //           photo: AssetImage(ImageRasterPath.avatar1),
  //           name: "kadhem",
  //           email: "email@kadhem.com",
  //         ),
  //         comment: "what is ithis",
  //         dateTime: DateTime.now(),
  //         replies: [],
  //       ),
  //       CommentModel(
  //         user: const Profile(
  //           photo: AssetImage(ImageRasterPath.avatar1),
  //           name: "kadhem",
  //           email: "email@kadhem.com",
  //         ),
  //         comment: "what is ithis",
  //         dateTime: DateTime.now(),
  //         replies: [],
  //       ),
  //     ],
  //   ),
  //   CommentModel(
  //     user: const Profile(
  //       photo: AssetImage(ImageRasterPath.avatar1),
  //       name: "kadhem",
  //       email: "email@kadhem.com",
  //     ),
  //     comment: "what is ithis",
  //     dateTime: DateTime.now(),
  //     replies: [],
  //   ),
  // ];

  List<LessonChapterData> getLessonChapters() {
    return const [
      LessonChapterData(
        name: "I - Introduction",
        lastMessage: "Generic introduction",
        beginAt: 0,
        // isDone: true,
      ),
      LessonChapterData(
        name: "II - Content",
        lastMessage: "The bloody fokin' content",
        beginAt: 12,
        // isDone: true,
      ),
      LessonChapterData(
        name: "III - Outroduction",
        lastMessage: "The bloody fokin' outrodu9chin",
        beginAt: 500,
        // isDone: false,
      ),
    ];
  }

  // Data
  List<UserModel> getProfiles() {
    return [
      const UserModel(
        photo: AssetImage(ImageRasterPath.avatar1),
        firstname: "Kadhem",
        lastname: "SELLAMI",
        email: "kadhemsellami@gmail.com",
      ),
      const UserModel(
        photo: AssetImage(ImageRasterPath.avatar2),
        firstname: " Mohamed",
        lastname: "BETAIEB",
        email: "mohamedbetaieb@gmail.com",
      ),
      const UserModel(
        photo: AssetImage(ImageRasterPath.avatar3),
        firstname: "Karima",
        lastname: "HARKAT",
        email: "karimaharkat@gmail.com",
      ),
    ];
  }

  // List<LessonModel> getAllTask() {
  //   return [
  //     const LessonModel(
  //       lessonUrl:
  //           "https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/Geometry%20Lesson%201%20-%20Points%2C%20Lines%2C%20and%20Planes.mp4?alt=media&token=8466a952-87a3-4b06-9cc2-1eb702316b06&_gl=1*1rnls3i*_ga*MjA4OTc3Nzk3LjE2ODkwNjkwODc.*_ga_CW55HF8NVT*MTY5NzkwMTIzOC4xOC4xLjE2OTc5MDI2MzguNDMuMC4w",
  //       title: "Lesson 1",
  //       subTitle: "Points, Lines, and Planes",
  //       totalComments: 50,
  //       type: LessonCategory.geometry,
  //       totalContributors: 30,
  //       profilContributors: [
  //         AssetImage(ImageRasterPath.avatar1),
  //         AssetImage(ImageRasterPath.avatar2),
  //         AssetImage(ImageRasterPath.avatar3),
  //         AssetImage(ImageRasterPath.avatar4),
  //       ],
  //     ),
  //     const LessonModel(
  //       lessonUrl:
  //           "https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/Conditional%20Statements%2C%20Inductive%20%26%20Deductive%20Reasoning%20(Complete%20Geometry%20Course%20Lesson%202).mp4?alt=media&token=c1e5c138-9a6d-4a3b-934e-3b97ed5fdb78&_gl=1*o5qiyl*_ga*MjA4OTc3Nzk3LjE2ODkwNjkwODc.*_ga_CW55HF8NVT*MTY5NzkwMTIzOC4xOC4xLjE2OTc5MDI2NTguMjMuMC4w",
  //       title: "Lesson 2",
  //       subTitle: "Conditional Statements, Inductive & Deductive Reasoning",
  //       totalComments: 50,
  //       totalContributors: 34,
  //       type: LessonCategory.geometry,
  //       profilContributors: [
  //         AssetImage(ImageRasterPath.avatar5),
  //         AssetImage(ImageRasterPath.avatar6),
  //         AssetImage(ImageRasterPath.avatar7),
  //         AssetImage(ImageRasterPath.avatar8),
  //       ],
  //     ),
  //     const LessonModel(
  //       lessonUrl:
  //           "https://firebasestorage.googleapis.com/v0/b/fir-cruddemo-2bf79.appspot.com/o/Parallel%20Lines%20Cut%20by%20a%20Transversal%20(Complete%20Geometry%20Course%20Lesson%203).mp4?alt=media&token=cb68e74c-0be6-4354-abd1-303f0849a204&_gl=1*4cgcda*_ga*MjA4OTc3Nzk3LjE2ODkwNjkwODc.*_ga_CW55HF8NVT*MTY5NzkwNzMwOC4xOS4xLjE2OTc5MDczMDkuNTkuMC4w",
  //       title: "Lesson 3",
  //       subTitle: "Parallel Lines Cut by a Transversal",
  //       totalComments: 50,
  //       totalContributors: 34,
  //       type: LessonCategory.geometry,
  //       profilContributors: [
  //         AssetImage(ImageRasterPath.avatar5),
  //         AssetImage(ImageRasterPath.avatar3),
  //         AssetImage(ImageRasterPath.avatar4),
  //         AssetImage(ImageRasterPath.avatar2),
  //       ],
  //     ),
  //   ];
  // }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Marketplace Mobile",
      releaseTime: DateTime.now(),
    );
  }

  List<ProjectCardData> getActiveProject() {
    return [
      ProjectCardData(
        percent: .3,
        projectImage: const AssetImage(ImageRasterPath.logo2),
        projectName: "Taxi Online",
        releaseTime: DateTime.now().add(const Duration(days: 130)),
      ),
      ProjectCardData(
        percent: .5,
        projectImage: const AssetImage(ImageRasterPath.logo3),
        projectName: "E-Movies Mobile",
        releaseTime: DateTime.now().add(const Duration(days: 140)),
      ),
      ProjectCardData(
        percent: .8,
        projectImage: const AssetImage(ImageRasterPath.logo4),
        projectName: "Video Converter App",
        releaseTime: DateTime.now().add(const Duration(days: 100)),
      ),
    ];
  }

  List<ImageProvider> getMember() {
    return const [
      AssetImage(ImageRasterPath.avatar1),
      AssetImage(ImageRasterPath.avatar2),
      AssetImage(ImageRasterPath.avatar3),
      AssetImage(ImageRasterPath.avatar4),
      AssetImage(ImageRasterPath.avatar5),
      AssetImage(ImageRasterPath.avatar6),
    ];
  }

  List<ChattingCardData> getChatting() {
    return const [
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar6),
        isOnline: true,
        name: "Samantha",
        lastMessage: "i added my new tasks",
        isRead: false,
        totalUnread: 100,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar3),
        isOnline: false,
        name: "John",
        lastMessage: "well done john",
        isRead: true,
        totalUnread: 0,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar4),
        isOnline: true,
        name: "Alexander Purwoto",
        lastMessage: "we'll have a meeting at 9AM",
        isRead: false,
        totalUnread: 1,
      ),
    ];
  }
}
