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