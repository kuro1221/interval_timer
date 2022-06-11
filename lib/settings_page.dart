import 'package:flutter/material.dart';
import 'package:interval_timer/Singleton.dart';
import 'package:interval_timer/button_widget.dart';
import 'package:interval_timer/Singleton.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: Column(
            children: [
              buildButtons(),
            ]
        ),
      ),
    );
  }
  Widget buildButtons() {
    // final isRunning = timer == null? false: timer!.isActive;
    // if (currentTimerPhase == Setting.timerPhase['ready']) {

      return ButtonWidget(
          color: Colors.white,
          text: 'Start Button',
          onClicked: () {
            test();
          }
      );
    }
  test() {
    Singleton.getInstance();
    print(Singleton.getValue());
    Singleton.setValue();
    print('セット後');
    print(Singleton.getValue());  }
  }

