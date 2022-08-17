import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testpro/home.dart';
import 'package:testpro/sqldb.dart';
import 'package:provider/provider.dart';

class EditNote extends StatelessWidget {
  final note;
  final color;
  final title;
  final id;
   EditNote({Key? key, this.note, this.id, this.color, this.title}) : super(key: key);

  SqlDb sqlDb = new SqlDb();
  GlobalKey<FormState> formstate = new GlobalKey();
  TextEditingController note1 = new TextEditingController();
  TextEditingController title1 = new TextEditingController();
  TextEditingController color1 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    note1.text = note;
    title1.text = title;
    color1.text = color;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Container(child: Center(child: ListView(children: [
        Form(
          key: formstate,
          child: Column(children: [
            TextFormField(controller: note1,decoration: InputDecoration(hintText: 'Title')),
            TextFormField(controller: title1,decoration: InputDecoration(hintText: 'Note')),
            TextFormField(controller: color1,decoration: InputDecoration(hintText: 'Color')),
            ElevatedButton(onPressed: ()  async{
              // var response =
              await SqlDb.updateData('''
               UPDATE notes
               SET note = "${note1.text}", title = "${title1.text}",color ="${color1.text}"
               WHERE id == ${id};
              ''');

              // var response = await sqlDb.update('notes', {
              //   "note" : "${note.text}" ,
              //   "title" : "${title.text}" ,
              //   "color" : "${color.text}"
              // } , "id = ${widget.id}");

              // if(response > 0){
              // Navigator.of(context).pushNamedAndRemoveUntil('homePage', (route) => false);
              Get.offAll(HomePage());
              // }
              // setState(() {});
              // print('Response is ======================================= $response');

            }, child: Text('Update Notes')),

            ElevatedButton(onPressed: () async {
              // setState(() {
              //   Navigator.of(context).pushNamedAndRemoveUntil('homePage', (route) => false);
              Get.offAll(HomePage());
                print('Done');
              // });
            }, child: Text('Home')),

          ],),),
      ],),),),
    );
  }


}

