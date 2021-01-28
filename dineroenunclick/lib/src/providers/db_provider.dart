import 'dart:io';

import 'package:path/path.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'DineroEnUnClick_v2.db');

    print(path);

    return await openDatabase(
      path, 
      version: 3, 
      onOpen:(db){}, 
      onCreate: (Database db, int version) async{
        /*await db.execute('CREATE TABLE Version( version REAL, release INTEGER)');
        await db.execute('CREATE TABLE Equipos( id INTEGER PRIMARY KEY, nombre TEXT, color TEXT, puntos REAL)');*/
        
        await db.execute("""
            CREATE TABLE Usuario( Cliente_Id INTEGER, Promotor_Id INTEGER, NombreCompleto TEXT, RFC TEXT, Correo TEXT, Telefono TEXT, LineaCreditoMax REAL, ClaveRegistroPiN TEXT, Clabe TEXT
            )""");
        /*await db.execute("""
            CREATE TABLE Visitante( idVisitante INTEGER PRIMARY KEY, codigo TEXT, residenciaId INTEGER, tipoId INTEGER, nombreCompleto TEXT, placas TEXT, fecAlta TEXT, permitido INTEGER
            )""");*/
      }
    );

  }


  resetUsuario() async{
    final db = await database;
    final res = await db.delete('Usuario');
    Usuario.idCliente = 0;
    return res;
  }

  insertUsuario(Usuario usr) async {
    resetUsuario();

    final db = await database;
    final res = await db.insert('Usuario', usr.toJsonLoginResponse());
    Usuario.idCliente = usr.clienteId;
    return res;
  }

  Future<Usuario> selectUsuario() async{
    final db = await database;
    final res = await db.query('Usuario');
    List<Usuario> list = res.isNotEmpty ? res.map((c)=>Usuario.fromJson(c)).toList() : [];
    try{
      Usuario.idCliente = list[0].clienteId;
      Usuario.usr = list[0];
    }
    catch(Exception){
      Usuario.idCliente = 0;
      list.add(Usuario());
    }

    print(list[0]);
    
    return list[0];
  }


  


/*
  initClientes(List<Equipo> list){

    resetCliente();
    
    for(int i=0; i<list.length; i++){
      insertEquipo(list[i]);
    }

  }

  insertEquipo(Equipo c) async {
    final db = await database;
    final res = await db.insert('Equipos', c.toJson());
    return res;
  }


  sCliente(int id) async {
    final db = await database;
    final res = await db.query('Equipos', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Equipo.fromJson(res.first) : null;
  }

  selectEquipoById(int id) async {
    final db = await database;
    final res = await db.query('Equipos', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Equipo.fromJson(res.first) : null;
  }

  Future<List<Equipo>> selectEquipos() async{
    final db = await database;
    final res = await db.query('Equipos');
    List<Equipo> list = res.isNotEmpty ? res.map((c)=>Equipo.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateEquipo(Equipo c)async{
    final db = await database;
    final res = await db.update('Equipos', c.toJson(), where: 'id = ?', whereArgs: [c.id]);
    return res;
  }


  Future<int> uCliente(Equipo c)async{
    final db = await database;
    final res = await db.update('Equipos', c.toJson(), where: 'id = ?', whereArgs: [c.id]);
    return res;
  }

  dEquipo(int id) async{
    final db = await database;
    final res = await db.delete('Equipos', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<Version>> selectVersion() async{
    final db = await database;
    final res = await db.query('Version');
    List<Version> list = res.isNotEmpty ? res.map((c)=>Version.fromJson(c)).toList() : [];
    return list;
  }

  insertVersion(Version c) async {
    final db = await database;
    final res = await db.insert('Version', c.toJson());
    return res;
  }

  deleteVersion() async{
    final db = await database;
    final res = await db.delete('Version');
    return res;
  }
  

  Future<List<Palabra>> selectPalabras() async{
    final db = await database;
    final res = await db.query('Palabras', where: 'usada = ?', whereArgs: [0]);
    List<Palabra> list = res.isNotEmpty ? res.map((c)=>Palabra.fromJson(c)).toList() : [];
    return list;
  }

  insertPalabra(Palabra c) async {
    final db = await database;
    final res = await db.insert('Palabras', c.toJson());
    return res;
  }

  Future<int> updatePalabra(Palabra c) async {
    final db = await database;
    final res = await db.update('Palabras', c.toJson(), where: 'id = ?', whereArgs: [c.id]);
    return res;
  }

  restartPalabra() async {
    final db = await database;
    final res = await db.execute('UPDATE Palabras SET usada = 0');
    return res;
  }

  deletePalabras() async{
    final db = await database;
    final res = await db.delete('Palabras');
    return res;
  }


  resetCliente() async{
    final db = await database;
    final res = await db.delete('Equipos');
    return res;
  }*/

}