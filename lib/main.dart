import 'package:citrusleaf/constant/Constant.dart';
import 'package:citrusleaf/sign_in.dart';
import 'package:citrusleaf/ui/phonepe.dart';
import 'package:citrusleaf/ui/splashscreen.dart';
import 'package:flutter/material.dart'; 




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      home: 
        SplashScreen(),
      theme: new ThemeData(primaryColor: Colors.blue[800],
      ),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        PHONE_PE: (BuildContext context) => Phonepe(),
     SIGN_IN: (BuildContext context) => SignIn(),
     


      },
    );
  }
}