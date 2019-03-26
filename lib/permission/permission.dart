import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_permissions/simple_permissions.dart';

const String name1 = 'flutter_widget_permission';

class PermissionWidget extends StatefulWidget {
  PermissionWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  String _platformVersion = 'Unknown';
  Permission permission;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
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
            new Column(children: <Widget>[
              new Text('Running on: $_platformVersion\n'),
              new DropdownButton(
                  items: _getDropDownItems(),
                  value: permission,

                  onChanged: onDropDownChanged),
              new RaisedButton(
                  onPressed: checkPermission,
                  child: new Text("Check permission")),
              new RaisedButton(
                  onPressed: requestPermission,
                  child: new Text("Request permission")),
              new RaisedButton(
                  onPressed: getPermissionStatus,
                  child: new Text("Get permission status")),
              new RaisedButton(
                  onPressed: SimplePermissions.openSettings,
                  child: new Text("Open settings"))
            ]),

          ],
        ));
  }

  onDropDownChanged(Permission permission) {
    print('permission：$permission');
    setState(() => this.permission = permission);
  }

  //获取权限
  requestPermission() async {
    final res = await SimplePermissions.requestPermission(permission);
    print("permission request result is " + res.toString());
  }

  //检查权限
  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
  }

  //查看权限状态
  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }




  List<DropdownMenuItem<Permission>> _getDropDownItems() {
    List<DropdownMenuItem<Permission>> items = new List();
    Permission.values.forEach((permission) {
      var item = new DropdownMenuItem(
          child: new Text(getPermissionString(permission)), value: permission);
      items.add(item);
    });

    return items;
  }


}
