import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testpro/sqldb.dart';

import 'main.dart';

class Controller extends GetxController{


  List? notes = SqlDb.note;
  ThemeData theme = share!.getString("theme") == "themes2" ? ThemeData.dark() : ThemeData.light();
  changetheme( ){
    if(Get.isDarkMode){
      Get.changeTheme(ThemeData.light());
      share!.setString("theme","themes1" );
    }
    else {
      Get.changeTheme(ThemeData.dark());
      share!.setString("theme","themes2" );
    }
  }

   deleteNote(String delete) async {
    await SqlDb.deleteData(delete);
    update();
  }

   updateNotes() async {
    await SqlDb.readData();
    update();
   }

  void remove (List list){
     notes!.remove(list);
     update();
  }
  List? get getnote{
     return SqlDb.note;
  }

}