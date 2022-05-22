import 'package:flutter/material.dart';
import 'package:interval_timer/settings_page.dart';
import 'package:interval_timer/button_widget.dart';
import 'dart:async';
import 'dart:developer';


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
  int actionTimeSec = 5;
  int restTimeSec = 3;
  int numberOfRepetitions = 3;

  int currentTimerSec = 0;
  Map<String, String> timerPhase = {'action' : 'Action', 'rest': 'Rest'};
  // String currentTimerPhase = 'action';
  String currentTimerPhase = '';

  Timer? timer;
  void startTimer() {
    currentTimerSec = actionTimeSec;
    currentTimerPhase = timerPhase['action'];
    timer = Timer.periodic(Duration(seconds: 1),(_) {
      if (currentTimerSec > 0) {
        setState(() => currentTimerSec--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void changeTimerPhase() {
    if (numberOfRepetitions > 0) {
      // timerPhase = timerPhase == 'Action'? 'Rest': 'Action';
    }
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer?.cancel();
  }

  void resetTimer() => setState(() {
    currentTimerSec = actionTimeSec;
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
            // Text(timerPhase),
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
        children: [
          ButtonWidget(
              color: Colors.white,
              text: 'Pause',
              onClicked: () {
                 stopTimer();
              }
          ),
          ButtonWidget(
              color: Colors.white,
              text: 'Cancel',
              onClicked: () {
                stopTimer();
              }
          ),
        ],
      )
      : ButtonWidget(
        color: Colors.white,
        text: 'Start Button',
        onClicked: () {
          startTimer();
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

