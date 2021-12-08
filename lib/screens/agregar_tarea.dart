
import 'package:flutter/material.dart';
import 'package:tareas/database/database_helper.dart';
import 'package:tareas/models/tarea_model.dart';
import 'package:tareas/utils/color_settings.dart';

class AgregarTareaScreen extends StatefulWidget {
 TareaModel? tarea;
  AgregarTareaScreen({Key? key, this.tarea}) : super(key: key);

  @override
  _AgregarTareaScreenState createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
 
 late DatabaseHelper _databaseHelper;

 TextEditingController _controllerNomTarea = TextEditingController();
 TextEditingController _controllerDscTarea = TextEditingController();
 TextEditingController _controllerFechaEntrega = TextEditingController();
 TextEditingController _controllerEntregada = TextEditingController();
 

@override 
void initState(){
 // super.initState();
    if( widget.tarea != null){
      _controllerNomTarea.text = widget.tarea!.nomTarea!;
      _controllerDscTarea.text= widget.tarea!.dscTarea!;
      _controllerFechaEntrega.text= widget.tarea!.dscTarea!;
      _controllerEntregada.text = widget.tarea!.entregada!;
    }
    _databaseHelper = DatabaseHelper();
}

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary2,
        title: widget.tarea == null ? Text('Agregar Tarea') : Text('Editar Tarea'),
      ),
      body:
      Scrollbar(
      child:  Column(
        children: [
          _crearTextFieldNombre(),
        _crearTextFieldDescripcion(),
        _crearTextFieldFecha(),
        _crearTextFieldEntrega(),

          ElevatedButton(
            onPressed: (){

              if(widget.tarea == null ){

              TareaModel tarea = TareaModel(
                nomTarea: _controllerNomTarea.text,
                dscTarea: _controllerDscTarea.text,
                fechaEntrega: _controllerFechaEntrega.text,
                entregada: _controllerEntregada.text
              );

              _databaseHelper.insert(tarea.toMap()).then(
                  (value) {
                    if(value > 0){
                      Navigator.pop(context);
                    /*  ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registro insertado correctamente'))
                      );*/
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('la solicitud no se completo'))
                      );
                    }
                  }
              );
              } else {
                TareaModel tarea = TareaModel(
                 idTarea: widget.tarea!.idTarea,
                nomTarea: _controllerNomTarea.text,
                dscTarea: _controllerDscTarea.text,
                fechaEntrega: _controllerFechaEntrega.text,
                entregada: _controllerEntregada.text
              ); 
              _databaseHelper.update(tarea.toMap()).then(
                (value) {
                  if(value > 0){
                     var nav = Navigator.of(context);
                        nav.pop();
                        nav.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('La solicitud no se completo'))
                    );
                  }
                }
                );
              }
            },
            child: Text('Guardar Tarea'),
          ),
        ],
      ),
      )
    );
  }


Widget _crearTextFieldNombre(){
    return TextField(
      controller:   _controllerNomTarea,
     keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "Nombre de la tarea ",
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value){
      },
    );
  }

Widget _crearTextFieldDescripcion(){
    return TextField(
      controller:   _controllerDscTarea,
     keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "Descripcion de la tarea ",
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value){
      },
    );
  }
  Widget _crearTextFieldFecha(){
    return TextField(
      controller:   _controllerFechaEntrega,
     keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "Establecer Fecha de entrega DD/MM/AA ",
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value){
      },
    );
  }
  Widget _crearTextFieldEntrega(){
    return TextField(
      controller:   _controllerEntregada,
     keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: "Estatus de entrega Si/No ",
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value){
      },
    );
  }
}