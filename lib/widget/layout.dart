import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//布局构建（垂直排列，水平排列）  go on
//线性布局Row和Column
//弹性布局Flex(类似weight)
//流式布局Wrap,Flow
//层叠布局Stack,Positioned
const String name1 = 'flutter_widget_layout';

class LayoutWidget extends StatefulWidget {
  LayoutWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}
class _LayoutWidgetState extends State<LayoutWidget> {

  Color textColor = Colors.black;
  Color textHighLightColor = Colors.cyanAccent;
  Color textHintColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(top: 15.0),

                child:new Row(
                  mainAxisSize: MainAxisSize.min, //聚集包含的widgets
                  //MainAxisAlignment:主轴的对齐方式
                  //Column（纵向排列）  主轴为垂直轴
                  //row（横向排列）   主轴为水平轴
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    buildTextRow('Row1',textColor,16,FontWeight.w500,10,2),
                    buildTextRow('Row2',textHighLightColor,14,FontWeight.w500,2,10),
                    buildTextRow('Row3',textHintColor,12,FontWeight.normal,0,0),
                  ],
                ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 15.0),
              child:new Column(
                mainAxisSize: MainAxisSize.min, //聚集包含的widgets
                //MainAxisAlignment:主轴的对齐方式
                //Column（纵向排列）  主轴为垂直轴
                //row（横向排列）   主轴为水平轴
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextColumn('Column标准字体颜色，16字体，粗体型号为W500，字符间距为10，单词间距为2 test android',textColor,16,FontWeight.w500,10,2),
                  buildTextColumn('Column高亮字体他颜色，14字体，粗体型号为W200，字符间距为2，单词间距为10 test android',textHighLightColor,14,FontWeight.w500,2,10),
                  buildTextColumn('Column提示字体颜色，12字体，粗体型号为0，字符间距为0，单词间距为0 test android',textHintColor,10,FontWeight.normal,0,0),
                ],
              ),
            ),




          ],
        ));
  }

  //模板化生成TextColumn
  //String value(文本),Color color(字体颜色),MainAxisSize size(字体大小),FontWeight fontWeight(粗体型号),double letterSpacing:(字符间距),double wordSpacing:(单词间距)
  Column buildTextColumn(String value, Color color, double fontSize,
      FontWeight fontWeight, double letterSpacing, double wordSpacing) {
    return new Column(
      //MainAxisSize
      mainAxisSize: MainAxisSize.min, //聚集包含的widgets
          //MainAxisAlignment:主轴的对齐方式
          //Column（纵向排列）  主轴为垂直轴
          //row（横向排列）   主轴为水平轴
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: new Text(
            value,
            style: new TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
            ),
          ),
        ),
      ],
    );
  }

  //模板化生成TextRow
  //String value(文本),Color color(字体颜色),MainAxisSize size(字体大小),FontWeight fontWeight(粗体型号),double letterSpacing:(字符间距),double wordSpacing:(单词间距)
  Row buildTextRow(String value, Color color, double fontSize,
      FontWeight fontWeight, double letterSpacing, double wordSpacing) {
    return new Row(
      //MainAxisSize
      mainAxisSize: MainAxisSize.min, //聚集包含的widgets
      //MainAxisAlignment:主轴的对齐方式
      //Column（纵向排列）  主轴为垂直轴
      //row（横向排列）   主轴为水平轴
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: new Text(
            value,
            style: new TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
            ),
          ),
        ),
      ],
    );
  }
}
