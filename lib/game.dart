import 'dart:ui' as ui;

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameLogic extends Game {
  bool isClicked = false;
  Size screenSize;
  Paint boxPaint = Paint();

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    isClicked = !isClicked;
  }

  void render(Canvas canvas) {
    Rect bgRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height); // Background
    Paint bgPaint = Paint();

    double screenCenterX = screenSize.width / 2;
    double screenCenterY = screenSize.height / 2;
    double circleRadius = 140.0;

    ui.ParagraphStyle style = ui.ParagraphStyle();
    ui.ParagraphBuilder pgBuilder = ui.ParagraphBuilder(style);

    ui.TextStyle textStyle = ui.TextStyle(color: Colors.white, fontSize: 30);

    pgBuilder
      ..pushStyle(textStyle)
      ..addText('Touch me');

    ui.Paragraph paragraph = pgBuilder.build()
      ..layout(ui.ParagraphConstraints(width: 140));

    if (isClicked) {
      bgPaint.color = Color(0xff121212);
      boxPaint.color = Color(0xff00ff00);
    } else {
      bgPaint.color = Color(0xff00ff00);
      boxPaint.color = Color(0xff121212);
    }

    canvas.drawRect(bgRect, bgPaint);
    canvas.drawCircle(
        Offset(screenCenterX, screenCenterY), circleRadius, boxPaint);
    canvas.drawParagraph(
        paragraph,
        Offset(screenCenterX - paragraph.width / 2,
            screenCenterY - paragraph.height / 2));
  }

  void update(double t) {}
}
