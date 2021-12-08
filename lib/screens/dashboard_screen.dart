import 'package:flutter/material.dart';
import 'package:tareas/utils/color_settings.dart';


class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DASHBOARD'),
          backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
          UserAccountsDrawerHeader(
            accountName:
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('PÉREZ HERNÁNDEZ MARÍA ESTELA'),
                )
              ],
            ),
            accountEmail:
            Row(
            children: <Widget>[
              Expanded(
                  child: Text('perez.estela@itcelaya.edu.mx'),
              )
            ],
            ),
            currentAccountPicture: Row(
              children: <Widget>[
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/logo.png"),
                    backgroundColor: Colors.green,
                    radius: 100,
                  ),
                ),

              ],
              mainAxisAlignment: MainAxisAlignment.end,

            ),
            decoration: BoxDecoration(
              color: ColorSettings.colorPrimary
            ),

          ),
            ListTile(
              title: Text('Tareas'),
              subtitle: Text('Aplicacion de registro de tareas'),
              leading: Icon(Icons.notes),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,'/tareas');

              },
            )
        ],
        ),
      ),
    );
  }
}
