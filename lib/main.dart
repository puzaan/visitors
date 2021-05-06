import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitors/model/visitor_list.dart';
import 'package:visitors/provider/visitor_list.dart';
import 'package:visitors/sqflite_database/sqflite_database.dart';
import 'package:visitors/ui/home_page.dart';
import 'package:visitors/ui/splash_screen.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: ChangeNotifierProvider<ProviderVisitorLists>(
        create: (_) =>ProviderVisitorLists(),
          child: HomePage()),
    );
  }
}
