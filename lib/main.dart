import 'package:country_flags_app/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double zorluk = 2.0;
  var difficulties = ["Easy", "Medium", "Hard"];
  String difficulty = "Medium";
  double question_number = 5.0;
  double question_second = 10.0;
  bool switchbutton = true;

  @override
  Widget build(BuildContext context) {
    var ekranbilgisi = MediaQuery.of(context);
    final double e_height = ekranbilgisi.size.height;
    final double e_width = ekranbilgisi.size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/back3.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: e_height/15, left: 13, right: 13),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 50.0),
                              child: Text(
                                "COUNTRY FLAGS",
                                style: TextStyle(
                                  fontSize: e_width /8,
                                  fontFamily: "ConcertOne",
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 10
                                    ..color = Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "COUNTRY FLAGS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: e_width / 8,
                                  fontFamily: "ConcertOne",
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 3),

                      ),

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Difficulty = ${difficulty}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: e_width / 14,
                                fontFamily: "ConcertOne",
                              ),
                            ),
                          ),
                          Slider(
                            max: 3.0,
                            min: 1.0,
                            value: zorluk,
                            activeColor: Color(0xff0030b4),
                            inactiveColor: Colors.grey,
                            onChanged: (double i) {
                              setState(() {
                                zorluk = i.ceilToDouble();
                                difficulty = difficulties[zorluk.toInt() - 1];
                              });
                            },
                          ),
                          Text(
                            "Number of questions = ${question_number.toInt()}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: e_width / 14,
                              //fontWeight: FontWeight.bold,
                              fontFamily: "ConcertOne",
                            ),
                          ),
                          Slider(
                            max: 7.0,
                            min: 3.0,
                            value: question_number,
                            activeColor: Color(0xff4e7dec),
                            inactiveColor: Colors.grey,
                            onChanged: (double i) {
                              setState(() {
                                question_number = i.ceilToDouble();
                              });
                            },
                          ),
                          Visibility(
                            visible: switchbutton,
                            child: Text(
                              "Seconds per question = ${question_second.toInt()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: e_width / 14,
                                //fontWeight: FontWeight.bold,
                                fontFamily: "ConcertOne",
                              ),
                            ),
                          ),
                          Visibility(
                            visible: switchbutton,
                            child: Slider(
                              max: 13.0,
                              min: 7.0,
                              value: question_second,
                              activeColor: Color(0xff0030b4),
                              inactiveColor: Colors.grey,
                              onChanged: (double i) {
                                setState(() {
                                  question_second = i.ceilToDouble();
                                });
                              },
                            ),
                          ),
                          Text(
                            "Time",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: e_width / 14,
                              //fontWeight: FontWeight.bold,
                              fontFamily: "ConcertOne",
                            ),
                          ),
                          Switch(value: switchbutton,
                              activeColor: Color(0xff0030b4),
                              activeTrackColor: Color(0xff4e7dec),
                              inactiveThumbColor: Colors.black54,
                              inactiveTrackColor: Colors.grey.shade400,
                              onChanged: (veri){
                                setState(() {
                                  switchbutton=veri;
                                });
                              }),


                          InkWell(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Game(question_number, difficulty,question_second.toInt(),switchbutton)));
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.red, Colors.blue],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                      fontSize: e_width / 14,
                                      fontFamily: "ConcertOne",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
