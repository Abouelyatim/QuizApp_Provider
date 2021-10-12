import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp01_exo02/questions_state.dart';

import 'question.dart';

void main() {
  runApp(MaterialApp(
    title: "Quiz app",
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuestionsState())
      ],
      child: MaterialApp(
        routes: {"/": (context) => MyQuizPage()},
      ),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({Key? key}) : super(key: key);

  @override
  _MyQuizPageState createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  SnackBar correctAnswer() {
    var snackMessage = "The answer is correct";
    return SnackBar(
      content: Text(snackMessage),
    );
  }

  SnackBar badAnswer() {
    var snackMessage = "Sorry,Try again";
    return SnackBar(
      content: Text(snackMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text("Quiz")),
      body: SafeArea(
        child: Consumer<QuestionsState>(builder: (context, value, child) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.white,
                    child: Image.asset(
                        'images/' + value.questions[value.questionId].image),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          value.questions[value.questionId].question,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ))),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {

                          if (value.questions[value.questionId].answer ==
                              true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(correctAnswer());
                            value.updateQuestions();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(badAnswer());
                          }

                        },
                        child: Text("Vrai")),
                  )),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (value.questions[value.questionId].answer ==
                                false) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(correctAnswer());
                              value.updateQuestions();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(badAnswer());
                            }

                          },
                          child: Text("Faux")))
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      value.updateQuestions();
                    },
                    child: Icon(
                      Icons.arrow_forward,
                    )),
              )
            ],
          ));
        }),
      ),
    );
  }
}

