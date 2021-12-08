import 'dart:convert';
//import 'dart:html';
import 'dart:ui';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_login/class/respostas.dart';

import 'package:tela_login/pages/login.dart';
import 'package:tela_login/services/prefs_service.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _Cadastro createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  TextEditingController email_input = TextEditingController();
  TextEditingController senha_input = TextEditingController();
  ValueNotifier<bool> autenticator = ValueNotifier<bool>(false);
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/logo.png',
                alignment: Alignment.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                    child: Text(
                  'Crie uma conta ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ))),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  child: TextField(
                    controller: email_input,
                    // maxLength: 25,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      icon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextField(
                    controller: senha_input,
                    // maxLength: 25,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Senha',
                      icon: Icon(Icons.password),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: inLoader,
                    builder: (_, inloader, __) => inloader
                        ? Column(children: [
                            Container(height: 30),
                            Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator())
                          ])
                        : Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 30, top: 30),
                              width: 300,
                              //height: 30,

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: RaisedButton(
                                  child: Text(
                                    'Cadastrar',
                                  ),
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    await Loading();

                                    email_input.text.isNotEmpty &&
                                            senha_input.text.isNotEmpty
                                        ? {
                                            print('sucesso'),
                                            PrefsService.save(email_input.text,
                                                senha_input.text),
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog1();
                                                }),
                                          }
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                'Email ou senha incorreta'),
                                            duration: Duration(seconds: 2),
                                          ));

                                    email_input.clear();
                                    senha_input.clear();
                                  },
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          )),
                ValueListenableBuilder<bool>(
                    valueListenable: inLoader,
                    builder: (_, inloader, __) => inloader
                        ? Container()
                        : Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 30),
                              width: 300,
                              //height: 30,

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: RaisedButton(
                                  child: Text(
                                    'Voltar para login',
                                  ),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Login()));
                                  },
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )),
              ],
            ),
          ],
        ),
      )),
    )));
  }

  validateEmail(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return true;
    }
    return false;
  }

  Loading() async {
    inLoader.value = true;
    await Future.delayed(Duration(seconds: 3));
    inLoader.value = false;
  }

  Widget Dialog1() {
    return Dialog(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Container(
          height: 200,
          child: Column(children: [
            Container(height: 10, color: Color(0xFF009245)),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset('assets/images/selo.png')),
            ),
            Container(
              // text

              child: Text("Cadastro feito com sucesso",
                  style: TextStyle(
                      color: Color(0xFF009245),
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
            ),
            Expanded(
                child: SizedBox(
              height: 10,
            )),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              //botão tela de login
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: RaisedButton(
                  child: Text(
                    "Fazer login",
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()));
                  },
                  color: Color(0xFF009245),
                ),
              ),
            )
          ])),
    );
  }
}
