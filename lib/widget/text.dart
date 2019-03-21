import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//常量定义
const String name1 = 'flutter_widget_text';

class TextWidget extends StatefulWidget {
  TextWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool isTestVisible = true; //控制组件隐藏
  String lineText = "大虚线";
  Color textColor = Colors.black;
  Color textHighLightColor = Colors.cyanAccent;
  Color textHintColor = Colors.black12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            //Text用法
            //TextStyle属性
            //inherit:默认为true，是否继承 color 字体颜色
            //color:字体颜色
            //fontSize:字体大小，默认是14.0的
            //fontWeight:字体的粗体
            //fontStyle:normal正常:italic 斜体
            //letterSpacing:字符间距
            //wordSpacing:单词间距
            //textBaseline:
            // alphabetic：用于对齐字母字符底部的水平线
            // ideographic：用于对齐表意字符的水平线
            //height:用在Text控件上的时候，会乘以fontSize做为行高
            //locale:国际化
            //foreground:用paint来渲染text，也可以用他来改变字体颜色等
            //background:背景
            //decoration:辅助线的添加规则
            //none:不添加
            //underline:在每行文本下面画一条线
            //overline:在每行文本上方画一条线
            //lineThrough:在每行文字中画一条线
            //decorationColor:辅助线的颜色
            //decorationStyle:辅助线的样式
            //solid:画一条实线
            //double:画两条线
            //dotted:画一条大虚线
            //dashed:画一条小虚线
            //wavy:画一条正弦线（波浪线）
            //fontFamily:自定义字体时需要使用

            new Offstage(
              //使用Offstage 控制widget在tree中的显示和隐藏
              offstage: isTestVisible,
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
            new Text(
              '小虚线',
              style: new TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            new Text(
              '正弦线（波浪线）',
              style: new TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.wavy),
            ),


          ],
        ));
  }
}
