
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_layout_test/bean/LocalImageBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:oktoast/oktoast.dart';
//网格型图片Widget生成器
class GridImageWidget{
  final BuildContext mContext;

  GridImageWidget(this.mContext);
  //每行数量
  //是否显示
  List<Widget> listWidget;
  List<LocalImageBean> localImageBeanList;
  List<String> imageUrls;


  Widget createGridImageGenerator(List<LocalImageBean> localImageBeanList,int crossAxisCount,double mainAxisSpacing,double crossAxisSpacing,Function() onAddPress,Function(int) onReplacePress,Function(int) onDeletePress){
    this.localImageBeanList = localImageBeanList;
    setList(onAddPress,onReplacePress,onDeletePress);
    return new GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      //上下间距
      crossAxisSpacing: crossAxisSpacing,
      //左右间距
      padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
      primary: false,
      shrinkWrap: true,
      children: listWidget,
    );
  }



  void setList(Function() onAddPress,Function(int) onReplacePress,Function(int) onDeletePress) {
    print('setList');
    //listWidget
    //每次生成新的图片数组
    listWidget = new List<Widget>();
    imageUrls = new List<String>();
    if (localImageBeanList != null && localImageBeanList.length > 0) {
      for (int i = 0; i < localImageBeanList.length; i++) {
        listWidget.add(sdCardImage(i, localImageBeanList[i].path,onReplacePress,onDeletePress));
        imageUrls.add(localImageBeanList[i].path);
      }
      //每次在尾部加添加图片
      listWidget.add(localImage('images/icon_add.png', BoxFit.cover,onAddPress));
    } else {
      listWidget.add(localImage('images/icon_add.png', BoxFit.cover,onAddPress));
    }
  }

  //sdcard图片，携带删除控制按钮
  Widget sdCardImage(int id, String path,Function(int) onReplacePress,Function(int) onDeletePress) {
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,
      children: <Widget>[
        new Container(
            alignment: Alignment.center,
            child: getSdCardImage(id, false, path, BoxFit.cover,onReplacePress)),
        Positioned(
          right: 0,
          top: 0,
          child: getDeleteIcon(id,onDeletePress(id)),
        )
      ],
    );
  }





  Widget getSdCardImage(int id, bool offstage, String path, BoxFit fit,Function(int) onReplacePress) {
    return new GestureDetector(
      onTap: () {
//        PictureUtil.openLargeImages(mContext, imageUrls, Constant.image_type_sdcard, id);
        toast('replaceImage');
        onReplacePress(id);
      },
      child: new Offstage(
        //使用Offstage 控制widget在tree中的显示和隐藏
        offstage: offstage,
        child: new ClipRRect(
          child: new Container(
            padding: const EdgeInsets.all(0),
            child: new Image.file(
              new File(path),
              width: 55,
              height: 55,
              fit: fit,
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
  Widget localImage(String path, BoxFit fit,Function() onAddPress) {
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            toast('addImage');
            onAddPress();
          },
          child: new Container(
            color: const Color(0xFFF7F8FA),
            padding: const EdgeInsets.all(20),
            child: new Image.asset(
                path,
                width: 40,
                height: 40,
                fit: BoxFit.fitWidth
            ),
          ),
        ),
      ],
    );
  }
  Widget getDeleteIcon(int id,Function(int) onDeletePress) {
    return new GestureDetector(
      onTap: () {
        toast('deleteImage');
        onDeletePress(id);
        //调用delete
      },
      child: Image.asset(
        'images/icon_image_delete.png',
        width: 15,
        height: 15,
        fit: BoxFit.cover,
      ),
    );
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

