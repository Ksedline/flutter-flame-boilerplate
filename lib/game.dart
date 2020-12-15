import 'dart:ui' as ui;

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameLogic extends Game with TapDetector {
  bool isClicked = false;
  Size screenSize;
  Paint boxPaint = Paint();
  num count = 0;

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  @override
  void onTapDown(TapDownDetails details) {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double screenCenterX = screenSize.width / 2;
    double screenCenterY = screenSize.height / 2;

    if ((dx >= screenCenterX - 140 && dx <= screenCenterX + 140) &&
        (dy >= screenCenterY - 140 && dy <= screenCenterY + 140)) {
      isClicked = !isClicked;
      count++;
    }
  }

  void render(Canvas canvas) {
    Rect bgRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height); // Background
    Paint bgPaint = Paint();

    double screenCenterX = screenSize.width / 2;
    double screenCenterY = screenSize.height / 2;
    double circleRadius = 140.0;

    ui.ParagraphStyle style = ui.ParagraphStyle(textAlign: TextAlign.center);
    ui.ParagraphBuilder pgBuilder = ui.ParagraphBuilder(style);
    ui.TextStyle textStyle;

    if (isClicked) {
      bgPaint.color = Color(0xff121212);
      boxPaint.color = Color(0xff00ff00);
      textStyle = ui.TextStyle(color: Colors.black, fontSize: 30);
    } else {
      bgPaint.color = Color(0xff00ff00);
      boxPaint.color = Color(0xff121212);
      textStyle = ui.TextStyle(color: Colors.green, fontSize: 30);
    }

    pgBuilder
      ..pushStyle(textStyle)
      ..addText('Touch me')
      ..addText('\r\n ${count > 0 ? count : ''}');

    ui.Paragraph paragraph = pgBuilder.build()
      ..layout(ui.ParagraphConstraints(width: 150));

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
