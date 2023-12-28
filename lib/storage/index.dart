import 'package:hive_flutter/hive_flutter.dart';

class Storage{
  
  static  initStorage(name)async{
    await Hive.initFlutter();
    await Hive.openBox(name);
  }

   static Box getStorage(name)=> Hive.box(name);
}