import 'package:flutter/material.dart';
import 'package:livestream/livestream.dart';
import 'background.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveStream Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LiveStream Demo'),
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
  String dateTime;
  bool _isExecuting = false;
  BackgroundExecute backgroundExecute = new BackgroundExecute();
  LiveStream _liveStream = new LiveStream();

  void _startExecute() {
    if (!_isExecuting) {
      backgroundExecute.execDateTime();
      _isExecuting = true;
    }
    backgroundExecute.execOnce();
  }

  void _initLiveStream() {   

    _liveStream.on("dateTime", (value){
      setState(() {
        dateTime = value;
      });
    });
  
    _liveStream.on("random", (value){
      print("Random Value = $value");
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
              'Current Date & Time :',
            ),
            Text(
              '$dateTime',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: _initLiveStream,
              child: Text("Init Live Stream"),
            ),
            RaisedButton(
              onPressed: _startExecute,
              child: Text("Start Execution"),
            )
          ],
        ),
      ),
    );
  }
}
