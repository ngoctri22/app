import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:untitled/SettingLib.dart';
Directory? appDocumentDirectory;

init()async{
  appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  String path;
  if(appDocumentDirectory != null){
    path = appDocumentDirectory!.path;
    Hive.init(path);
  }
  Setting.storageLib = new SettingLib();
  await Setting.init('Config');
}
List makeTreeItems(List? items, int? length){
  if(length == null || length <= 1 || items == null){
    return items??[];
  }
  int _l = length;
  if(items.length < length){
    _l = items.length;
  }
  List _items = [];
  for(int index = 0; index < (items.length/length).ceil(); index++){
    int max = (index * _l) + _l;
    if(max > items.length){
      max = items.length;
    }
    _items.add(items.sublist(index * _l, max));
  }
  return _items;
}