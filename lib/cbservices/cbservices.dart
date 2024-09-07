import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/controller/todoctrler.dart';

class Dbservice {
  static Database? database;
  Future<void> initialisedb() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE todotable (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, details TEXT, icon TEXT)');
    });
  }

  


 

// Function to get Icon widget based on name
 

  Future<void> addvalues({
    required String name,
    required String icon,
    required String details,
  }) async {
    int a = await database!.insert(
      'todotable',
      {'name': name, 'details': details, 'icon': icon},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getValues() async {
    final List<Map<String, Object?>> todolist =
        await database!.query('todotable');
    return todolist;
  }
}
