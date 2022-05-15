import 'package:flutter/material.dart';
import 'package:interval_timer/settings_page.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
        ),
      ),
    );
  }
}

