import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // initialize db for performing opertaions.

  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    bool databaseExists = await File(path).exists();
    if (!databaseExists) {
      // If the database doesn't exist, create a new one
      return await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // Create the details table
        await db.execute('''
      CREATE TABLE details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT DEFAULT '',
        address TEXT DEFAULT '',
        email TEXT DEFAULT '',
        jobtitle TEXT DEFAULT '',
        salary REAL DEFAULT 0.0,
        initialmoney REAL DEFAULT 0.0,
        updatedmoney REAL DEFAULT 0.0,
        incomeupdateddate TEXT DEFAULT ''
      )
    ''');

        // Create the transactions table
        await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        iconData TEXT,
        name TEXT,
        description TEXT,
        type TEXT,
        amount REAL,
        date TEXT
      )
    ''');

        // Create the savings table
        await db.execute('''
      CREATE TABLE savings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        iconData TEXT,
        name TEXT,
        goal REAL,
        current REAL DEFAULT 0.0,
        date TEXT
      )
    ''');
      });
    } else {
      // If the database exists, open the existing one
      return await openDatabase(path, version: 1);
    }
  }

  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    Database db = await initializeDB();
    return await db.insert(tableName, data);
  }

  Future<int> update(String tableName, Map<String, dynamic> data) async {
    Database db = await initializeDB();
    return await db
        .update(tableName, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> delete(String tableName, int id) async {
    Database db = await initializeDB();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    Database db = await initializeDB();
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> getAllConditional(
      String tableName, String orderBy) async {
    Database db = await initializeDB();
    return await db.query(tableName, orderBy: orderBy);
  }

  Future<List<Map<String, dynamic>>> getSelected(
      String tableName, List<String> columns) async {
    Database db = await initializeDB();
    return await db.query(tableName, columns: columns);
  }

  Future<List<Map<String, dynamic>>> rawQueryy(String query) async {
    Database db = await initializeDB();
    return await db.rawQuery(query);
  }
}
