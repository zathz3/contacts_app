import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/Pages/contacts.dart';
import 'package:contacts_app/Pages/SignUp.dart';
import 'package:contacts_app/Pages/var.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController _ctrl = TextEditingController();
  TextEditingController _ctrl2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('Users').orderBy('Date', descending: true).limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        login = doc['Login'];
        password = doc['Password'];
        print('$login');
        print('$password');
      });
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            child: TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                  labelText: 'Login',
                  hintText: 'Login'
              ),
              onChanged: (text){
              },
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10,0,10,10),
            child: TextField(
              controller: _ctrl2,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password'
              ),
              obscureText: true,
              onChanged: (text){
              },
            ),
          ),

          ButtonTheme(
            minWidth: 200,
            height: 50,
            child: RaisedButton(
                child: Text('Login'),
                onPressed: (){
                  if (_ctrl.text == login && _ctrl2.text == password){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contacts()),
                    );
                  }
                }
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
          ),

          MaterialButton(
            elevation: 5.0,
            child: Text('Sign Up'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            }
          ),

        ],
      ),
    );
  }
}