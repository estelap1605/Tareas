
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tareas/screens/login_screen.dart';
import 'package:tareas/utils/color_settings.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen ({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context){
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 5000,
      imageSrc: 'assets/logo.png',
      imageSize: 150,
      text: 'Tareas',
      backgroundColor: ColorSettings.colorPrimary4,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      colors: [
        Colors.red,
        Colors.grey,
        Colors.green,
        Colors.yellow
      ],
    );
}

}