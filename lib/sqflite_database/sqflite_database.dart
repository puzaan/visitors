import 'package:sqflite/sqflite.dart';
import 'package:visitors/model/visitor_list.dart';

class DB {
  static Database _db;
  static int get _version => 1;

  static final String TABLE_NAME = 'TASKS';

  static Future<void> init() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task';
        _db = await openDatabase(_path, version: _version, onCreate: onCreate);
        print(_path);
      } catch (e) {
        print(e);
      }
    }
  }

  static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE $TABLE_NAME("
        "id INTEGER PRIMARY KEY,"
        "visitorName TEXT,"
        "address TEXT,"
        "number TEXT,"
        "visitedStatus TEXT"
        ")");
  }

  static Future<int> insert(VisitorList visitorList) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM $TABLE_NAME");
    int id = table.first['id'];

    var raw = await _db.rawInsert(
        "INSERT Into $TABLE_NAME(id, visitorName, address, number, visitedStatus)"
        "VALUES (?,?,?,?,?)",
        [
          id,
          visitorList.visitorName,
          visitorList.address,
          visitorList.number,
          visitorList.visitedStatus
        ]);
    return raw;
  }

  static Future<List<VisitorList>> query() async {
    var res = await _db.query('$TABLE_NAME');
    print(res);

    List<VisitorList> visitorList = [];

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        visitorList.add(VisitorList(
            visitorName: res[i]['visitorName'],
            id: res[i]['id'],
            address: res[i]['address'],
            number: res[i]['number'],
            visitedStatus: res[i]['visitedStatus'] == 'true' ? true : false));
      }
    }
    return visitorList;
  }

  static Future<int> delete(VisitorList visitorList) async {
    await _db
        .delete("$TABLE_NAME", where: 'id =?', whereArgs: [visitorList.id]);
  }

  static Future<int> update(VisitorList visitorList) async {
    await _db.update('$TABLE_NAME', visitorList.toMap(),
        where: 'id = ?', whereArgs: [visitorList.id]);
  }
}
