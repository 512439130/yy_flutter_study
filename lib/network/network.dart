import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//网络请求（数据加载）
//常量定义
const String name1 = 'flutter_widget_network';

class NetworkWidget extends StatefulWidget {
  NetworkWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NetworkWidgetState createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  String lineText = "这是一个文本行";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            buildButton("模拟网络请求", Colors.white, Colors.greenAccent, buttonClick1),
            new Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: new Offstage(
                //使用Offstage 控制widget在tree中的显示和隐藏
                offstage: false,
                child: new Text(
                  lineText,
                  style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationStyle: TextDecorationStyle.dotted),
                ),
              ),
            ),
          ],
        ));
  }
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

  Function buttonClick1() {
    setState(() {
      //网络请求后改变数值
      lineText = "这是网络请求后的数据";
    });
  }
}
