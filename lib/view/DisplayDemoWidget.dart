import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/bean/LocalImageBean.dart';
import 'package:flutter_layout_test/bean/TestBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/dialog/BottomPickerHandler.dart';
import 'package:flutter_layout_test/dialog/ProgressDialog.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_layout_test/util/ListUtil.dart';
import 'package:flutter_layout_test/util/PermissionUtil.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:flutter_layout_test/view/GridImageSelectWidget.dart';
import 'package:flutter_layout_test/view/GridPictureDisplayWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:simple_permissions/simple_permissions.dart';

//数据传递
//原生&flutter互掉
//常量定义
const String name1 = 'flutter_widget_display_demo';

class DisplayDemoWidget extends StatefulWidget {
  DisplayDemoWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DisplayDemoWidgetState createState() => DisplayDemoWidgetState();
}

class DisplayDemoWidgetState extends State<DisplayDemoWidget>{
  TestBean testBean = new TestBean();//保存数据的泛型实体

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
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
            GridPictureDisplayWidget(context,testBean, 2),
            GridPictureDisplayWidget(context,testBean, 3),
            GridPictureDisplayWidget(context,testBean, 4),
            GridPictureDisplayWidget(context,testBean, 5),
            GridPictureDisplayWidget(context,testBean, 6),
          ],
        ));
  }





}
