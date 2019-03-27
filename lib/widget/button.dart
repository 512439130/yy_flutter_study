import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/bean/LocalImageBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/dialog/BottomPickerHandler.dart';
import 'package:flutter_layout_test/dialog/ProgressDialog.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_layout_test/util/PermissionUtil.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:flutter_layout_test/view/GridImageWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:simple_permissions/simple_permissions.dart';

//数据传递
//原生&flutter互掉
//常量定义
const String name1 = 'flutter_widget_button';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget>
    with TickerProviderStateMixin
    implements BottomPickerListener {
  List<LocalImageBean> localImageBeanList;
  List<String> imageUrls;

//  ProgressDialog progressDialog;
  AnimationController _controller;
  BottomPickerListener _listener;
  BottomPickerHandler bottomPicker;

  bool flag = true;

  //选择器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    localImageBeanList = new List<LocalImageBean>();
//    initProgress();
    initBottomPicker();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }



  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }


//  void initProgress() {
//    progressDialog = new ProgressDialog(context);
//    progressDialog.setMessage("Loading...");
//    progressDialog.setTextColor(Colors.black);
//    progressDialog.setTextSize(16);
//  }


  void initBottomPicker() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    bottomPicker = new BottomPickerHandler(this, _controller);
    bottomPicker.init();
  }

  //生成MaterialButton
  Container buildButton(
      String value, Color textColor, Color background, Function clickEvent()) {
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

    return null;
  }

  Future<void> asyncDeleteImage(int id) async {
    try {
//      progressDialog.show();
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          localImageBeanList.removeAt(id);
        });
//        progressDialog.hide();
      });
    } catch (e) {
//      progressDialog.hide();
      print("faild:$e.toString()");
    }
  }

  Future<void> asyncReplaceImage(int id) async {
    try {
//      progressDialog.show();
      await Future.delayed(Duration(milliseconds: 500), () {
//        progressDialog.hide();
        replaceSdCard(id);
      });
    } catch (e) {
//      progressDialog.hide();
      print("faild:$e.toString()");
    }
  }

  Future<void> replaceSdCard(int id) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        print('replaceSdCard');
        //type
        localImageBeanList[id].path = image.path;
        //去重复
        localImageBeanList = deduplication(localImageBeanList);
      } else {
        print('replaceSdCard-未选择');
      }
    });
  }

  Future<void> asyncAddImage(int id) async {
    try {
//      progressDialog.show();
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          Future future1 = new Future(() => null);
          future1.then((_) {
            PermissionUtil.requestPermission(Permission.WriteExternalStorage)
                .then((result) {
              print("requestPermission-WriteExternalStorage$result");
              if (result == PermissionStatus.deniedNeverAsk) {
                //setting
                toast('由于用户您选择不在提醒，并且拒绝了权限，请您去系统设置修改相关权限后再进行功能尝试');
                PermissionUtil.openPermissionSetting();
              } else if (result == PermissionStatus.authorized) {
                Future future2 = new Future(() => null);
                future2.then((_) {
                  PermissionUtil.requestPermission(Permission.Camera)
                      .then((result2) {
                    print("requestPermission-Camera$result2");
                    if (result2 == PermissionStatus.deniedNeverAsk) {
                      //setting
                      toast('由于用户您选择不在提醒，并且拒绝了权限，请您去系统设置修改相关权限后再进行功能尝试');
                      PermissionUtil.openPermissionSetting();
                    } else if (result2 == PermissionStatus.authorized) {
//                      addSdCard(id);
                      bottomPicker.showDialog(context);
                    }
                  });
                });
              }
            });
          });
        });
//        progressDialog.hide();
      });
    } catch (e) {
//      progressDialog.hide();
      print("faild:$e.toString()");
    }
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

            
            //封装插件使用
            new GridImageWidget(context).createGridImageGenerator(
                localImageBeanList,
                3,
                20,
                20,
                addClick,
                replaceClick,
                deleteClick),
          ],
        ));
  }

  Function addClick() {
    int defaultLength = 1;
    if (localImageBeanList != null && localImageBeanList.length > 0) {
      asyncAddImage(localImageBeanList.length + 1);
    } else {
      asyncAddImage(defaultLength);
    }
    return null;
  }

  Function replaceClick(int id) {
    PictureUtil.openLargeImages(
        context, imageUrls, Constant.image_type_sdcard, id);
    return null;
  }

  Function deleteClick(int id) {
//    showDialog(
//        context: context,
//        builder: (_) => new AlertDialog(
//                title: new Text("提示"),
//                content: new Text("确认删除？"),
//                actions: <Widget>[
//                  new FlatButton(
//                    child: new Text("取消"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                  new FlatButton(
//                    child: new Text("确定"),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//
//                    },
//                  )
//                ]));
//    return null;
    asyncDeleteImage(id);
  }

  @override
  useImage(File _image) {
    //选择图片后的回调
    // TODO: implement useImage
    int length;
    if (localImageBeanList != null && localImageBeanList.length > 0) {
      length = localImageBeanList.length + 1;
    } else {
      length = 1;
    }
    setState(() {
      if (_image != null) {
        print('addSdCard');
        LocalImageBean localImageBean = new LocalImageBean();
        localImageBean.id = length.toString();
        localImageBean.path = _image.path;
        //type
        localImageBeanList.add(localImageBean);
        //去重复
        localImageBeanList = deduplication(localImageBeanList);
      } else {
        print('addSdCard-未选择');
      }
    });
    return null;
  }

//List去重复(Set方式)
  List<LocalImageBean> deduplication(List<LocalImageBean> list) {
    Set<String> localImageBeanSet = new Set<String>();
    for (int i = 0; i < list.length; i++) {
      localImageBeanSet.add(list[i].path);
    }
    print('set:' + localImageBeanSet.toString());
    list.clear();
    List setToList = localImageBeanSet.toList(growable: true);

    for (int i = 0; i < setToList.length; i++) {
      LocalImageBean localImageBean = new LocalImageBean();
      localImageBean.id = i.toString();
      localImageBean.path = setToList[i];
      list.add(localImageBean);
    }
    return list;
  }
}
