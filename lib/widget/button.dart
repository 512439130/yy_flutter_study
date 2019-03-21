import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//数据传递
//原生&flutter互掉
//常量定义
const String name1 = 'flutter_widget_button';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  //生成MaterialButton
  Container buildButton(String value, Color textColor, Color background, Function clickEvent()) {
    return new Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: new MaterialButton(
        child: Text(value),
        color: background,
        textColor: textColor,
        onPressed: () {
          clickEvent();
        },
      ),
    );
  }

  Function click1(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            buildButton(
                "Button1", Colors.white, Colors.greenAccent, click1("Button1")),
            buildButton(
                "Button2", Colors.white, Colors.redAccent, click1("Button2")),
            buildButton(
                "Button3", Colors.white, Colors.blueAccent, click1("Button3")),
            buildButton(
                "Button4", Colors.white, Colors.green, click1("Button4")),
            buildButton(
                "Button5", Colors.white, Colors.amberAccent, click1("Button5")),
          ],
        ));
  }


}
