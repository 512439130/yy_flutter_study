import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/bean/HeaderBean.dart';
import 'package:flutter_layout_test/bean/LocalImageBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/dialog/BottomPickerHandler.dart';
import 'package:flutter_layout_test/dialog/ProgressDialog.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_layout_test/util/ListUtil.dart';
import 'package:flutter_layout_test/util/PermissionUtil.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:flutter_layout_test/view/GridHeaderDisplayWidget.dart';
import 'package:flutter_layout_test/view/GridPictureSelectWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:simple_permissions/simple_permissions.dart';

//数据传递
//原生&flutter互掉
//常量定义
const String name1 = 'header_display_demo';

class HeaderDisplayDemoWidget extends StatefulWidget {
  HeaderDisplayDemoWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HeaderDisplayDemoWidgetState createState() => HeaderDisplayDemoWidgetState();
}

class HeaderDisplayDemoWidgetState extends State<HeaderDisplayDemoWidget> {
  HeaderBean headerBean;
  ProgressDialog progressDialog;   //加载进度条可选添加

  //底部拍照/相册功能
  BottomPickerHandler bottomPicker;
  AnimationController bottomAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    init();
  }

  //初始化
  void init() {
    headerBean = new HeaderBean();
    String testJsonValue ='{"datas":[{"id":"1","url":"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=517d540e8e18367aad8978db1648ece9/b58f8c5494eef01fdb0581e2e8fe9925bc317d80.jpg","name":"张一鸣"},{"id":"2","url":"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=743300c78dd6277fe912353e1003780d/5d6034a85edf8db13821e8180323dd54564e74bb.jpg","name":"张小龙"},{"id":"3","url":"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=bf1f9fba0f082838680ddb1280a2ce3c/8cb1cb1349540923453457db9a58d109b3de4931.jpg","name":"马化腾"},{"id":"4","url":"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=d6d431bf9aef76c6d0d2fc2da52d9ac7/2f738bd4b31c8701928251782d7f9e2f0708ff7c.jpg","name":"李彦宏"},{"id":"5","url":"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=ef281d4357da81cb4ae684cf6267d0a4/f703738da9773912f15d70d6fe198618367ae20a.jpg","name":"范冰冰"},{"id":"6","url":"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=0003b03088b1cb133e693b15e56f3173/0bd162d9f2d3572c257447038f13632763d0c35f.jpg","name":"马云"},{"id":"7","url":"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=3a64e2745c0fd9f9a017526f1d16b317/d31b0ef41bd5ad6e0c58a9e28ccb39dbb6fd3c11.jpg","name":"王力宏"},{"id":"8","url":"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=8015dac14fa7d933bfa8e3759570b62e/5882b2b7d0a20cf4be0b1e0a7b094b36adaf9948.jpg","name":"潘玮柏"},{"id":"9","url":"https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=7a156e5ceccd7b89ed6c3d813f254291/2f738bd4b31c87010f99dc702d7f9e2f0708ff7d.jpg","name":"陈乔恩"},{"id":"10","url":"https://b-ssl.duitang.com/uploads/item/201703/30/20170330175756_5KzW3.thumb.700_0.jpeg","name":"戚薇"},{"id":"11","url":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553766301424&di=7c577a52b425f6f44fedc438a6195cf3&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201305%2F04%2F20130504022246_YvfsZ.thumb.700_0.jpeg","name":"路飞"},{"id":"12","url":"http://h.hiphotos.baidu.com/baike/s%3D220/sign=27f10ce946086e066ea8384932097b5a/eaf81a4c510fd9f94842c5b12f2dd42a2934a495.jpg","name":"索隆"}],"resMsg":{"message":"success !","method":null,"code":"1"}}';
    Map<String, dynamic> json;
    if (testJsonValue != null) {
      json = jsonDecode(testJsonValue);
      headerBean = HeaderBean.fromJson(json);
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            new Container(
              color:Colors.white,
              padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridHeaderDisplayWidget(context,headerBean, 3,340),
            ),
            new Container(
              color:Colors.white,
              padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridHeaderDisplayWidget(context,headerBean, 4,340),
            ),
            new Container(
              color:Colors.white,
              padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridHeaderDisplayWidget(context,headerBean, 5,340),
            ),
            new Container(
              color:Colors.white,
              padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridHeaderDisplayWidget(context,headerBean, 6,340),
            ),
            new Container(
              color:Colors.white,
              padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GridHeaderDisplayWidget(context,headerBean, 7,340),
            ),
          ],
        ));
  }




}
