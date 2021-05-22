import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/Pages/var.dart';

class editContact extends StatefulWidget {
  @override
  _editContactState createState() => _editContactState();
}

class _editContactState extends State<editContact> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl0 = TextEditingController();
    TextEditingController ctrl1 = TextEditingController();
    TextEditingController ctrl2 = TextEditingController();
    TextEditingController ctrl3 = TextEditingController();
    TextEditingController ctrl4 = TextEditingController();
    TextEditingController ctrl5 = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    FirebaseFirestore db = FirebaseFirestore.instance;
    String s1 = '';

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text('Edit Contact'),
      ),
      body: Form(
        key: form,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Enter the contact ID you want to edit'
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  controller: ctrl0,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Preencha os dados';
                    }
                    return null;
                  }
                ),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'New name',
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
                //SizedBox(height: 10),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'New e-mail',
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
                //SizedBox(height: 10),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'New address',
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
                      hintText: 'New zip Code',
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
                //SizedBox(height: 10),

                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'New phone',
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
                //SizedBox(height: 20),

                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: ElevatedButton(
                      child: Text('Update'),
                      onPressed: () async {
                        
                        if(form.currentState.validate()){
                          setState(() {
                            s1 = ctrl0.text;
                          });

                          await db.collection('Contacts').doc('$s1').update({
                            'Name': ctrl1.text,
                            'Email': ctrl2.text,
                            'Address': ctrl3.text, 'Zip Code': ctrl4.text,
                            'Phone': ctrl5.text
                          });
                        }
                        Navigator.pop(context);
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
