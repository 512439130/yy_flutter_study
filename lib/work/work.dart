import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

//常量定义
const String name1 = '拒绝审批';
List<String> list = new List();

List<Widget> listWidget = new List();

class WorkWidget extends StatefulWidget {
  WorkWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WorkWidgetState createState() => _WorkWidgetState();
}

class _WorkWidgetState extends State<WorkWidget> {
  final TextEditingController _textFieldController =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  //初始化
  void init() {
    setList();
  }

  void setList() {
    list.add(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=80538588,251590437&fm=26&gp=0.png');
    list.add(
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4001410800,1923890559&fm=26&gp=0.png');
    list.add(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3597303668,2750618423&fm=26&gp=0.png');
    list.add(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=61077523,1715146142&fm=26&gp=0.png');
    list.add(
        'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4087213632,1096565806&fm=26&gp=0.png');

    for (int i = 0; i < list.length; i++) {
      listWidget.add(networkImage(list[i], BoxFit.cover));
    }
  }

  Widget networkImage(String url, BoxFit fit) {
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,

      children: <Widget>[
        new Container(
            alignment: Alignment.center,
            color: Colors.greenAccent,
            child: getNetImage(false, url, fit)),
        Positioned(
          right: 0,
          top: 0,
          child: getDeleteIcon(),
        )
      ],
    );
  }

  Widget localImage(String path, BoxFit fit) {
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,
      children: <Widget>[
        new Container(
            color: const Color(0xFFF7F8FA),
            padding: const EdgeInsets.all(15),
            child: getLocalImage(path, fit)),
      ],
    );
  }

  Widget getLocalImage(String path, BoxFit fit) {
    return new GestureDetector(
      onTap: () {
        addImage('onTap');
      },
      onTapUp: (d) {
        addImage('onTapUp');
      },
      onTapDown: (d) {
        addImage('onTapDown');
        //调用replace
      },
      onTapCancel: () {
//        replace('onTapCancel');
      },
      onDoubleTap: () {
//        replace('onDoubleTap');
      },
//      //手指按下时会触发此回调
//      onPanDown: (DragDownDetails e) {
//        //打印手指按下的位置(相对于屏幕)
//        print("用户手指按下：${e.globalPosition}");
//      },
//      //手指滑动时会触发此回调
//      onPanUpdate: (DragUpdateDetails e) {
//        //用户手指滑动时，更新偏移，重新构建
//
//        print("用户手指按下dx：${e.delta.dx}");
//        print("用户手指按下dy：${e.delta.dy}");
//      },
//      onPanEnd: (DragEndDetails e){
//        //打印滑动结束时在x、y轴上的速度
//        print(e.velocity);
//      },

      child: new Image.asset(
        path,
        width: 30,
        height: 30,
        fit: BoxFit.fitWidth,
        //alignment：摆放位置
//        alignment: Alignment.center,
      ),
    );
  }

  Widget getNetImage(bool offstage, String url, BoxFit fit) {
    return new GestureDetector(
      onTap: () {
        replace('onTap');
      },
      onTapUp: (d) {
        replace('onTapUp');
      },
      onTapDown: (d) {
        replace('onTapDown');
        //调用replace
      },
      onTapCancel: () {
//        replace('onTapCancel');
      },
      onDoubleTap: () {
//        replace('onDoubleTap');
      },
//      //手指按下时会触发此回调
//      onPanDown: (DragDownDetails e) {
//        //打印手指按下的位置(相对于屏幕)
//        print("用户手指按下：${e.globalPosition}");
//      },
//      //手指滑动时会触发此回调
//      onPanUpdate: (DragUpdateDetails e) {
//        //用户手指滑动时，更新偏移，重新构建
//
//        print("用户手指按下dx：${e.delta.dx}");
//        print("用户手指按下dy：${e.delta.dy}");
//      },
//      onPanEnd: (DragEndDetails e){
//        //打印滑动结束时在x、y轴上的速度
//        print(e.velocity);
//      },
      child: new Offstage(
        //使用Offstage 控制widget在tree中的显示和隐藏
        offstage: offstage,
        child: new Container(
          padding: const EdgeInsets.all(0),
          child: new CachedNetworkImage(
          width: 60,
          height: 60,

            fit: fit,
            fadeInCurve: Curves.ease,
            fadeInDuration: Duration(seconds: 2),
            fadeOutCurve: Curves.ease,
            fadeOutDuration: Duration(seconds: 1),
            imageUrl: url,
//        placeholder: (context, url) => Image(image: AssetImage('images/icon_image_default.png')),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget getDeleteIcon() {
    return new GestureDetector(
      onTap: () {
        delete('onTap');
      },
      onTapUp: (d) {
        delete('onTapUp');
      },
      onTapDown: (d) {
        delete('onTapDown');
        //调用delete
      },
      onTapCancel: () {
//        delete('onTapCancel');
      },
      onDoubleTap: () {
//        delete('onDoubleTap');
      },

//      //手指按下时会触发此回调
//      onPanDown: (DragDownDetails e) {
//        //打印手指按下的位置(相对于屏幕)
//        print("用户手指按下：${e.globalPosition}");
//      },
//      //手指滑动时会触发此回调
//      onPanUpdate: (DragUpdateDetails e) {
//        //用户手指滑动时，更新偏移，重新构建
//
//        print("用户手指按下dx：${e.delta.dx}");
//        print("用户手指按下dy：${e.delta.dy}");
//      },
//      onPanEnd: (DragEndDetails e){
//        //打印滑动结束时在x、y轴上的速度
//        print(e.velocity);
//      },
      child: Image.asset(
        'images/icon_image_delete.png',
        width: 20,
        height: 20,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildGrid() {
    return new GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 24,
      //上下间距
      crossAxisSpacing: 24,
      //左右间距
      padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
      primary: false,
      shrinkWrap: true,

      children: <Widget>[
        listWidget[0],
        listWidget[1],
        listWidget[2],
        listWidget[3],
        listWidget[4],
        listWidget[0],
        listWidget[1],
        listWidget[2],
        listWidget[3],
        listWidget[4],
        listWidget[0],
        listWidget[1],
        listWidget[2],
        listWidget[3],
        listWidget[4],
        listWidget[0],
        listWidget[1],
        listWidget[2],
        listWidget[3],
        listWidget[4],
        listWidget[0],
        listWidget[1],
        listWidget[2],
        listWidget[3],
        listWidget[4],
        localImage('images/icon_add.png', BoxFit.cover),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text(name1),
        ),
        body: new ListView(
          shrinkWrap: true,

          physics: BouncingScrollPhysics(), //解决滑动冲突
          children: <Widget>[
            //输入框
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(top: 17, left: 20),
              color: const Color(0xFFFFFFFF),
              child: new TextField(
//                maxLength: 500,
                maxLines: 5,
                controller: _textFieldController,
                textAlign: TextAlign.left,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  hintText: '请输入拒绝理由',
                ),
              ),
            ),

            //textTitle
            new Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(top: 17, left: 24, bottom: 12),
              color: const Color(0xFFFFFFFF),
              child: new Text(
                '图片',
                style: new TextStyle(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),

            //GradView
            new Container(
              color: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: buildGrid(),
            ),

            //按钮
            new Container(
              margin: const EdgeInsets.only(top: 40, bottom: 40),
              child: buildButton("确认拒绝", const Color(0xFFFFFFFF),
                  const Color(0x803068E8), buttonClick1),
            ),
          ],
        ));
//      body: new Center(
//        child: buildGrid(),
//       }
  }

  //生成MaterialButton
  Container buildButton(
      String value, Color textColor, Color background, Function clickEvent()) {
    return new Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: new MaterialButton(
        child: Text(value),
        color: background,
        height: 50,
        textColor: textColor,
        onPressed: () {
          clickEvent();
        },
      ),
    );
  }

  Function buttonClick1() {
    setState(() {
      if (_textFieldController.text.length != 0) {
        toast(_textFieldController.text);
      }
    });
  }

  void toast(String value) {
    showToast(value,
        duration: Duration(seconds: 2),
        position: ToastPosition.bottom,
        textDirection: TextDirection.ltr,
        backgroundColor: Colors.grey,
        textStyle: new TextStyle(
          color: Colors.white,
          fontSize: 14,
        ));
  }

  void delete(String value) {
    print("delete=$value");
    toast("delete");
  }

  void replace(String value) {
    print("replace=$value");
    toast("replace");
  }

  void addImage(String value) {
    print("addImage=$value");
    toast("addImage");
  }
}
