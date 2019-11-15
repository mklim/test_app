import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';
import 'package:flutter/material.dart';

const String _examplePackage = 'com.example.test_app';

void main() => runApp(FirstApp());

void secondary() => runApp(SecondaryApp());

class FirstApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', first: true),
    );
  }
}

class SecondaryApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', first: false),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.first}) : super(key: key);

  final String title;

  final bool first;

  @override
  _MyHomePageState createState() => _MyHomePageState(first);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final bool first;
  _MyHomePageState(this.first);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              if (first) ...<Widget>[
                RaisedButton(
                  onPressed: () async {
                    if (!Platform.isAndroid) {
                      return;
                    }

                    await AndroidIntent(
                        action: 'action_view',
                        package: _examplePackage,
                        componentName: '$_examplePackage.SecondaryActivity',
                        flags: <int>[
                          Flag.FLAG_ACTIVITY_LAUNCH_ADJACENT,
                          Flag.FLAG_ACTIVITY_NEW_TASK,
                          Flag.FLAG_ACTIVITY_MULTIPLE_TASK
                        ]).launch();
                  },
                  child: Text('Launch Secondary Activity'),
                )
              ],
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
