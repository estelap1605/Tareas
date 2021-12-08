import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tareas/models/tarea_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

    static final _nombreBD ='TAREASDB';
    static final _versionBD = 1;
    static final _nombreTBL = 'tblTareas';

static Database? _database;
  Future<Database?> get database async {
    if(_database !=null) return _database;
    _database = await _initDatabase();
    return _database;
  }

Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path,_nombreBD);
    return openDatabase(
       rutaBD, version: _versionBD, onCreate: _crearTabla,
    );
 }

Future<void> _crearTabla(Database db, int version) async {
   await db.execute("CREATE TABLE $_nombreTBL (idTarea INTEGER PRIMARY KEY, nomTarea VARCHAR(50), dscTarea VARCHAR(100), fechaEntrega VARCHAR(8), entregada VARCHAR(2))");   
 }
  //nos regresara el id del valor insertado
  Future<int> insert(Map<String,dynamic> row) async{
    //asegurarse de recuperar la conexion
   var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
   // return conexion!.insert(_nombreTBL2,row);
  }
    Future<int> update(Map<String,dynamic> row) async{
     var conexion = await database;
    // return conexion!.update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
     return conexion!.update(_nombreTBL, row, where: 'idTarea = ?', whereArgs: [row['idTarea']]);
  }
   Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'idTarea = ?',whereArgs: [id]);
  }

    //vamos a regresar una lista de notas Model , una lista de objetos
  Future<List<TareaModel>> getAllTareas() async {
    var conexion = await database;
    //query es como un select  , una lista de mapas
    var result = await conexion!.query(_nombreTBL);
  //se va a iterar entre cada elemento de la lista y recupera el mapa  asi nos regresa una lista de objetos
   return result.map((TareaMap) => TareaModel.fromMap(TareaMap)).toList();
  }

    Future<List<TareaModel>> getAllTareasEntregadas() async {
    var conexion = await database;
    //query es como un select  , una lista de mapas
    var result = await conexion!.query(_nombreTBL, where: 'entregada = ?',whereArgs:['Si']);
  //se va a iterar entre cada elemento de la lista y recupera el mapa  asi nos regresa una lista de objetos
  return result.map((TareaMap) => TareaModel.fromMap(TareaMap)).toList();
  }
  Future<List<TareaModel>> getAllTareasPendientes() async {
    var conexion = await database;
    //query es como un select  , una lista de mapas
    var result = await conexion!.query(_nombreTBL, where: 'entregada = ?',whereArgs:['No']);
  //se va a iterar entre cada elemento de la lista y recupera el mapa  asi nos regresa una lista de objetos
  return result.map((TareaMap) => TareaModel.fromMap(TareaMap)).toList();
  }

  Future<TareaModel> getTarea(int id) async {
      var conexion = await database;
      var result = await conexion!.query(_nombreTBL, where: 'idTarea = ?', whereArgs: ['id']);
     // return result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
     return TareaModel.fromMap(result.first);
  }
}