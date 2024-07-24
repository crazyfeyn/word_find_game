import 'package:flutter_application/models/question.dart';
import 'package:get/state_manager.dart';

class GameController extends GetxController {
  var questions = <Question>[
    Question(question: 'The largest ocean in the world', answer: 'Pacific'),
    Question(question: 'The capital of USA', answer: 'Washington'),
    Question(question: 'The chemical symbol for water', answer: 'H2O'),
    Question(question: 'The author of "Pride and Prejudice"', answer: 'Jane'),
    Question(question: 'The fastest land animal', answer: 'Cheetah'),
    Question(question: 'The longest river in the world', answer: 'Nile'),
    Question(question: 'The largest planet in our solar system', answer: 'Jupiter'),
    Question(question: 'The smallest country in the world', answer: 'Vatican'),
    Question(question: 'The most spoken language in the world', answer: 'Mandarin'),
    Question(question: 'The inventor of the telephone', answer: 'Bell'),
    Question(question: 'The capital city of France', answer: 'Paris'),
  ].obs;

  RxInt currentQuestionIndex = 0.obs;

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      currentQuestionIndex.value = 0; 
    }
  }
}
