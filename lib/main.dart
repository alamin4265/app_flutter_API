import 'package:StudentInformation/View/API_Data.dart';
import 'package:flutter/material.dart';
import 'package:StudentInformation/View/Student_Card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = {
    'StudentCardPage': (context) => StudentCard(),
    'ApiPage': (context) => APIPage()
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Student'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              RaisedButton(
                  child: Text('New Student'),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(StudentCard.tag)),
              RaisedButton(
                  child: Text('Fetch Api Data'),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('ApiPage'))
            ]),
      ),
    );
  }
}
