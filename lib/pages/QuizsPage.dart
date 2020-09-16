import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/pages/QuestionsBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizsPage extends StatefulWidget {
  @override
  _QuizsPageState createState() => _QuizsPageState();
}

class _QuizsPageState extends State<QuizsPage> {
  List<Icon> scoreKeeper = [];
  QuestionsBank questionsBankObj = QuestionsBank();
  int quesNum = 0;
  bool buttonDisable = true;
  int resultScore = 0;

  @override
  Widget build(BuildContext context) {
    //for full Screen
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: Center(
                    child: Text(
                  buttonDisable == true
                      ? questionsBankObj.questions[quesNum].question
                      : 'Quiz is End!!',
                  style: TextStyle(
                      fontSize: 25, color: Colors.white, fontFamily: 'google'),
                ))),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.green,
                  onPressed: buttonDisable == true
                      ? () {
                          checkAnswer(true);
                        }
                      : () {},
                  child: Text(
                    buttonDisable == true ? 'True' : 'Quiz is End!!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'google'),
                  )),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.red,
                  onPressed: buttonDisable == true
                      ? () {
                          checkAnswer(false);
                        }
                      : () {},
                  child: Text(
                    buttonDisable == true ? 'False' : 'Quiz is End!!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'google'),
                  )),
            )),
            buttonDisable == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                              child: FlatButton(
                                  onPressed: () {
                                    finishAlert();
                                  },
                                  color: Colors.blue,
                                  child: Text('Result',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'google',
                                          fontSize: 20.0))),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      buttonDisable = true;
                                      quesNum = 0;
                                      resultScore = 0;
                                    });
                                  },
                                  color: Colors.orange,
                                  child: Text(
                                    'Restart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'google',
                                        fontSize: 20.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FlatButton(
                            color: Colors.indigo,
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: Text(
                              'Exit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'google',
                                  fontSize: 20.0),
                            )),
                      )
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  void finishAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'google',
          color: Colors.blue),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titleStyle:
          TextStyle(color: Colors.red, fontFamily: 'google', fontSize: 25),
      alertAlignment: Alignment.topCenter,
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Congratulations!",
      desc: "Your Score is $resultScore/${questionsBankObj.questions.length}.",
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'google'),
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return ResultScore(resultScore);
            //   },
            // ));
          },
          color: Colors.indigo,
          radius: BorderRadius.circular(5.0),
        ),
        // DialogButton(
        //   child: Text(
        //     "Restart",
        //     style: TextStyle(
        //         color: Colors.white, fontSize: 20, fontFamily: 'google'),
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       resultScore = 0;
        //       quesNum = 0;
        //       Navigator.pop(context);
        //     });
        //   },
        //   color: Colors.red,
        //   radius: BorderRadius.circular(5.0),
        // ),
      ],
    ).show();
  }

  void checkAnswer(bool userSelected) {
    AudioCache audioCachePlayer = AudioCache();

    setState(() {
      if (questionsBankObj.questions[quesNum].ans == userSelected) {
        resultScore++;
        audioCachePlayer.play('success.wav');
      } else {
        audioCachePlayer.play('error.mp3');
      }
      nextQuestionCheck();
    });
  }

  void nextQuestionCheck() {
    if (quesNum < questionsBankObj.questions.length - 1) {
      quesNum++;
    } else {
      setState(() {
        buttonDisable = false;
      });
    }
  }
}
