import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_login/pages/chat.dart';
import 'package:tela_login/pages/cadastro.dart';

import 'package:tela_login/services/prefs_service.dart';
import 'package:tela_login/valores/preferences_chaves.dart';

import 'chat.dart';

class Login extends StatelessWidget {
  //const Login({Key? key}) : super(key: key);

  TextEditingController emailInput = TextEditingController();
  TextEditingController senhaInput = TextEditingController();
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child:
      Container(
        height: MediaQuery.of(context).size.height*.9,
        width: MediaQuery.of(context).size.width*.9,
        
      
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: emailInput,

              //maxLength:25,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: senhaInput,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    
                      borderRadius: BorderRadius.circular(20)),
                  icon: Icon(Icons.password),
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.black54),
                  onPressed: () {},
                  child: const Text(
                    'Recuperar Senha',
                    textAlign: TextAlign.right,
                  ),
                )),
            const Padding(padding: EdgeInsets.all(4.0)),
            ValueListenableBuilder<bool>(
                valueListenable: inLoader,
                builder: (_, inloader, __) => inloader
                    ? Column(children: [
                        Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator())
                      ])
                    : Container(
                      padding: EdgeInsets.only(left:30,right: 30),
                      
                      
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () async {
                            await Loading();
                            emailInput.text.isNotEmpty &&
                                    senhaInput.text.isNotEmpty
                                ? {
                                    PrefsService.loggin(
                                            emailInput.text, senhaInput.text)
                                        .then(
                                      (result) {
                                        if (result) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Chat()));
                                        } else ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      elevation: 4,
                                      content: Text('Email ou senha incorreto'),
                                      duration: Duration(seconds: 2),
                                    ));
                                      },
                                    ),
                                  }
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Email ou senha incorreto'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                            emailInput.clear();
                            senhaInput.clear();
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ))),
            ValueListenableBuilder<bool>(
              valueListenable: inLoader,
              builder: (_, inloader, __) => inloader
                  ? Container()
                  : Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: ClipRRect(
                    
                      borderRadius: BorderRadius.circular(40),
                      child: RaisedButton(
                          child: Text("Cadastre-se"),
                          textColor: Colors.white,
                          onPressed: () async {
                            await Loading2();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Cadastro()));
                          },
                          color: Colors.grey),
                    )),
            )
          ],
        ),
      ),
    ));
  }

  Loading() async {
    inLoader.value = true;
    await Future.delayed(Duration(seconds: 3));
    inLoader.value = false;
  }

  Loading2() async {
    inLoader.value = true;
    await Future.delayed(Duration(seconds: 2));
    inLoader.value = false;
  }
}
