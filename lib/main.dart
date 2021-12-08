import 'package:flutter/material.dart';
import 'package:tareas/screens/entregadas_screen.dart';
import 'package:tareas/screens/opcion1_screen.dart';
import 'package:tareas/screens/pendientes_screen.dart';
import 'package:tareas/screens/splah_screen.dart';
import 'package:tareas/screens/agregar_tarea.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
     '/agregar' : (BuildContext context) => AgregarTareaScreen(),
     '/tareas' : (BuildContext context) => TareasScreen(),
     '/entregadas':(BuildContext context) => EntregadasTareasScreen(),
     '/pendientes' :(BuildContext context) => PendientesTareasScreen()
      },
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
    );
  }
}