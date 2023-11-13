import 'package:flutter/material.dart';
import 'package:learnify/models/lesson_model.dart';

class SectionProvider extends ChangeNotifier {
  int _sliderValue = 0;
  int get sliderValue => _sliderValue;

  late LessonModel _selectedLesson;
  LessonModel get selectedLesson => _selectedLesson;

  void setSliderValue(int newValue) {
    _sliderValue = newValue;
    notifyListeners();
  }

  void setLessonData(LessonModel lessonData) {
    _selectedLesson = selectedLesson;
    notifyListeners();
  }
}
