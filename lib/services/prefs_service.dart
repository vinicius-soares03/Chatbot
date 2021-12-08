import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static final String? _key = 'key';

  static save(String email, String senha) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key!, jsonEncode({"email": email, "senha": senha}));
  }

  static getPrefs(String email, String senha) async {
    var prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('key');
    Map<String, dynamic> map = jsonDecode(json!);
    String get_email = map['email'];
    String get_senha = map['senha'];

    if (email == get_email && senha == get_senha) {
      return print('loggin efetuado');
    } else {
      return print('falha');
    }
  }
  
  static Future <bool> loggin(String email, String  senha) async {
    var prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('key');
    Map<String, dynamic> map = jsonDecode(json!);
    String? get_email = map['email'];
    String? get_senha = map['senha'];
   
    if(get_email!.isEmpty && get_senha!.isEmpty){
      return false;
    }
    if (email == get_email && senha == get_senha) {
      return true;
    }
    

      return false;
  }

  
  

  static cleanPrefs() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
