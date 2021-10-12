import 'package:flutter/cupertino.dart';

import 'question.dart';

class QuestionsState extends ChangeNotifier {

  var questions = [
    Question("Is Flutter created by Google?", true, "ima1.png"),
    Question("Is Kotlin programming language used by Flutter?", false, "ima2.png"),
    Question(
        " Dart programing language created by Lars Bak and Kasper Lund.",
        true,
        "ima3.png")
  ];

  int questionId = 0;

  void updateQuestions(){
    if (questionId != questions.length - 1) {
      questionId = questionId + 1;
    } else {
      questionId = 0;
    }
    notifyListeners();
  }
}