import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_layout_test/bean/LocalImageBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//常量定义
const String name1 = 'flutter_grid_image_select';

//图片GridView选择功能
class GridPictureSelectWidget extends StatefulWidget {
  BuildContext mContext;
  List<LocalImageBean> localImageBeanList;
  int crossAxisCount;

  Function() onAddPress;
  Function(int id, List<String> urls) onReplacePress;
  Function(int) onDeletePress;

  GridPictureSelectWidget(this.mContext, this.localImageBeanList, this.crossAxisCount, this.onAddPress, this.onReplacePress, this.onDeletePress);
  @override
  _GridPictureSelectWidgetState createState() => _GridPictureSelectWidgetState();
}


class _GridPictureSelectWidgetState extends State<GridPictureSelectWidget> {
  List<Widget> listWidget;
  List<String> imageUrls;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setList() {
    print('setList');
    listWidget = new List<Widget>();
    imageUrls = new List<String>();
    if (widget.localImageBeanList != null &&
        widget.localImageBeanList.length > 0) {
      for (int i = 0; i < widget.localImageBeanList.length; i++) {
        listWidget.add(sdCardImage(i, widget.localImageBeanList[i].path));
        imageUrls.add(widget.localImageBeanList[i].path);
        print("test:" + widget.localImageBeanList[i].path);
      }
      //每次在尾部加添加图片
      listWidget.add(localImage('images/icon_add.png'));
    } else {
      listWidget.add(localImage('images/icon_add.png'));
    }
  }

  //sdcard图片，携带删除控制按钮
  Widget sdCardImage(int id, String path) {

    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,
      children: <Widget>[
        new Container(
            alignment: Alignment.center,
//            color: Colors.amberAccent,
//            padding: const EdgeInsets.all(10),

            child: getSdCardImage(id, false, path)),
        Positioned(
          //删除按钮距离右，顶的距离
          right: 0,
          top: 0,
          child: getDeleteIcon(id),
        )
      ],
    );
  }

  Widget getSdCardImage(int id, bool offstage, String path) {
    double imageWidthOrHeight = 0;
    if(widget.crossAxisCount == 2){
      imageWidthOrHeight = 160;
    }else if(widget.crossAxisCount == 3){
      imageWidthOrHeight = 100;
    }else if(widget.crossAxisCount == 4){
      imageWidthOrHeight = 70;
    }else if(widget.crossAxisCount == 5){
      imageWidthOrHeight = 55;
    }else if(widget.crossAxisCount == 6){
      imageWidthOrHeight = 30;
    }else{
      imageWidthOrHeight = 100;
    }

    return new GestureDetector(
      onTap: () {
//        PictureUtil.openLargeImages(mContext, imageUrls, Constant.image_type_sdcard, id);
        toast('replaceImage');
        widget.onReplacePress(id, imageUrls);
      },
      child: new Offstage(
        //使用Offstage 控制widget在tree中的显示和隐藏
        offstage: offstage,
        child: new ClipRRect(
          child: new Container(
//            padding: const EdgeInsets.all(5),
//            color: Colors.deepOrange,
            child: new Image.file(
              new File(path),
              //image大小，暂时必须写死
              width: imageWidthOrHeight,
              height: imageWidthOrHeight,
              fit: BoxFit.cover,
            ),
          ),
          //圆角
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
      ),
    );
  }

//本地图片，（加号）
  Widget localImage(String path) {
    double addWidthOrHeight = 0;
    if(widget.crossAxisCount == 2){
      addWidthOrHeight = 120;
    }else if(widget.crossAxisCount == 3){
      addWidthOrHeight = 60;
    }else if(widget.crossAxisCount == 4){
      addWidthOrHeight = 35;
    }else if(widget.crossAxisCount == 5){
      addWidthOrHeight = 20;
    }else if(widget.crossAxisCount == 6){
      addWidthOrHeight = 12;
    }else{
      addWidthOrHeight = 60;
    }
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            toast('addImage');
            widget.onAddPress();
          },
          child: new ClipRRect(
            child: new Container(
              color: const Color(0xFFF7F8FA),
              padding: const EdgeInsets.all(20),
              child: new Image.asset(path,
                  width: addWidthOrHeight,
                  height: addWidthOrHeight,
                  fit: BoxFit.cover),
            ),
            //圆角
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        ),
      ],
    );
  }

  Widget getDeleteIcon(int id) {
    double deleteWidthOrHeight = 0;
    if(widget.crossAxisCount == 2){
      deleteWidthOrHeight = 20;
    }else if(widget.crossAxisCount == 3){
      deleteWidthOrHeight = 20;
    }else if(widget.crossAxisCount == 4){
      deleteWidthOrHeight = 20;
    }else if(widget.crossAxisCount == 5){
      deleteWidthOrHeight = 20;
    }else if(widget.crossAxisCount == 5){
      deleteWidthOrHeight = 20;
    }else{
      deleteWidthOrHeight = 20;
    }
    return new GestureDetector(
      onTap: () {
        toast('deleteImage');
        widget.onDeletePress(id);
        //调用delete
      },
      child: Image.asset(
        'images/icon_image_delete.png',
        width: 20,
        height: 20,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setList();
    return new ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          new Container(
            color: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            margin:  const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: new Center(
                child: new GridView.count(
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: 0,
                  //上下间距
                  crossAxisSpacing: 0,
                  //左右间距
                  padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                  primary: false,
                  shrinkWrap: true,
                  children: listWidget,
                )),
          ),
        ]);
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
}
