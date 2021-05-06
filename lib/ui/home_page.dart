import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitors/const/const.dart';
import 'package:visitors/model/visitor_list.dart';
import 'package:visitors/provider/visitor_list.dart';
import 'package:visitors/sqflite_database/sqflite_database.dart';
import 'package:visitors/widget/textfeild.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VisitorList _visitorList = VisitorList();
  TextEditingController _textEditingController = TextEditingController();
 // List<VisitorList> _visitList = [];

  // @override
  // void initState() {
  //   displayAllTable();
  //   // TODO: implement initState
  //   super.initState();
  // }

  // void displayAllTable() async {
  //   _visitList = await DB.query();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderVisitorLists>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(kTitle),
          ),
          body: ListView.builder(
              itemCount: data.getAllVisitorList().length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(

                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '$kName: ',
                                  style: kHeadingText,
                                ),
                                Text(data.getAllVisitorList()[position].visitorName,
                                    style: kBodyText),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "$kAddress: ",
                                  style: kHeadingText,
                                ),
                                // Text(_visitList[position].address,
                                //     style: kBodyText),
                                Text(data.getAllVisitorList()[position].address,
                                    style: kBodyText),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '$kContact: ',
                                  style: kHeadingText,
                                ),
                                // Text(_visitList[position].number,
                                //     style: kBodyText),
                                Text(data.displayAllTable()[position],
                                    style: kBodyText),
                                Icon(
                                  Icons.visibility,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '$kGuest: ',
                                  style: kHeadingText,
                                ),
                                // _visitList[position].visitedStatus
                                //     ? Text(kVisited, style: kBodyText)
                                //     : Text(kNtVisited, style: kBodyText),
                                data.getAllVisitorList()[position].visitedStatus
                                    ? Text(kVisited, style: kBodyText)
                                    : Text(kNtVisited, style: kBodyText),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                  // onPressed: () async {
                                  //   await DB.delete(_visitList[position]);
                                  //   displayAllTable();
                                  // }),
                                  onPressed: () async {
                                    await DB.delete(data.getAllVisitorList()[position]);
                                    data.displayAllTable();
                                  }),
                              IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: AlertDialog(
                                              title: Text(kUpdate),
                                              content: Column(
                                                children: [
                                                  TextFeilds(
                                                    hint: kName,
                                                    onChange: (value) {
                                                      _visitorList.visitorName =
                                                          value;
                                                    },
                                                  ),
                                                  TextFeilds(
                                                    hint: kAddress,
                                                    onChange: (value) {
                                                      _visitorList.address =
                                                          value;
                                                    },
                                                  ),
                                                  TextFeilds(
                                                    hint: kContact,
                                                    onChange: (value) {
                                                      _visitorList.number =
                                                          value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                IconButton(
                                                    color: Colors.green,
                                                    icon: Icon(Icons.check),
                                                    onPressed: () {
                                                      VisitorList vistorsList =
                                                          VisitorList(
                                                              // id: _visitList[
                                                              //         position]
                                                              //     .id,
                                                              id: data.getAllVisitorList()[
                                                              position]
                                                                  .id,


                                                              visitorName:
                                                                  _visitorList
                                                                      .visitorName,
                                                              address:
                                                                  _visitorList
                                                                      .address,
                                                              number:
                                                                  _visitorList
                                                                      .number,
                                                              visitedStatus:
                                                                  true);
                                                      data.updateDatabase(
                                                          vistorsList);

                                                      _textEditingController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    }),
                                                IconButton(
                                                    color: Colors.red,
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      _textEditingController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    }),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            ],
                          )
                        ]),
                  ),
                );
              }),
          floatingActionButton: FloatingActionButton(
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: Text(kAdd),
                          content: Column(
                            children: [
                              TextFeilds(
                                hint: kName,
                                onChange: (value) {
                                  _visitorList.visitorName = value;
                                },
                              ),
                              TextFeilds(
                                hint: kAddress,
                                onChange: (value) {
                                  _visitorList.address = value;
                                },
                              ),
                              TextFeilds(
                                hint: kContact,
                                onChange: (value) {
                                  _visitorList.number = value;
                                },
                              ),
                            ],
                          ),
                          actions: [
                            IconButton(
                                color: Colors.green,
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  data.saveToDataBase(
                                      _visitorList.visitorName,
                                      _visitorList.address,
                                      _visitorList.number);

                                  _textEditingController.clear();
                                  Navigator.pop(context);
                                }),
                            IconButton(
                                color: Colors.red,
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  _textEditingController.clear();
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  // Widget renderScreen(){
  //   return ChangeNotifier(<VisitorList>)
  // }

  // saveToDataBase(String visitorName, String address, String number) async {
  //   if (visitorName.isNotEmpty && address.isNotEmpty && number.isNotEmpty) {
  //     var insertSucess = await DB.insert(VisitorList(
  //         visitorName: _visitorList.visitorName,
  //         address: _visitorList.address,
  //         number: _visitorList.number,
  //         visitedStatus: false));
  //
  //     print(insertSucess);
  //   }
  //   displayAllTable();
  // }
  //
  // updateDatabase(VisitorList visitorList) async {
  //   await DB.update(visitorList);
  //   displayAllTable();
  // }
  //
  // hideContact() {}
}
