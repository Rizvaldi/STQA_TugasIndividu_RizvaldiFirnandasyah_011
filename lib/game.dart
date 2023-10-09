import 'dart:async';
import 'dart:collection';
//import 'dart:html';

import 'package:country_flags_app/flags.dart';
import 'package:country_flags_app/flagsDAO.dart';
import 'package:country_flags_app/last.dart';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Game extends StatefulWidget {
  double question_number;
  String difficulty;
  int second;
  bool time_control;

  Game(this.question_number, this.difficulty,this.second,this.time_control,{super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<Flags> questions = [];
  List<Flags> wrongQuestions = [];
  List<bool> trueFalseAll = [];
  late Flags trueQuestion;
  var allAnswers = HashSet<Flags>();

  int questionNumber = 0;
  int trueNumber = 0;
  int falseNumber = 0;

  String flagImage = "placeholder.png";
  String buttonA = "";
  String buttonB = "";
  String buttonC = "";
  String buttonD = "";
  late int realTime;

  @override
  void initState() {
    realTime = widget.second;
    getQuestions();
    if(widget.time_control){
      Timer.periodic(Duration(seconds: 1), (timer) {
        if(realTime>0){
          setState(() {
            realTime--;
          });
        }else{
          trueFalseCheck("wrong");
          questionNumberCheck();
        }
      });
    }
    super.initState();
  }

  Future<void> getQuestions() async {
    questions = await FlagsDAO()
        .getQuestions(widget.difficulty, widget.question_number.toInt());
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    realTime = widget.second;
    trueQuestion = questions[questionNumber];
    wrongQuestions = await FlagsDAO()
        .getWrongQuestions(widget.difficulty, trueQuestion.flagId);

    flagImage = trueQuestion.flagImage;

    allAnswers.clear();
    allAnswers.add(wrongQuestions[0]);
    allAnswers.add(wrongQuestions[1]);
    allAnswers.add(wrongQuestions[2]);
    allAnswers.add(trueQuestion);
    buttonA = allAnswers.elementAt(0).flagName;
    buttonB = allAnswers.elementAt(1).flagName;
    buttonC = allAnswers.elementAt(2).flagName;
    buttonD = allAnswers.elementAt(3).flagName;

    setState(() {});
  }

  void questionNumberCheck() {
    questionNumber++;
    if (questionNumber != widget.question_number) {
      loadQuestions();
    } else {
      Navigator.pushReplacement(
          this.context,
          MaterialPageRoute(
              builder: (context) => Last(questions, trueFalseAll, trueNumber,
                  falseNumber, widget.difficulty)));
    }
  }

  void trueFalseCheck(String buttonString) {
    if (trueQuestion.flagName == buttonString) {
      setState(() {
        trueNumber++;
        trueFalseAll.add(true);
      });
    } else {
      setState(() {
        falseNumber++;
        trueFalseAll.add(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/back4.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.check,
                              size: 60,
                              color: Colors.green.shade700,
                            ),
                            Text(
                              "$trueNumber",
                              style: TextStyle(
                                fontSize: 33,
                                color: Colors.white,
                                fontFamily: "Kanit",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.time_control,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: new CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 8.0,
                          percent: (widget.second-realTime)/widget.second,
                          center: new Text(
                            "${realTime}",
                            style: TextStyle(
                              fontFamily: "Kanit",
                                fontSize: 35, color: Colors.deepPurple.shade300),
                          ),
                          progressColor: Colors.deepPurple.shade300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.close,
                              size: 60,
                              color: Colors.red.shade700,
                            ),
                            Text(
                              "$falseNumber",
                              style: TextStyle(
                                fontSize: 33,
                                color: Colors.white,
                                fontFamily: "Kanit",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 17),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //border: Border.all(color: Colors.black54, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                spreadRadius: 2)
                          ],
                        ),
                        child: Image.asset(
                          "images/${widget.difficulty.toLowerCase()}/${flagImage}",
                        ),
                        height: 230,
                        width: 230,
                      ),
                    ),
                    Container(
                      width: 350,
                      child: InkWell(
                        onTap: () {
                          trueFalseCheck(buttonA);
                          questionNumberCheck();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$buttonA",
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: "Kanit",
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 350,
                        child: InkWell(
                          onTap: () {
                            trueFalseCheck(buttonB);
                            questionNumberCheck();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$buttonB",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Kanit",
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 350,
                        child: InkWell(
                          onTap: () {
                            trueFalseCheck(buttonC);
                            questionNumberCheck();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$buttonC",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Kanit",
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 350,
                        child: InkWell(
                          onTap: () {
                            trueFalseCheck(buttonD);
                            questionNumberCheck();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$buttonD",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Kanit",
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ]


                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
