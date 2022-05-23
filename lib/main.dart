import 'package:flutter/material.dart';
import 'package:interval_timer/settings_page.dart';
import 'package:interval_timer/button_widget.dart';
import 'package:interval_timer/configs/setting.dart';
import 'dart:async';
import 'dart:developer';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTimerSec = Setting.actionTimeSec;
  String currentTimerPhase = Setting.timerPhase['ready']!;
  int remainingNumberOfTimes = Setting.numberOfRepetitions;

  final logger = Logger();
  Timer? timer;

  _MyHomePageState() {
    setTimer();
  }

  void startTimer(String phase) {
    logger.v('タイマースタート');
    //スタート時のみタイマー設定を初期化する
    if (remainingNumberOfTimes == Setting.numberOfRepetitions) setTimer();
    setState(() => currentTimerPhase = Setting.timerPhase[phase]!);

    if (currentTimerPhase == Setting.timerPhase['action']) {
      setState(() => currentTimerSec = Setting.actionTimeSec);
    } else {
      setState(() => currentTimerSec = Setting.restTimeSec);
    }

    timer = Timer.periodic(Duration(seconds: 1),(_) {
      if (currentTimerSec > 0) {
        setState(() => currentTimerSec--);
      } else {
        // stopTimer(reset: false);
        changeTimerPhase();
      }
    });
  }

  void setTimer() {
    int currentTimerSec = Setting.actionTimeSec;
    String currentTimerPhase = Setting.timerPhase['ready']!;
    int remainingNumberOfTimes = Setting.numberOfRepetitions;
  }

  //残り回数が0か1以上か、タイマーフェーズがアクションかレスとかで処理を変える
  void changeTimerPhase() {
    if (remainingNumberOfTimes == 0) finishTimer();

    if (currentTimerPhase == Setting.timerPhase['action']) {
      setState(() {
        currentTimerPhase = Setting.timerPhase['rest']!;
        remainingNumberOfTimes--;
      });
      startTimer('rest');
    } else {
      startTimer('action');
    }
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer?.cancel();
  }

  void finishTimer() {
    timer?.cancel();
  }

  void resetTimer() => setState(() {
    setState(() => currentTimerSec = Setting.actionTimeSec);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Icon(Icons.timer),
        title: Text('Intervalmer'),
        actions: <Widget>[
          SizedBox(
            width: 44,
            child: FlatButton(
              child: Icon(
                      Icons.settings,
                      color: Colors.white),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) =>  SettingsPage()),
                );
              },
            )
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
            '$currentTimerPhase',
             style: TextStyle(
                  fontSize: 40,
             )
            ),
            buildTime(),
            buildButtons(),
          ]
        ),
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null? false: timer!.isActive;
    return isRunning?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          ButtonWidget(
              color: Colors.white,
              text: 'Pause',
              onClicked: () {
                 stopTimer();
              }
          ),
          Spacer(),
          ButtonWidget(
              color: Colors.white,
              text: 'Cancel',
              onClicked: () {
                finishTimer();
              }
          ),
          Spacer(),
        ],
      )
      : ButtonWidget(
        color: Colors.white,
        text: 'Start Button',
        onClicked: () {
          startTimer('action');
        },
      );
  }

  Widget buildTime() {
    return Text(
      '$currentTimerSec',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 60,
      )
    );
  }
}

