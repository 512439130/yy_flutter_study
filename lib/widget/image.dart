import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//常量定义
const String name1 = 'flutter_widget_image';

class ImageWidget extends StatefulWidget {
  ImageWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
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
            //Image用法
            //加载网络图片：Image.network
            //加载资源图片：Image.asset
            //加载本地图片：Image.file
            //加载资源图片：Image.asset
            //加载Uint8List资源图片：Image.memory
            //fit：BoxFit用法
            //BoxFit.fill：全图显示，显示可能拉伸，充满
            //BoxFit.contain：全图显示，显示原比例，不需充满
            //BoxFit.cover：显示可能拉伸，可能裁剪，充满
            //BoxFit.fitWidth：显示可能拉伸，可能裁剪，宽度充满
            //BoxFit.fitHeight：显示可能拉伸，可能裁剪，高度充满
            //BoxFit.none：不指定
            //BoxFit.scaleDown：效果和contain差不多,但是此属性不允许显示超过源图片大小，可小不可大


            new Container(
              height: 200,
              margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: new Center(
                child: new CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  fadeInCurve: Curves.ease,
                  fadeInDuration: Duration(seconds: 4),
                  fadeOutCurve: Curves.ease,
                  fadeOutDuration: Duration(seconds: 2),
                  imageUrl:
                  'https://flutter.io/images/homepage/header-illustration.png',
                  placeholder: (context, url) =>
                  new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),

            // 本地文件图片(需要权限)
//            new Image.file(
//                new File("/storage/emulated/0/Download/flutter3.jpeg")),
            // Uint8List图片
//            new Image.memory(bytes),
            new Image.asset(
              'images/flutter.jpg',
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
            new Image.asset(
              'images/flutter.jpg',
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              //color&colorBlendMode配合使用（混合模式）
              color: Colors.redAccent,
              colorBlendMode: BlendMode.colorBurn,
            ),
            new Image.asset(
              'images/flutter2.jpg',
              fit: BoxFit.fitWidth,
              //alignment：摆放位置
              alignment: Alignment.center,
            ),

            //CachedNetworkImage用法(如果这个图片已经被加载了，或者已经存在内存中，那么placeholder图片将不会显示)
            //fit:同上
            //fadeInCurve:  淡入动画(曲线)
            //fadeInDuration:  淡入动画时间
            //fadeOutCurve: 淡出动画(曲线)
            //fadeOutDuration: 淡出动画时间
            //imageUrl: 网络图片地址
            //placeholder: 占位图地址（可以使用加载进度条）
            //errorWidget: 错误图地址

            //Curves用法:


          ],
        ));
  }
}
