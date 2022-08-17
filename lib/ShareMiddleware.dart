import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:testpro/main.dart';

bool b = true ;
class ShareMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route) {
    if( share!.getString("id") != null )
    // {
       return RouteSettings(name: "/addNotes");
    // }
    // else {
    //   return RouteSettings(name: "/homePage");
    // }

  }
}