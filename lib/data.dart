import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  late final Database _db;

  Future<Database> get db async {
    if (_db?.isOpen == true) return _db!;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "mydb.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS vehicles(id INTEGER PRIMARY KEY, type TEXT, model TEXT, plateNum TEXT, color TEXT, engineNum TEXT, workDone TEXT, driverName TEXT, company TEXT, faultType TEXT, entryDate TEXT, exitDate TEXT, installedParts TEXT, cost TEXT, engineerName TEXT)");

    await db.execute(
        "CREATE TABLE IF NOT EXISTS workers(id INTEGER PRIMARY KEY, name TEXT, profession TEXT, nationalId TEXT, militaryId TEXT, receivedAmount TEXT, completionReport TEXT, uncompletedWorks TEXT, underCompletion TEXT, date TEXT, supervisor TEXT)");

    await db.execute(
        "CREATE TABLE IF NOT EXISTS store(id INTEGER PRIMARY KEY, storeName TEXT, partName TEXT, rackNum TEXT, quantity INTEGER, receivedDate TEXT, issuedDate TEXT, remainingBalance INTEGER, issueOrderNum TEXT, beneficiary TEXT, vehicleNum TEXT, partNum TEXT, amount TEXT, invoiceNum TEXT, supplier TEXT)");
  }

  // Vehicles Table Functions

  Future<int> saveVehicle(Map<String, dynamic> vehicle) async {
    var dbClient = await db;
    int res = await dbClient?.insert("vehicles", vehicle) ?? 0;
    return res;
  }

  Future<List<Map<String, dynamic>>> getVehicles() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM vehicles');
    return list;
  }

  Future<int> updateVehicle(Map<String, dynamic> vehicle) async {
    var dbClient = await db;
    int res = await dbClient.update("vehicles", vehicle,
        where: "id = ?", whereArgs: [vehicle['id']]);
    return res;
  }

  Future<int> deleteVehicle(int id) async {
    var dbClient = await db;
    int res =
        await dbClient.delete("vehicles", where: "id = ?", whereArgs: [id]);
    return res;
  }

  // Workers Table Functions

  Future<int> saveWorker(Map<String, dynamic> worker) async {
    var dbClient = await db;
    int res = await dbClient.insert("workers", worker);
    return res;
  }

  Future<List<Map<String, dynamic>>> getWorkers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM workers');
    return list;
  }

  Future<int> updateWorker(Map<String, dynamic> worker) async {
    var dbClient = await db;
    int res = await dbClient
        .update("workers", worker, where: "id = ?", whereArgs: [worker['id']]);
    return res;
  }

  Future<int> deleteWorker(int id) async {
    var dbClient = await db;
    int res =
        await dbClient.delete("workers", where: "id = ?", whereArgs: [id]);
    return res;
  }

  // Store Table Functions

  Future<int> saveStore(Map<String, dynamic> store) async {
    var dbClient = await db;
    int res = await dbClient.insert("store", store);
    return res;
  }

  Future<List<Map<String, dynamic>>> getStore() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM store');
    return list;
  }

  Future<int> updateStore(Map<String, dynamic> store) async {
    var dbClient = await db;
    int res = await dbClient
        .update("store", store, where: "id = ?", whereArgs: [store['id']]);
    return res;
  }

  Future<int> deleteStore(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("store", where: "id = ?", whereArgs: [id]);
    return res;
  }
}
