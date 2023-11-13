part of app_helpers;

extension TaskTypeExtension on LessonCategory {
  Color getColor() {
    switch (this) {
      case LessonCategory.algebra:
        return Colors.lightBlue;
      case LessonCategory.geometry:
        return Colors.amber[700]!;
      default:
        return Colors.redAccent;
    }
  }

  String toStringValue() {
    switch (this) {
      case LessonCategory.algebra:
        return "Algebra";
      case LessonCategory.geometry:
        return "Geometry";
      default:
        return "Calculus";
    }
  }
}
