import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizzlerBrain.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void checkAnswer (bool userAnswer){
    setState(() {
    if (quizzlerBrain.getQuestionAnswer() == userAnswer) {
      scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ),);
    } else {
      scoreKeeper.add(const Icon(
        Icons.close,
        color : Colors.red,
      ),);    }
    if (!quizzlerBrain.isFinished()) {
      quizzlerBrain.nextQuestion();
    }
    else {
      quizzlerBrain.reset();
      Alert(
        context: context,
        type: AlertType.success,
        title: "GAME OVER",
        desc: "You answered to all of the questions",
        buttons: [
          DialogButton(
            child: const Text(
              "Play again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
            scoreKeeper = [];
            Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
    });
  }

  QuizzlerBrain quizzlerBrain = QuizzlerBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzlerBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              }
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
