import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:testpro/main.dart';
import 'package:testpro/sqldb.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class AddNotes extends StatelessWidget {
  // const AddNotes({Key? key}) : super(key: key);

  @override
  GlobalKey<FormState> formstate = new GlobalKey();
  TextEditingController note = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController color = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Container(child: Center(child: ListView(children: [
        Form(
          key: formstate,
          child: Column(children: [
            TextFormField(controller: note,decoration: InputDecoration(hintText: 'Title')),
            TextFormField(controller: title,decoration: InputDecoration(hintText: 'Note')),
            TextFormField(controller: color,decoration: InputDecoration(hintText: 'Color')),

            // ADD Notes
            ElevatedButton(onPressed: ()  async {
              await SqlDb.insertData('''
              INSERT INTO notes (note, title , color) VALUES ("${note.text}" , "${title.text}" , "${color.text}")
              ''');
              // var response = await sqlDb.insert('notes', {
              //   'note':"${note.text}",
              //   'title':"${title.text}",
              //   'color':"${color.text}"
              // });
              // print('Response is ======================================= $response');
              // Navigator.of(context).pushNamedAndRemoveUntil('homePage', (route) => false);
              Get.offAll(HomePage());
              print("done");
            }, child: Text('Add Notes')),
            // Delete Data
            ElevatedButton(onPressed: () async {

              await SqlDb.deleteallmydatabase();
              print('done deleted');
            }, child: Text('Delete Data')),

            // Back Home
            ElevatedButton(onPressed: ()  {
              // setState(() {
              //   Navigator.of(context).pushNamedAndRemoveUntil('homePage', (route) => false);
              share!.clear();
              Get.offAll(HomePage());
                print('Done');
              // });
            }, child: Text('Home')),
          ],),
        ),
      ],),
      ),
      ),
    );
  }



}

