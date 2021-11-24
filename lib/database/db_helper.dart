import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Dbhelper {
  static Future<sql.Database> database() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'store.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE mainlist(id TEXT, title TEXT,para TEXT )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await Dbhelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getdata(String table) async {
    final db = await Dbhelper.database();
    return db.query(table);
  }

  static Future delete(String table, String ids) async {
    final db = await Dbhelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [ids]);
  }

//update dataaaaa
  static Future update(
    String table,
    String ids,
    String title,
    String para,
  ) async {
    final db = await Dbhelper.database();
    return await db.rawUpdate(
        'UPDATE mainlist SET title =?,para =?  WHERE id=? ',
        [title, para, ids]);
  }
}

// ignore: camel_case_types
class recyclehelper {
  static Future<sql.Database> recycledatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'recyclestore.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE recyclelist(id TEXT, title TEXT,para TEXT )');
    }, version: 1);
  }

  static Future<void> recycleinsert(
      String table, Map<String, Object> data) async {
    final db = await recyclehelper.recycledatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> recycledata(String table) async {
    final db = await recyclehelper.recycledatabase();
    return db.query(table);
  }

  static Future recycledelete(String table, String ids) async {
    final db = await recyclehelper.recycledatabase();
    return await db.delete(table, where: 'id = ?', whereArgs: [ids]);
  }
}

// ignore: camel_case_types
class archivehelper {
  static Future<sql.Database> archivedatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'archivestore.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE archivelist(id TEXT, title TEXT,para TEXT )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await archivehelper.archivedatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> archivedata(String table) async {
    final db = await archivehelper.archivedatabase();
    return db.query(table);
  }

  static Future archivedelete(String table, String ids) async {
    final db = await archivehelper.archivedatabase();

    return await db.delete(table, where: 'id = ?', whereArgs: [ids]);
  }
}
