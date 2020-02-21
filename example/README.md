# livestream Demo

LiveStream is a data holder class which can observe change of data in real-time and emit values too. Here's emitter subscriber pattern. It's developed in pure Dart.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Example Code

***main.dart***

```dart
class _MyHomePageState extends State<MyHomePage> {
  String dateTime = DateTime.now().toString();
  Color textColor = Colors.blue;
  bool _isExecuting = false;
  BackgroundExecute backgroundExecute = new BackgroundExecute();
  LiveStream _liveStream = new LiveStream();

  void _startExecute() {
    if (!_isExecuting) {
      backgroundExecute.execDateTime();
      _isExecuting = true;
    }
    backgroundExecute.execColor();
  }

  void _initLiveStream() {   

    _liveStream.on("dateTime", (value){
      setState(() {
        dateTime = value.toString();
      });
    });
  
    _liveStream.on("text_color", (value){
      setState(() {
        textColor = value;
      });
    });
  }
```

***background.dart***

```dart
class BackgroundExecute {
  LiveStream liveStream = new LiveStream();

  // Periodically emit Current Date & Time at interval of 5 seconds.
  void execDateTime() {
    Timer.periodic(Duration(seconds: 5), (timer) {

      // Emit current date & time to 'dateTime' stream.
      liveStream.emit("dateTime", DateTime.now());
    });
  }

  // Emit random values on execution.
  void execColor() {
    Random random = new Random();

    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);

    liveStream.emit("text_color",  Color.fromRGBO(r, g, b, 1));
  }
}
```
