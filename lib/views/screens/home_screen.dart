import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application/controller/game_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> shuffledAnswer = [];
  List<String> placedLetters = [];
  String answerAssist = '';
  String lettersAssist = '';

  @override
  void initState() {
    super.initState();
    final mainController = Get.put(GameController());
    mainController.currentQuestionIndex.listen((index) {
      _prepareQuestion(mainController.questions[index].answer);
    });
    _prepareQuestion(mainController.questions.first.answer);
  }

  void _prepareQuestion(String answer) {
    setState(() {
      placedLetters = List.filled(answer.length, '');
      answerAssist = answer;

      shuffledAnswer = answer.split('')..shuffle();
      while (shuffledAnswer.length < 12) {
        shuffledAnswer.add(_getRandomLetter());
      }
    });
  }

  String _getRandomLetter() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    lettersAssist = chars;
    Random random = Random();
    return chars[random.nextInt(chars.length)];
  }

  void _handleLetterTap(int index) {
    setState(() {
      if (shuffledAnswer[index].isNotEmpty && placedLetters.contains('')) {
        int emptyIndex = placedLetters.indexOf('');
        placedLetters[emptyIndex] = shuffledAnswer[index];
        shuffledAnswer[index] = '';

        if (!placedLetters.contains('')) {
          if (placedLetters.join('') == answerAssist) {
            _onCorrectAnswer();
          } else {
            _onIncorrectAnswer();
          }
        }
      }
    });
  }

  void _onCorrectAnswer() {
    final mainController = Get.find<GameController>();
    Get.snackbar('Correct!', 'You have solved the question.');
    mainController.nextQuestion();
  }

  void _onIncorrectAnswer() {
    Get.snackbar('Try Again!', 'The answer is incorrect.');
    setState(() {
      placedLetters = List.filled(placedLetters.length, '');
      shuffledAnswer = answerAssist.split('');
      while (shuffledAnswer.length < 12) {
        shuffledAnswer.add(_getRandomLetter());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<GameController>();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/nature.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 600,
            child: Obx(() {
              final question = mainController
                  .questions[mainController.currentQuestionIndex.value]
                  .question;
              final answer = mainController
                  .questions[mainController.currentQuestionIndex.value].answer;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    question,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(answer.length, (int index) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          padding: const EdgeInsets.all(5),
                          width: 37,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: Text(
                            placedLetters[index],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      })
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 17,
                    alignment: WrapAlignment.center,
                    children: [
                      ...List.generate(shuffledAnswer.length, (int index) {
                        return GestureDetector(
                          onTap: () => _handleLetterTap(index),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(5),
                            width: 50,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            child: Text(
                              shuffledAnswer[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
