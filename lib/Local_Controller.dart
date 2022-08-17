import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testpro/main.dart';

class localController extends GetxController{
  late Locale initial = share!.getString("lang") == null ? Get.deviceLocale! : Locale(share!.getString("lang")!);

  changelang(String codelang){
    Locale langloc = Locale(codelang);
    share!.setString("lang",codelang );
    Get.updateLocale(langloc);
  }
}