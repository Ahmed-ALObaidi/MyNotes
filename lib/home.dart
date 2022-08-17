import 'dart:ffi';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testpro/Addnote.dart';
import 'package:testpro/EditNote.dart';
import 'package:testpro/Local_Controller.dart';
import 'package:testpro/NoteProv.dart';
import 'package:testpro/main.dart';
import 'package:testpro/sqldb.dart';
import 'GetxController.dart';
Controller controller = Get.put(Controller() , permanent: true);
void initState() async{
  if(SqlDb.note == null) {
    CircularProgressIndicator();
  }else {
    await SqlDb.initial();
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    localController changelangVar = Get.find();
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          share!.setString("id", "1");
          print("The id = ${share!.getString("id")}");
          // savepref();
          Get.to(() => AddNotes());
        },
          child: Icon(Icons.add),
        ),

        appBar: AppBar(
          title: Text('1'.tr),
          actions: [
            IconButton(onPressed: (){
              showSearch(context: context, delegate: SearchNotes(list: SqlDb.note),);
            }, icon: Icon(Icons.search)),
          ],
        ),
        body:
        Card(
            child: Container(child:
            ListView(children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                Text("5".tr) ,
                ElevatedButton(onPressed: () {
                  changelangVar.changelang("ar");
                }, child: Text("2".tr)),

                ElevatedButton(onPressed: () {
                  changelangVar.changelang("en");
                }, child: Text("3".tr)),
              ],),


              Form(child:
              // Consumer<NoteProv>(builder: (context, prov, child) {
              //   return
                  GetBuilder<Controller>(
                    init: Controller(),
                    builder: (controller) =>
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.getnote!.length,
                    itemBuilder: ((context, i) {
                      return
                        Card(
                          child:
                          controller.getnote!.isEmpty ? Center(child: CircularProgressIndicator()) :
                          ListTile(
                            title: Text('${controller.getnote![i]['title']}'),
                            subtitle: Text('${controller.getnote![i]['note']}'),
                            trailing:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // delete
                                IconButton(onPressed: () async {
                                  // await SqlDb.deleteData("DELETE FROM notes WHERE id = '${SqlDb.note![i]['id']}' ");
                                  await controller.deleteNote("DELETE FROM notes WHERE id = '${controller.getnote![i]['id']}' ");
                                  await controller.updateNotes();
                                  print("done deleted note");
                                },icon: Icon(Icons.delete),color: Colors.red,),

                                // update
                                IconButton(
                                  onPressed: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => EditNote(
                                            note: SqlDb.note![i]['note'],
                                            title: SqlDb.note![i]['title'],
                                            color: SqlDb.note![i]['color'],
                                            id: SqlDb.note![i]['id'],
                                          ),)
                                      );
                                  },icon: Icon(Icons.edit),color: Colors.blue,),
                              ],
                            ),
                          ),
                        );
                    }
                    )
                ),
              // },)
                    )
              ),
              ElevatedButton(onPressed: () {
                cc.changetheme();
              }, child: Text("4".tr)),
            ]
            )
            )
        )
    );
  }
}
class SearchNotes extends SearchDelegate{
  List? list = [];
  SearchNotes({this.list});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: (){
      if(query.isEmpty){
        close(context, null);
        // Navigator.pushNamedAndRemoveUntil(context, 'homePage', (route) => false);
        Get.offAll(HomePage());
      }else{query = '';}
    }, icon: Icon(Icons.clear)) ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      // Navigator.pushNamedAndRemoveUntil(context, 'homePage', (route) => false);
      Get.offAll(HomePage());
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // return StatefulBuilder(builder: (BuildContext context , StateSetter setState){
    // Controller controller = Get.put(Controller() , permanent: true);
    // Controller controlle = Get.find(); via Binding in main.dart
      return
        // Consumer<NoteProv>(builder: (context, prov, child) {
        // return
        // GetBuilder<Controller>(
        //   init: Controller(),
        //   builder: (controller) =>

        Obx(() =>
          Card(
            child: Container(child:
            ListView(children: [
              Form(child:
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.getnote!.length,
                  itemBuilder: ((context, i) {
                    return
                      Card(
                        child: query != controller.getnote![i]['title'] ? null : ListTile(
                          title: Text('${controller.getnote![i]['title']}'),
                          subtitle: Text('${controller.getnote![i]['note']}'),
                          trailing:
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // delete
                              IconButton(onPressed: ()async{
                                await SqlDb.deleteData("DELETE FROM notes WHERE id = '${controller.getnote![i]['id']}' ");
                                controller.getnote!.removeWhere((element) => element['id'] == controller.getnote![i]['id']);
                                controller.updateNotes();
                              },icon: Icon(Icons.delete),color: Colors.red,),

                              // Edite
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => EditNote(
                                        note: SqlDb.note![i]['note'],
                                        title: SqlDb.note![i]['title'],
                                        color: SqlDb.note![i]['color'],
                                        id: SqlDb.note![i]['id'],
                                      ),)
                                  );
                                },icon: Icon(Icons.edit),color: Colors.blue,),
                            ],
                          ),
                        ),
                      );
                  }
                  )
              )
              )]
            )
            )
        ),
      // },);
    // });
        );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List? notee = query.isEmpty ? list : list!.where((e) {
      final wordlower = e.toString().toLowerCase();
      final wordupper = e.toString().toUpperCase();
      return e.toString().contains(query) || wordlower.contains(query) ||  wordupper.contains(query);
    } ).toList();
    return ListView.builder(
        itemCount: notee!.length,
        itemBuilder: (context, index)
        {
          return ListTile(
            title: Text('${notee[index]['title']}'),
            onTap: () {
              query = notee[index]['title'].toString();
              showResults(context);
            },
          );
        });
  }
}