import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_login/class/api.dart';
//import 'package:tela_login/pages/chat.dart';
import 'package:tela_login/pages/login.dart';
import 'package:tela_login/services/prefs_service.dart';

void main() {
 
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
    title: 'Chatbot',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
   routes: {
     
   },
   
   home: Login(),
 
   
    );
      
   
  }
}

