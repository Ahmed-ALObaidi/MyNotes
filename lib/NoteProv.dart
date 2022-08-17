// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'sqldb.dart';
// import 'home.dart';
// class NoteProv with ChangeNotifier{
//   List? notes = SqlDb.note;
//
//    deleteNote(String delete) async {
//     await SqlDb.deleteData(delete);
//     notifyListeners();
//   }
//
//    updateNotes() async {
//     await SqlDb.readData();
//     notifyListeners();
//    }
//
//   void remove (List list){
//      notes!.remove(list);
//      notifyListeners();
//   }
//   List? get getnote{
//      return SqlDb.note;
//   }
// }