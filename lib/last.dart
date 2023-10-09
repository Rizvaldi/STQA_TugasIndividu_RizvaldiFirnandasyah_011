import 'package:flutter/material.dart';

import 'flags.dart';

class Last extends StatefulWidget {
  List<Flags> questions;
  List<bool> trueFalseAll;
  int trueNumber;
  int falseNumber;
  String difficulty;

  Last(this.questions, this.trueFalseAll, this.trueNumber, this.falseNumber,
      this.difficulty,
      {super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  bool successControl() {
    if (widget.trueNumber <= widget.falseNumber) {
      return false;
    } else {
      return true;
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
              image: AssetImage("images/backlas.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Text(
                          successControl() ? "SUCCESSFUL !" : "UNSUCCESSFUL !",
                          style: TextStyle(
                            fontSize: 42,
                            fontFamily: "Kanit",
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.black26,
                          ),
                        ),
                        Text(
                          successControl() ? "SUCCESSFUL !" : "UNSUCCESSFUL !",
                          style: TextStyle(
                              color: successControl()? Colors.green:Colors.red,
                              fontSize: 42,
                              fontFamily: "Kanit"),
                        ),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 3),
                                  blurRadius: 1,
                                  //blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 165,
                                  child: Text(
                                    "CORRECT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30,
                                      fontFamily: "Kanit",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 165,
                                  child: Text(
                                    "${widget.trueNumber}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 40,
                                      fontFamily: "Kanit",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 3),
                                  blurRadius: 1,
                                  //blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 165,
                                  child: Text(
                                    "WRONG",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontFamily: "Kanit",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 145,
                                  child: Text(
                                    "${widget.falseNumber}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 40,
                                      fontFamily: "Kanit",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 360,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 3),
                            blurRadius: 1,
                            //blurStyle: BlurStyle.inner,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListView.builder(
                          itemCount: widget.questions.length,
                          itemBuilder: (context, indeks) {
                            var flag = widget.questions[indeks];
                            return Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:  widget.trueFalseAll[indeks] ? Colors.green : Colors.red,
                                      offset: Offset(1,3)
                                    )
                                  ]
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                        widget.trueFalseAll[indeks]
                                            ? Icons.check
                                            : Icons.close,
                                        size: 30,
                                        color:  widget.trueFalseAll[indeks] ? Colors.green:Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${indeks + 1}.",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/20,
                                            fontFamily: "Kanit",
                                            color: Colors.black54),
                                      ),
                                    ),
                                    Text(
                                      "${flag.flagName}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width/20,
                                          fontFamily: "Kanit",
                                          color: Colors.black54),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        height: 75,
                                        child: Image.asset(
                                            "images/${widget.difficulty.toLowerCase()}/${flag.flagImage}"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blueGrey, Colors.grey.shade900],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(13),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 3),
                              blurRadius: 1,
                              //blurStyle: BlurStyle.inner,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "TRY AGAIN",style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Kanit",
                            color: Colors.white,
                          ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
