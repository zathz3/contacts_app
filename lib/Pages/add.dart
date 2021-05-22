import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/Pages/var.dart';
import 'package:contacts_app/Pages/contacts.dart';

class addContact extends StatefulWidget {
  @override
  _addContactState createState() => _addContactState();
}

class _addContactState extends State<addContact> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl1 = TextEditingController();
    TextEditingController ctrl2 = TextEditingController();
    TextEditingController ctrl3 = TextEditingController();
    TextEditingController ctrl4 = TextEditingController();
    TextEditingController ctrl5 = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    String s1 = '';

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('Contacts').orderBy('date')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        id = doc['id'];
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add a contact'),
      ),
      body: Form(
        key: form,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
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

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    controller: ctrl2,
                    validator: (value){
                      if (value.isEmpty){
                        return 'Preencha os dados';
                      }
                      return null;
                    }
                ),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    controller: ctrl3,
                    validator: (value){
                      if (value.isEmpty){
                        return 'Preencha os dados';
                      }
                      return null;
                    }
                ),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Zip Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    controller: ctrl4,
                    validator: (value){
                      if (value.isEmpty){
                        return 'Preencha os dados';
                      }
                      return null;
                    }
                ),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    controller: ctrl5,
                    validator: (value){
                      if (value.isEmpty){
                        return 'Preencha os dados';
                      }
                      return null;
                    }
                ),

                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () async {
                       if(form.currentState.validate()){
                         setState(() {
                          //id2++;
                           if(id == ''){
                             id = '1';
                           }else{
                             id2 = int.parse(id);
                             id2++;
                             id = id2.toString();
                           }
                          });
                         await db.collection('Contacts').doc('$id').set({
                           'Name': ctrl1.text,
                           'Email': ctrl2.text,
                           'Address': ctrl3.text,
                           'Zip Code': ctrl4.text,
                           'Phone': ctrl5.text,
                           'id': id,
                           'date': Timestamp.now()
                         });
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => Contacts(),
                           ),
                         );
                       }
                       //Navigator.pop(context);
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
