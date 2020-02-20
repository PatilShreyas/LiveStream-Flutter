import 'dart:async';
import 'dart:math';
import 'package:livestream/livestream.dart';

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
  void execOnce() {
      liveStream.emit("random", new Random().nextInt(1000));
  }
}
