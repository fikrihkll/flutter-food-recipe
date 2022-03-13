import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:first_flutter_app/model/meal_db_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "MealDb");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE MealDb(id INTEGER PRIMARY KEY, name TEXT, picture TEXT, uid TEXT, date TEXT)");
    print("DB Created");
  }

  Future<int> saveNote(MealDBModel note) async {
    var dbClient = await db;
    int res = await dbClient.insert("MealDb", note.toMap());
    print("Data Inserted");
    return res;
  }

  Future<List<MealDBModel>> getMeal() async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM MealDb ORDER BY date DESC");
    List<MealDBModel> notedata = new List();
    for(int i=0; i<list.length; i++){
      var note = MealDBModel(
        list[i]["name"],
        list[i]["picture"],
        list[i]["uid"],
        list[i]["date"],
      );
      note.setMealId(list[i]['id']);
      notedata.add(note);
    }

    return notedata;
  }

  Future<bool> updateMeal(MealDBModel note) async{
    var dbClient = await db;
    int res = await dbClient.update("name", note.toMap(),
        where: "id=?",
        whereArgs: <int>[note.id]
    );
    return res > 0 ? true : false;
  }

  Future<int> deleteMeal(MealDBModel note) async{
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE FROM MealDb WHERE uid = ?", [note.uid]);
    print("deleted");
    return res;
  }
}