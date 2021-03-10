import 'package:flutter/material.dart';
import 'package:visitors/model/visitor_list.dart';
import 'package:visitors/sqflite_database/sqflite_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VisitorList _visitorList = VisitorList();
  TextEditingController _textEditingController = TextEditingController();
  List<VisitorList> _visitList = [];

  @override
  void initState() {
    displayAllTable();
    // TODO: implement initState
    super.initState();
  }

  void displayAllTable() async {
    _visitList = await DB.query();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Visitors List'),
      ),
      body: ListView.builder(
          itemCount: _visitList.length,
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
                        padding: EdgeInsets.only(left:10.0, top: 10.0),
                        child: Row(
                          children: [
                            Text('Name: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                            Text(_visitList[position].visitorName, style: TextStyle(fontSize: 20)),

                          ],
                        ),
                      ),

                  SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left:10.0),
                        child: Row(
                          children: [
                            Text("Address: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                            Text(_visitList[position].address, style: TextStyle(fontSize: 20)),

                          ],
                        ),
                      ),

                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child: Row(
                      children: [
                        Text('Contact No: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                        Text(_visitList[position].number, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child: Row(
                      children: [
                        Text('Guest: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                        _visitList[position].visitedStatus
                            ? Text('Visited', style: TextStyle(fontSize: 20))
                            : Text("Not Visited", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.delete, size: 35, color: Colors.red,),
                          onPressed: () async {
                            await DB.delete(_visitList[position]);
                            displayAllTable();
                          }),
                      IconButton(
                          icon: Icon(Icons.update),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Details'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          //controller: _textEditingController,
                                          decoration: InputDecoration(
                                           //labelText: _visitList[position].visitorName,
                                              hintText: "Add Name"),
                                          onChanged: (value) {
                                            _visitorList.visitorName = value;
                                          },
                                        ),
                                        TextField(
                                          //controller: _textEditingController,
                                          decoration: InputDecoration(
                                              //labelText: _visitList[position].address,
                                              hintText: "Add Address"),
                                          onChanged: (value) {
                                            _visitorList.address = value;
                                          },
                                        ),
                                        TextField(
                                          // controller: _textEditingController,
                                          decoration: InputDecoration(
                                              //labelText: _visitList[position].number,
                                              hintText: "Add Number"),
                                          onChanged: (value) {
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
                                            VisitorList vistorsList =
                                                VisitorList(
                                                    id: _visitList[position].id,
                                                    visitorName: _visitorList
                                                        .visitorName,
                                                    address:
                                                        _visitorList.address,
                                                    number: _visitorList.number,
                                                    visitedStatus: true);
                                            updateDatabase(vistorsList);

                                            // saveToDataBase(_visitorList.visitorName,
                                            //     _visitorList.address, _visitorList.number);

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
                  return AlertDialog(
                    title: Text('add Details'),
                    content: Column(
                      children: [
                        TextField(
                          //controller: _textEditingController,
                          decoration: InputDecoration(hintText: "Add Name"),
                          onChanged: (value) {
                            _visitorList.visitorName = value;
                          },
                        ),
                        TextField(
                          //controller: _textEditingController,
                          decoration: InputDecoration(hintText: "Add Address"),
                          onChanged: (value) {
                            _visitorList.address = value;
                          },
                        ),
                        TextField(
                          // controller: _textEditingController,
                          decoration: InputDecoration(hintText: "Add Number"),
                          onChanged: (value) {
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
                            saveToDataBase(_visitorList.visitorName,
                                _visitorList.address, _visitorList.number);

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
                  );
                });
          },
          icon: Icon(Icons.add),
        ),
      ),
    );
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
  }

  updateDatabase(VisitorList visitorList) async {
    await DB.update(visitorList);
    displayAllTable();
  }
}
