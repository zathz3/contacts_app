import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class searchCep extends StatefulWidget {
  @override
  _searchCepState createState() => _searchCepState();
}

class _searchCepState extends State<searchCep> {
  String _result = '';
  _getCep(String cep) async{
    print('$cep');
    var uri = Uri.parse("https://viacep.com.br/ws/${cep}/json/");
    http.Response response;
    response = await http.get(uri);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    //String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    setState(() {
      _result = "${logradouro}, ${bairro}, ${localidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl1 = TextEditingController();
    FirebaseFirestore db = FirebaseFirestore.instance;
    String cep = '';
    String contactID = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      body: Column(
        children: <Widget> [
          TextFormField(
              decoration: InputDecoration(
                hintText: 'Contact ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              controller: ctrl1,
              validator: (value){
                if (value.isEmpty){
                  return 'Preencha os dados';
                }
                return null;
              }
          ),
          ElevatedButton(

            onPressed: () async{

              setState(() {
                contactID = ctrl1.text;
              });

              print('$contactID');
              await db.collection('Contacts').where('id', isEqualTo: contactID)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  cep = doc['Zip Code'];
                  //print('sad');
                  //print('$cep');
                });
              });
                _getCep(cep);
            }, child: Text('Get Address'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_result'),
          ),
        ],
      ),
    );
  }
}
