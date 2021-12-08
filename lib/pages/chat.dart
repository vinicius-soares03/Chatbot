//import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tela_login/class/api.dart';
import 'package:tela_login/class/clima.dart';
import 'package:tela_login/pages/login.dart';
import 'package:tela_login/services/prefs_service.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';
import 'package:tela_login/class/respostas.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  ValueNotifier<bool> autenticator = ValueNotifier<bool>(false);

  @override
  List<Resposta> respostas = [
    //Resposta('tempo', 'previsão não é de chuva, é de pancada'),
    Resposta(
        'curiosidade',
        'Lá vai uma curiosidade: \n' +
            'O boato que a muralha da china pode ser vista do espaço é falso'),
    Resposta(
        'curiosidade',
        'Lá vai uma curiosidade: \n' +
            'Ursos polares não emitem calor detectável'),
    Resposta(
        'curiosidade',
        'Lá vai uma curiosidade: \n' +
            'Um atum pode nadar até 64 quilômetros em um só dia'),
    Resposta('curiosidade',
        'Lá vai uma curiosidade: \n' + 'As cabras têm sotaques diferentes'),
    Resposta(
        'curiosidade',
        'Lá vai uma curiosidade: \n' +
            'Beija-flores podem voar de frente, de costas e até mesmo de ponta-cabeça'),
    Resposta(
        'curiosidade',
        'Lá vai uma curiosidade: \n' +
            'As formigas são equipadas com cinco narizes diferentes'),
  ];
  List<Resposta> respostas_piadas = [
    Resposta('piada', "Qual é a fórmula da água? H Deus O!"),
    Resposta('piada',
        "Um caipira chega à casa de uma amigo que está vendo TV e pergunta: -E aí, firme? - E o outro responde: - Não, futebor!"),
    Resposta('piada', "Qual é o mercado que voa? É o super-mercado!"),
    Resposta('piada', "O que o pato disse para a pata? Vem Quá!"),
    Resposta('piada',
        "Porque o menino estava falando no telefone deitado? Para não cair a ligação;"),
    Resposta(
        'piada', "Porque o rádio não pode ter filhos? Porque ele é stereo."),
    Resposta('piada',
        "Por que o policial não usa sabão? Porque ele prefere deter gente."),
    Resposta('piada',
        "Por que as plantas pequenas não falam? Porque elas são mudinhas."),
    Resposta('piada', "Qual a fruta que anda de trem? kiwiiiii."),
    Resposta('piada',
        "O que é um astrólogo andando a cavalo? Um Cavaleiro do Zodíaco."),
  ];

  List<Map> historico = [
    {
      "identificador": 0,
      "mensagem": "Olá, meu nome é Chatbot, faça uma pergunta "
    }
  ];

  Widget build(BuildContext context) {
    final entrada_usuario = TextEditingController();

    var data = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
   

    Processar() async {
      var entrada_Formatada =
          entrada_usuario.text.toLowerCase().replaceAll('?', '').trim().split(" ");
      for (int i = 0; i < entrada_Formatada.length; i++) {
        if (entrada_Formatada.contains("previsão") &&
            entrada_Formatada.contains("tempo")) {
          var result = await API.callAPI();

          var message = "";

          if (result != null) {
            for (var i = 0; i < result.length; i++) {
              var forecast = result[i];

              message +=
                  "${forecast?.date} - ${forecast?.description} - Max ${forecast?.max}°C/ Min ${forecast?.min}°C  \n\n";
            }
          }
          setState(() {
            historico.insert(0, {
              "identificador": 0,
              "mensagem": "Previsão para os próximos dias: \n\n" + message
            });
          });
          break;
        }
        if (entrada_Formatada.contains("data") &&
            entrada_Formatada.contains("hoje")) {
          return setState(() {
            historico.insert(0,
                {"identificador": 0, "mensagem": "a data de hoje é " + data});

            //print(historico[0].toString());
          });
        }
        if (entrada_Formatada.contains("seu") &&
            entrada_Formatada.contains("nome")) {
          return setState(() {
            respostas.shuffle();

            historico.insert(
                0, {"identificador": 0, "mensagem": "Meu nome é Chatbot"});

            //print(historico[0].toString());
          });
        }
        if (entrada_Formatada.contains("conte") &&
            entrada_Formatada.contains("piada")) {
          return setState(() {
            respostas_piadas.shuffle();

            historico.insert(0, {
              "identificador": 0,
              "mensagem": respostas_piadas.first.resposta
            });

            //print(historico[0].toString());
          });
        }

        if (entrada_Formatada.contains("curiosidade") 
            ) {
          return setState(() {
            respostas.shuffle();

            historico.insert(
                0, {"identificador": 0, "mensagem": respostas.first.resposta});

            //print(historico[0].toString());
          });
        } else {
          setState(() {
            respostas.shuffle();

            historico.insert(0, {
              "identificador": 0,
              "mensagem": "Não sei o que responder, tente outra pergunta"
            });

            //print(historico[0].toString());
          });
          break;
        }
      }
    }

    //String entrada_usuario;

    //var entrada_usuario = TextEditingController();

    var appBar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        //backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(
          //toolbarOpacity: 0,
          elevation: 1,
          backgroundColor: Color(0xFFffffff),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xFF1775f4),
              )),
          title: Row(children: [
            Container(
              padding: EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo 3.png"),
                backgroundColor: Colors.white,
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Chatbot',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 3),
                  width: 60,
                  child: Text(
                    'Online',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ]),
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 10),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog1();
                      });
                },
                icon: Icon(
                  Icons.help,
                  size: 35,
                  color: Color(0xFF1775f4),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                 
                  Container(
                    height: screenHeight * .91,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: historico.length,
                        itemBuilder: (context, int index) => Chatbot(
                            historico[index]["mensagem"].toString(),
                            historico[index]["identificador"]
                            //identificador

                            )),
                  ),
                  Container(

                      //padding: EdgeInsets.only(bottom:30),

                      child: TextField(
                    controller: entrada_usuario,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            )),
                        suffixIcon: IconButton(
                            onPressed: () {
                              entrada_usuario.text.isNotEmpty
                                  ? {
                                      setState(() {
                                        historico.insert(0, {
                                          "identificador": 1,
                                          "mensagem": entrada_usuario.text
                                        });

                                        //print(historico[0].toString());
                                      }),
                                      Processar(),
                                      entrada_usuario.clear()
                                    }
                                  : '';
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.black87,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Mensagem'),
                  )),
                ],
              ),
            ),
          ]),

          //itleTextStyle: .EdgeInsets.all(10),
        )));
  }

  Widget Chatbot(String mensagem, int identificador) {
    return Column(
        /*mainAxisAlignment: identificador == 1
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,*/

        children: [
          identificador == 0
              ? Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 70, top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Chatbot'))
              : Container(),
          Container(
            child: Row(
              mainAxisAlignment: identificador == 1
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                identificador == 0
                    ? Column(
                        mainAxisAlignment: identificador == 1
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                            Row(children: [
                              Container(
                                  height: 60,
                                  width: 60,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/logo 3.png"),
                                    backgroundColor: Colors.white,
                                  ))
                            ])
                          ])
                    : Container(),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /*SizedBox(
                  width: 2.0,
                ),*/

                      Flexible(
                        child: Column(
                          mainAxisAlignment: identificador == 1
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                                constraints: BoxConstraints(maxWidth: 200),

                                //height: 35,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: identificador == 1
                                        ? Color(0xFF1775f4)
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  mensagem,
                                  overflow: TextOverflow.visible,
                                  maxLines: 1000,

                                  //textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                identificador == 1
                    ? Container(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/user.png"),
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ]);
  }

  Widget Dialog1() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      elevation: 4,
      child: Container(
          height: 330,
          child: Column(children: [
            Container(height: 10, color: Color(0xFF1775f4)),
            Flexible(
                child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/logo 3.png')),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.only(left: 20, right: 20),
                // text

                child: Text(
                    "Sou um Bot novo, tenho muitos bugs ainda, tenha paciência comigo por favor :)",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                //botão tela de login
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: RaisedButton(
                    child: Text(
                      "Ok",
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    color: Color(0xFF1775f4),
                  ),
                ),
              )
            ]))
          ])),
    );
  }
}
