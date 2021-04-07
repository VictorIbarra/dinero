import 'dart:io';
import 'package:path/path.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'DineroEnUnClick_v2.db');
    print(path);
    return await openDatabase(path, version: 12, onOpen: (db) {},
        onUpgrade: (Database db, int version, int v) async {
      await db.execute("""DROP TABLE IF EXISTS Usuario""");
      await db.execute("""
            CREATE TABLE Usuario(
              Cliente_Id INTEGER,
              Promotor_Id INTEGER,
              NombreCompleto TEXT,
              RFC TEXT,
              Correo TEXT,
              Telefono TEXT,
              LineaCreditoMax REAL,
              ClaveRegistroPiN TEXT,
              Clabe TEXT,
              PantallaPrincipal TEXT,
              IdUsuarioCliente INTEGER,
              ClientePF BOOLEAN
            )""");
    }, onCreate: (Database db, int version) async {
      await db.execute("""
            CREATE TABLE Usuario(
              Cliente_Id INTEGER,
              Promotor_Id INTEGER,
              NombreCompleto TEXT,
              RFC TEXT,
              Correo TEXT,
              Telefono TEXT,
              LineaCreditoMax REAL,
              ClaveRegistroPiN TEXT,
              Clabe TEXT,
              PantallaPrincipal TEXT,
              IdUsuarioCliente INTEGER,
              ClientePF BOOLEAN
            )""");
    });
  }

  resetUsuario() async {
    final db = await database;
    final res = await db.delete('Usuario');
    Usuario.idCliente = 0;
    return res;
  }

  insertUsuario(Usuario usr) async {
    resetUsuario();

    final db = await database;
    final userToInsert = usr.toJsonLoginResponse();
    final res = await db.insert('Usuario', userToInsert);
    Usuario.idCliente = usr.clienteId;
    return res;
  }

  Future<Usuario> selectUsuario() async {
    final db = await database;
    final res = await db.query('Usuario');
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromJson(c)).toList() : [];
    try {
      Usuario.idCliente = list[0].clienteId;
      Usuario.usr = list[0];
    } catch (Exception) {
      Usuario.idCliente = 0;
      list.add(Usuario());
    }

    print(list[0]);

    return list[0];
  }
}
