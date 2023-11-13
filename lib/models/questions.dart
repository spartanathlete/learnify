class Quiz {
  final String name;
  final List<Question> questions;

  Quiz({
    required this.name,
    required this.questions,
  });
}

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
}

List<Quiz> quizList = [
  Quiz(
    name: 'Quiz 1',
    questions: quizQuestions1
        .map((question) => Question(
              id: question['id'],
              question: question['question'],
              answer: question['answer_index'],
              options: question['options'],
            ))
        .toList(),
  ),
  Quiz(
    name: 'Quiz 2',
    questions: quizQuestions2
        .map((question) => Question(
              id: question['id'],
              question: question['question'],
              answer: question['answer_index'],
              options: question['options'],
            ))
        .toList(),
  ),
  Quiz(
    name: 'Quiz 3',
    questions: quizQuestions3
        .map((question) => Question(
              id: question['id'],
              question: question['question'],
              answer: question['answer_index'],
              options: question['options'],
            ))
        .toList(),
  ),
];

List<Map<String, dynamic>> quizQuestions1 = [
  {
    "id": 0,
    "question":
        "Flutter est un kit de développement de logiciel UI open source créé par ______",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
  },
  {
    "id": 1,
    "question":
        "Quel est le langage de programmation principal utilisé pour le développement Flutter ?",
    "options": ['Dart', 'Python', 'JavaScript', 'Java'],
    "answer_index": 0,
  },
  {
    "id": 2,
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
