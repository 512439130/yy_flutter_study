import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_layout_test/bean/TestBean.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/util/PictureUtil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:cached_network_image/cached_network_image.dart';


//常量定义
const String name1 = 'flutter_grid_image_select';

//图片GridView展示功能
class GridPictureDisplayWidget extends StatefulWidget {
  BuildContext mContext;
  TestBean testBean = new TestBean();
  int crossAxisCount;


  GridPictureDisplayWidget(this.mContext, this.testBean, this.crossAxisCount);
  @override
  _GridPictureDisplayWidgetState createState() => _GridPictureDisplayWidgetState();
}


class _GridPictureDisplayWidgetState extends State<GridPictureDisplayWidget> {
  List<Widget> listWidget;
  List<String> imageUrls;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
//  //初始化
  void init() {
    String testJsonValue ='{"datas":[{"id":"1","url":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553505918721&di=30abbc97f9b299cad7de51a06cbee078&imgtype=0&src=http%3A%2F%2Fimg15.3lian.com%2F2015%2Ff2%2F57%2Fd%2F93.jpg"},{"id":"2","url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=80538588,251590437&fm=26&gp=0.png"},{"id":"3","url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3597303668,2750618423&fm=26&gp=0.png"},{"id":"4","url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=61077523,1715146142&fm=26&gp=0.png"},{"id":"5","url":"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4087213632,1096565806&fm=26&gp=0.png"},{"id":"6","url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3597303668,2750618423&fm=26&gp=0.png"}],"resMsg":{"message":"success !","method":null,"code":"1"}}';
    Map<String, dynamic> json;
    if (testJsonValue != null) {
      json = jsonDecode(testJsonValue);
      widget.testBean = TestBean.fromJson(json);
    }
  }

  void setList() {
    print('setList');
    listWidget = new List<Widget>();
    imageUrls = new List<String>();
    for (int i = 0; i < widget.testBean.datas.length; i++) {
      if (i < widget.testBean.datas.length - 1) {
        listWidget.add(networkImage(i, widget.testBean.datas[i].url));
        imageUrls.add(widget.testBean.datas[i].url);
      }
    }
  }

  Widget networkImage(int id, String url) {
    return new Stack(
      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.visible,

      children: <Widget>[
        new Container(
            alignment: Alignment.center,
//            color: Colors.greenAccent,
            child: getNetImage(id, true, url)),
      ],
    );
  }



  Widget getNetImage(int id, bool isVisible, String url) {
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
      onTap:(){
//        ImageUtil.openLargeImage(context,url,Constant.image_type_network);
        PictureUtil.openLargeImages(context, imageUrls, Constant.image_type_network,id);
      },
      child: new Offstage(
        //使用Offstage 控制widget在tree中的显示和隐藏
        offstage: isVisible ? false : true,
        child: new ClipRRect(
          child: new Container(
            padding: const EdgeInsets.all(0),
            child: new CachedNetworkImage(
              width: imageWidthOrHeight,
              height: imageWidthOrHeight,

              fit: BoxFit.cover,
              fadeInCurve: Curves.ease,
              fadeInDuration: Duration(milliseconds: 500),
              fadeOutCurve: Curves.ease,
              fadeOutDuration: Duration(milliseconds: 300),
              imageUrl: url,
//        placeholder: (context, url) => Image(image: AssetImage('images/icon_image_default.png')),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
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
