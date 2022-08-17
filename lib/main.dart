import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testpro/Addnote.dart';
import 'package:testpro/EditNote.dart';
import 'package:testpro/Local.dart';
import 'package:testpro/Local_Controller.dart';
import 'package:testpro/NoteProv.dart';
import 'package:testpro/ShareMiddleware.dart';
import 'package:testpro/home.dart';
import 'package:testpro/sqldb.dart';
import 'package:provider/provider.dart';

import 'GetxController.dart';

SharedPreferences? share ;
// savepref()async{
//   SharedPreferences? pref = await SharedPreferences.getInstance();
//   pref.setString("id", "1");
//   print("${pref.getString("id")}");
// }
// getpref()async{
//   SharedPreferences? pref = await SharedPreferences.getInstance();
//   pref.getString("id");
//   if(pref.getString("id") != null){
//     Get.to(() => AddNotes());
//   }
//   print("${pref.getString("id")}");
// }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  share = await SharedPreferences.getInstance();
  // await getpref();
  await SqlDb.initial();
  runApp(MyApp());
}
Controller cc = Get.put(Controller());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    localController c = Get.put(localController());

    return
      // ChangeNotifierProvider(
      // create: (BuildContext context) =>  NoteProv(),
      // child:

    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        // routes: {
        //   '/homePage' : (context) => HomePage(),
        //   '/addNotes' : (context) => AddNotes(),
        //   '/EditeNotes' : (context) => EditNote(),
        // },
        initialRoute:  "/homePage",
        locale: c.initial,
        translations: local(),
        theme: cc.theme,
        getPages: [
          GetPage(name: "/homePage", page: () => HomePage(),
              middlewares: [ShareMiddleware()]
          ),
          GetPage(name: "/addNotes", page: () => AddNotes(),/*middlewares: [ShareMiddleware()]*/),
          GetPage(name: "/EditeNotes", page: () => EditNote())
        ],

      );
    // );
  }
}
