import 'package:flutter/material.dart';
import 'package:tareas/database/database_helper.dart';
import 'package:tareas/models/tarea_model.dart';
import 'package:tareas/utils/color_settings.dart';

import 'agregar_tarea.dart';

class EntregadasTareasScreen extends StatefulWidget {
  const EntregadasTareasScreen({Key? key}) : super(key: key);

  @override
  _EntregadasTareasScreenState createState() => _EntregadasTareasScreenState();
}

class _EntregadasTareasScreenState extends State<EntregadasTareasScreen>  {

  //indica que posterirormente sera inicializado late
 late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
  _databaseHelper = DatabaseHelper();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        backgroundColor: ColorSettings.colorButton,
        title: Text('Tareas entregadas'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context,'/tareas').whenComplete(
                  () { setState(() {});
                  }
                  );
              },
              icon: Icon(Icons.undo)
          ),
         
        ] 
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllTareasEntregadas(),
        builder: (BuildContext context,AsyncSnapshot<List<TareaModel>> snapshot){
if ( snapshot.hasError ){
  return Center( child: Text('Ocurrio un error en la peticion'),);
}else {
  if( snapshot.connectionState == ConnectionState.done){
    return _listadoTareas(snapshot.data!);
  } else {
    return Center( child: CircularProgressIndicator(),);
  }
}
        },
      ),
    );
  }

  Widget _listadoTareas(List<TareaModel> tareas){
    return RefreshIndicator(
      onRefresh: (){
        return Future.delayed(
          Duration(seconds: 2),
          (){ setState((){});}
        );
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index){
          TareaModel tarea = tareas[index];
          return Card(
            child: Column(
              
              children : [
                Text(tarea.nomTarea!, style: TextStyle(fontWeight: FontWeight.bold),),
                Text(tarea.dscTarea!, style: TextStyle(fontWeight: FontWeight.bold),),
                Text(tarea.fechaEntrega!, style: TextStyle(fontWeight: FontWeight.normal),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarTareaScreen(tarea: tarea,)
                          )
                        );
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 18,
                    ),
                    IconButton(
                      onPressed: (){
                        //pedir una peticion
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('Ventana de Confirmación'),
                                content: Text('¿Estas seguro de eliminar esta tarea'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        _databaseHelper.delete(tarea.idTarea!).then(
                                                (noRows ) {
                                                  if( noRows > 0) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                         SnackBar(content: Text('El registro se elimino correctamente'))
                                                    );
                                                    setState(() {});
                                                  }
                                                }
                                        );
                                      },
                                      child: Text('Si'),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'),
                                    )
                                  ],
                              );
                            });
                      },
                      icon: Icon(Icons.delete),
                      iconSize: 18,
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: tareas.length,
      ),
    );
  }
}
