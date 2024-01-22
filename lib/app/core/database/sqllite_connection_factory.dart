// ignore_for_file: constant_identifier_names

import 'dart:io' as io;
import 'package:autocenter/app/core/database/sqlite_migration_factory.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

class SqlliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'AUTO_CENTER';

  static SqlliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqlliteConnectionFactory._();

  factory SqlliteConnectionFactory() {
    _instance ??= SqlliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    sqfliteFfiInit();

    final databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();

    //Create path for database
    String dbPath = p.join(appDocumentsDir.path, "databases", _DATABASE_NAME);
    debugPrint('-=-=-=-=-=-=-=- DB=$dbPath');
    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await databaseFactory.openDatabase(
          dbPath,
          options: OpenDatabaseOptions(
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          ),
        );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(db) async {
    await db.execute('PRAGMA foreing_keys=ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint('On CREATED CALL');
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('On UPGRADE');
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpdateMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('On DOWNUPGRADE');
    final batch = db.batch();
    batch.commit();
  }
}
