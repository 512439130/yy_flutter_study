import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_test/consts/Constant.dart';
import 'package:flutter_layout_test/refresh/refresh.dart';
import 'package:flutter_layout_test/util/PermissionUtil.dart';
import 'package:flutter_layout_test/util/ToastUtil.dart';
import 'package:flutter_layout_test/util/dioHttpUtil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

//网络请求（数据加载）
//常量定义
const String name1 = 'flutter_widget_network';

class NetworkWidget extends StatefulWidget {
  NetworkWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NetworkWidgetState createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  String lineText = "lineText";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name1),
        ),
        body: new ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            buildButton("requestGET", Colors.black, Colors.greenAccent, requestGETClick),
            buildButton("requestPOST", Colors.black, Colors.greenAccent, requestPOSTClick),
            buildButton("requestJsonBody", Colors.black, Colors.greenAccent, requestJsonBodyClick),
            buildButton("requestFormData", Colors.black, Colors.greenAccent, requestFormDataClick),
            buildButton("obtainPermission", Colors.black, Colors.greenAccent, obtainPermissionClick),
            buildButton("downLoadFile", Colors.black, Colors.greenAccent, downLoadFileClick),
            new Text(lineText),
          ],
        ));
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

  Function requestGETClick() {
    requestGET();
    return null;
  }

  Function requestPOSTClick() {
    requestPOST();
    return null;
  }

  Function requestJsonBodyClick() {
    requestJsonBody();
    return null;
  }

  Function requestFormDataClick() {
    requestFormData();
    return null;
  }

  Function obtainPermissionClick() {
    obtainPermission();

    return null;
  }

  Function downLoadFileClick() {
    downLoadFile();
    return null;
  }




  Future requestPOST() async {
    String url = 'https://www.zbg.com/exchange/config/controller/website/MarketController/getMarketAreaListByWebId';
    CancelToken cancelToken = new CancelToken();
    Response response = await dioHttpUtil().doPost(url,cancelToken: cancelToken);
    if(response != null){
      if(response.statusCode == 200){
        ToastUtil.toast("请求成功");
        setState(() {
          lineText = response.data.toString();
        });
      }else{
        ToastUtil.toast('request-error:$response.statusCode-$response.data');
      }
    }else{
      ToastUtil.toast('response == null');
    }

  }

  Future requestGET() async {
    String url = 'https://www.zbg.com/exchange/config/controller/website/MarketController/getMarketAreaListByWebId';
    CancelToken cancelToken = new CancelToken();
    Response response = await dioHttpUtil().doGet(url,cancelToken: cancelToken);
    if(response != null){
      if(response.statusCode == 200){
        ToastUtil.toast("请求成功");
        setState(() {
          lineText = response.data.toString();
        });
      }else{
        ToastUtil.toast('request-error:$response.statusCode-$response.data');
      }
    }else{
      ToastUtil.toast('response == null');
    }

  }






  Future<void> obtainPermission() async {
    try {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          Future future1 = new Future(() => null);
          future1.then((_) {
            PermissionUtil.requestPermission(Permission.WriteExternalStorage)
                .then((result) {
              print("requestPermission-WriteExternalStorage$result");
              if (result == PermissionStatus.deniedNeverAsk) {
                //setting
                ToastUtil.toast('由于用户您选择不在提醒，并且拒绝了权限，请您去系统设置修改相关权限后再进行功能尝试');
                PermissionUtil.openPermissionSetting();
              } else if (result == PermissionStatus.authorized) {
                Future future2 = new Future(() => null);
                future2.then((_) {
                  PermissionUtil.requestPermission(Permission.ReadExternalStorage)
                      .then((result2) {
                    print("ReadExternalStorage-Camera$result2");
                    if (result2 == PermissionStatus.deniedNeverAsk) {
                      //setting
                      ToastUtil.toast('由于用户您选择不在提醒，并且拒绝了权限，请您去系统设置修改相关权限后再进行功能尝试');
                      PermissionUtil.openPermissionSetting();
                    } else if (result2 == PermissionStatus.authorized) {
                      ToastUtil.toast('权限获取成功');
                    }
                  });
                });

              }
            });
          });
        });
      });
    } catch (e) {
      print("faild:$e.toString()");
    }
  }




  Future requestJsonBody() async {
    String url = 'https://www.zbg.com/exchange/config/controller/website/MarketController/getMarketAreaListByWebId';
    var jsonBody = '{\'pageIndex\': 1, \'pageSize\': 10}';
    print('jsonBody:'+jsonBody);
    CancelToken cancelToken = new CancelToken();
    Response response = await dioHttpUtil().requestJsonBody(url, jsonBody: jsonBody,cancelToken: cancelToken);
    if(response != null){
      if(response.statusCode == 200){
        ToastUtil.toast("请求成功");
        setState(() {
          lineText = response.data.toString();
        });
      }else{
        ToastUtil.toast('request-error:$response.statusCode-$response.data');
      }
    }else{
      ToastUtil.toast('response == null');
    }
  }


  //请求数据将会以 multipart/form-data方式编码, FormData中可以一个或多个包含文件
  Future requestFormData() async {
    String url = 'https://www.zbg.com/exchange/config/controller/website/MarketController/getMarketAreaListByWebId';


//    //1。FormData上传单个文件
//    FormData formData = new FormData.from({
//      "name": "wendux",
//      "age": 25,
//      "file": new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")
//    });
//
//    //2.FormData上传组文件
//    FormData formData = new FormData.from({
//      "name": "wendux",
//      "age": 25,
//      "file1": new UploadFileInfo(new File("./upload.txt"), "upload1.txt"),
//      "file2": new UploadFileInfo(new File("./upload.txt"), "upload2.txt"),
//      // 支持文件数组上传
//      "files": [
//        new UploadFileInfo(new File("./example/upload.txt"), "upload.txt"),
//        new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")
//      ]
//    });
    //FormData只携带数据
    FormData formData = new FormData.from({
      "name": "wendux",
      "age": 25,
    });




    CancelToken cancelToken = new CancelToken();
    Response response = await dioHttpUtil().requestFormData(url, formData: formData,cancelToken: cancelToken);
    if(response != null){
      if(response.statusCode == 200){
        ToastUtil.toast("请求成功");
        setState(() {
          lineText = response.data.toString();
        });
      }else{
        ToastUtil.toast('request-error:$response.statusCode-$response.data');
      }
    }else{
      ToastUtil.toast('response == null');
    }
  }



  Future<void> downLoadFile() async {

    var sdcard = await getExternalStorageDirectory();
    String sdCardPath = sdcard.path;
    String directoryPath = sdCardPath+Constant.image_save_path;

    print("directoryPath:"+directoryPath);
    var directory = await new Directory(directoryPath).create(recursive: true);  ////如果有子文件夹，需要设置recursive: true

    //absolute返回path为绝对路径的Directory对象
    String path = directory.absolute.path;
    print("path:"+path);


    try {
      Response response;
      Dio dio = new Dio();
      String fileName = directory.absolute.path+'test.jpeg';

      response = await dio.download(
          'https://b-ssl.duitang.com/uploads/item/201703/30/20170330175756_5KzW3.thumb.700_0.jpeg',
          fileName);
      if (response.statusCode == 200) {
        print("request-succes");
        ToastUtil.toast("保存成功：$fileName");

      } else {
        print("request-error");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPath() async {
    //临时目录
    var _tempDir = await getTemporaryDirectory();
    //获取具体路径
    String tempDirPath = _tempDir.path;
    //文档目录
    var _document = await getApplicationDocumentsDirectory();
    String documentPath = _document.path;
    //sd卡目录
    var _sdCard = await getExternalStorageDirectory();
    String sdCardPath = _sdCard.path;

    //打印路径
    print("临时目录:"+ tempDirPath);
    print("文档目录："+ documentPath);
    print("sd卡目录："+ sdCardPath);

  }


}
