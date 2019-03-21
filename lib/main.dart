import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Column buildButtonColumn(IconData icon, String label) {
    Color color = Theme
        .of(context)
        .primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new ListView(


          children: <Widget>[


            //Text用法
            //TextStyle属性
            //inherit:默认为true，设置为false时候表示不显示
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
            new Text(
              '大虚线',
              style: new TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.dotted
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
                  decorationStyle: TextDecorationStyle.dashed
              ),
            ),
            new Text(
              '正弦线（波浪线）',
              style: new TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.wavy
              ),
            ),

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

            new Container(
              height: 200,
              margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: new Center(
                child:
                new CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  fadeInCurve: Curves.ease,
                  fadeInDuration:Duration(seconds: 2),
                  fadeOutCurve: Curves.ease,
                  fadeOutDuration:Duration(seconds: 2),
                  imageUrl: 'https://flutter.io/images/homepage/header-illustratio1n.png',
                  placeholder: (context, url) =>new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),

            // 本地文件图片(需要权限)
//            new Image.file(
//                new File("/storage/emulated/0/Download/flutter3.jpeg")),
            // Uint8List图片
//            new Image.memory(bytes),

            titleWidget(),
            centerWidget(),
            bottomWidget(),
          ],
        ));
  }

  Widget centerWidget() {
    return new Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: new Row(
// 1、MainAxisAlignment.start，将子控件放在主轴的起始位置。
// 2、MainAxisAlignment.end，将子控件放在主轴末尾。
// 3、MainAxisAlignment.center，将子控件放在主轴中间位置。
// 4、MainAxisAlignment.spaceBetween 将主轴方向上的空白区域等分，使得子孩子控件之间的空白区域相等，// 两端的子孩子控件都靠近首尾，没有间隙。
// 5、MainAxisAlignment.spaceAround 将主轴方向上的空白区域等分，使得子孩子控件之间的空白区域相等，// 两端的子孩子控件都靠近首尾，首尾子孩子控件的空白区域为1/2。
// 6、MainAxisAlignment.spaceEvenly将主轴方向上的空白区域等分，使得子孩子控件之间的空白区域相等，包括首尾。
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget titleWidget() {
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start, //左对齐
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41'),
        ],
      ),
    );
  }

  Widget bottomWidget() {
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
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




