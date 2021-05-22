import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/Pages/var.dart';
import 'package:contacts_app/Pages/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl = TextEditingController();
    TextEditingController ctrl2 = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    FirebaseFirestore db = FirebaseFirestore.instance;
    String s1 = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            child: TextField(
              controller: ctrl,
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
              controller: ctrl2,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password'
              ),
              onChanged: (text){
              },
              obscureText: true,
            ),
          ),

          ButtonTheme(
            minWidth: 200,
            height: 50,
            child: RaisedButton(
              child: Text('Confirm'),
              onPressed:() async {
                setState(() {
                  s1 = ctrl.text;
                });
                await db.collection('Users').doc('$s1').set({
                  'Login': ctrl.text,
                  'Password': ctrl2.text,
                  'Date': Timestamp.now()
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => loginPage(),
                  ),
                );
              }
            ),
          ),

        ],
      ),
    );
  }
}
