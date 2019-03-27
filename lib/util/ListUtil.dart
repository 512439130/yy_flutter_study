import 'package:flutter_layout_test/bean/LocalImageBean.dart';

class ListUtil{
  //List去重复(Set方式)
 static List<LocalImageBean> deduplication(List<LocalImageBean> list) {
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