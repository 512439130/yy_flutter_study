import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/network/network.dart';
import 'package:flutter_layout_test/other/other.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_layout_test/widget/button.dart';
import 'package:flutter_layout_test/widget/image.dart';
import 'package:flutter_layout_test/widget/layout.dart';
import 'package:flutter_layout_test/widget/text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//常量定义
const String name1 = 'flutter_widget';
const String taskTitle = 'Flutter Test Layout Title';

//主函数
void main() {
  //MaterialApp组件渲染后
  //run main
  runApp(MyApp());
  //判断如果是Android版本的话 设置Android状态栏透明沉浸式
  checkPhoneType();
}

//判断如果是Android版本的话 设置Android状态栏透明沉浸式
void checkPhoneType() {
  if (Platform.isAndroid) {
    print('devices is Android');
    //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  } else if (Platform.isIOS) {
    print('devices is iOS');
  }
}

class MyApp extends StatelessWidget {
  //StatelessWidget
  //接收外部数据
  //执行部件构造方法
  //当传入数据改变时会重新渲染UI

  //变化需要重新创建
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: taskTitle, //唤出任务管理器title
      theme: new ThemeData(
        //状态栏颜色
        primaryColor: Colors.greenAccent,
        accentColor: const Color(0xFF00FFFF),
        hintColor: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        // 定义静态路由，不能传递参数
        '/router/refresh/refresh': (_) => new RefreshWidget(),
        '/router/widget/text': (_) => new TextWidget(),
        '/router/widget/image': (_) => new ImageWidget(),
        '/router/widget/button': (_) => new ButtonWidget(),
        '/router/widget/layout': (_) => new LayoutWidget(),
        '/router/ohter/ohter': (_) => new OtherWidget(),
        '/router/network/network': (_) => new NetworkWidget(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  //StatefulWidget
  //接收外部数据
  //执行部件构造方法和状态初始化方法
  //当传入数据和本类数据改变时都会重新渲染UI
  //如果您希望通过HTTP动态请求的数据更改用户界面，则必须使用StatefulWidget，并告诉Flutter框架该widget的状态已更新，以便可以更新该widget。
  //setState触发UI重绘

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lineText = "大虚线";

  //生成MaterialButton
  MaterialButton buildButton(String value, Color textColor, Color background,
      String route) {
    return new MaterialButton(
      child: Text(value),
      color: background,
      textColor: textColor,
      onPressed: () {
        openView(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(), //回弹效果
          children: <Widget>[
            buildButton("RefreshWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/refresh/refresh'),
            buildButton("TextWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/widget/text'),
            buildButton("ImageWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/widget/image'),
            buildButton("ButtonWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/widget/button'),
            buildButton("LayoutWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/widget/layout'),
            buildButton("OtherWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/ohter/ohter'),
            buildButton("NetworkWidget", Colors.white, Colors.deepOrangeAccent,
                '/router/network/network'),
          ],
        ));
  }

  openView(String route) {
    Navigator.of(context).pushNamed(route);
  }
}

//需要注意的细节点
//如果需要使用新库，先在pubspec.yaml中导包，（如果不知道包名就在"https://pub.flutter-io.cn/packages"搜索），
//例如：cached_network_image: ^0.7.0  (需要注意格式，缩进问题，避免使用TAB,空格最保险)

//所有布局widget都有一个child属性，部分widget拥有children属性（Row，Column，ListView，Stack）

//使用Container(Widget)包裹后:添加填充，边距，边框或背景色

//Scaffold实现了基本的 Material 布局
//Scaffold 提供展示抽屉（drawers，比如：左边栏）、通知（snack bars） 以及 底部按钮（bottom sheets）
//Scaffold属性说明：
//appBar：显示在界面顶部的一个 AppBar
//body：当前界面所显示的主要内容
//floatingActionButton： 在 Material 中定义的一个功能按钮。
//persistentFooterButtons：固定在下方显示的按钮。https://material.google.com/components/buttons.html#buttons-persistent-footer-buttons
//drawer：侧边栏控件
//bottomNavigationBar：显示在底部的导航栏按钮栏。可以查看文档：Flutter学习之制作底部菜单导航
//backgroundColor：背景颜色
//resizeToAvoidBottomPadding： 控制界面内容 body是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true。




