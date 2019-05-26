import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:easy_job/internal_db/prefrences/prefrence.dart';

/*
 * This class is the sqflite layer to the app, it includes CRUD* operations for the table Prefrences
*/

class PrefrenceHelper {
  String _tableName = 'prefrences';
  static Database _database;

/**
 * These are the table column to be generated 
 */
  String colId = 'id';
  String colGender = 'gender';
  String colCertificate = 'certificate';
  String colRegion = 'region';

/**
 * This is the singleton declaration
 */
  static PrefrenceHelper _PrefrenceHelper;
  PrefrenceHelper._createInstance();

  factory PrefrenceHelper() {
    if (_PrefrenceHelper == null) {
      _PrefrenceHelper = PrefrenceHelper._createInstance();
    }
    return _PrefrenceHelper;
  }

  Future<Database> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'prefrences.db');
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colGender TEXT, $colCertificate TEXT, $colRegion TEXT) ');
  }

/**
 * getPrefrencesList() is to get all table list
 */
  Future<List<Map<String, dynamic>>> getPrefrencesList() async {
    Database db = await this.database;
    return await db.query(_tableName, orderBy: '$colId ASC');
  }

/**
 * insertPrefrences() method is to insert a prefrence 
 */
  Future<int> insertPrefrences(Prefrence prefrence) async {
    Database db = await this.database;
    int result = await db.insert(_tableName, prefrence.toMap());
  
    return result; 
    
    }

/**
 * Updating a prefrence
 */
  Future<int> updatePrefrences(Prefrence prefrence) async {
    Database db = await this.database;
    return await db.update(_tableName, prefrence.toMap(),
        where: '$colId = ?', whereArgs: [prefrence.id]);
  }

  /**
   * Delete a prefrence
   */
  Future<int> deletePrefrence(Prefrence prefrence) async {
    Database db = await this.database;
    return await db
        .delete(_tableName, where: '$colId = ?', whereArgs: [prefrence.id]);
  }

/**Get the count of the table raws
 * 
 * 
 */

  Future<int> count() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $_tableName');
    return Sqflite.firstIntValue(x);
  }
/**
 *      
 * Add to database only if raws are 3 or just replace. 
 */

  Future<int> addPrefrenceOnly(Prefrence prefrence) async {
    Database db = await this.database;
    await getPrefrencesList().then((data) {
      if (data.length < 3) {
        insertPrefrences(prefrence);
      } else {
        deletePrefrence(new Prefrence.fromMapObject(data.elementAt(2)));
        insertPrefrences(prefrence);
      }
    });
  }
}
