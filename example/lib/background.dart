import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
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
  void execColor() {
    Random random = new Random();

    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);

    liveStream.emit("text_color", Color.fromRGBO(r, g, b, 1));
  }
}
