import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visitors/model/visitor_list.dart';
import 'package:visitors/sqflite_database/sqflite_database.dart';

class ProviderVisitorLists extends ChangeNotifier{
  VisitorList _visitorList = VisitorList();
  //TextEditingController _textEditingController = TextEditingController();
  List<VisitorList> _visitList = [];
  List<VisitorList> getAllVisitorList(){
    return _visitList;
  }



   displayAllTable() async {
    _visitList = await DB.query();

  }

  saveToDataBase(String visitorName, String address, String number) async {
    if (visitorName.isNotEmpty && address.isNotEmpty && number.isNotEmpty) {
      var insertSucess = await DB.insert(VisitorList(
          visitorName: _visitorList.visitorName,
          address: _visitorList.address,
          number: _visitorList.number,
          visitedStatus: false));

      print(insertSucess);
    }
    displayAllTable();
    notifyListeners();
  }

  updateDatabase(VisitorList visitorList) async {
    await DB.update(visitorList);
    displayAllTable();
    notifyListeners();
  }

}