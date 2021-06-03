import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/Pages/add.dart';
import 'package:contacts_app/Pages/edit.dart';
import 'package:contacts_app/Pages/var.dart';
import 'package:contacts_app/Pages/searchCep.dart';
import 'package:contacts_app/Pages/calendar.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl1 = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    String s1 = '';
    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection('Contacts').snapshots();
    getUrl();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Add Contact'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addContact()),
                    );
                  },
                  textColor: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Edit'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => editContact()),
                    );
                  },
                  textColor: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  child: MaterialButton(
                    elevation: 5.0,
                    height: 5.1,
                    child: Text('Delete'),
                    textColor: Colors.red,
                    onPressed: (){

                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                    title: Text('Delete Contact'),
                                    content: Form(
                                      key: form,
                                      child: Container(
                                        height: MediaQuery.of(context).size.height / 3,
                                        child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter the ID number',
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
                                            ]
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: Text('Cancel'),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          if(form.currentState.validate()){
                                            setState(() {
                                              s1 = ctrl1.text;
                                            });
                                            await db.collection('Contacts').doc('$s1').delete();
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        color: Colors.blue,
                                        child: Text('Confirm'),
                                      ),
                                    ]
                                );
                              }
                          );

                    },
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SizedBox(
              height: 200.0,
              child: StreamBuilder(
                stream: snap,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,){
                  if( snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        var item = snapshot.data.docs[i];
                        return ListTile(
                          title: Row(
                            children: <Widget> [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 14,
                                backgroundColor: Colors.grey,
                                backgroundImage: (imageUrl == null ) ? AssetImage('assets/images/img1.png') : NetworkImage(imageUrl)
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(item['Name']),
                                    Text(item['Phone'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(item['id']),
                        );
                      },
                    );
                  }else {
                    return CircularProgressIndicator();
                  }
              }
              ),
            ),
          ),


          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Address'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => searchCep()),
                    );
                  },
                  textColor: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: MaterialButton(
                  elevation: 5.0,
                  child: Text('Calendar'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => calendar()),
                    );
                  },
                  textColor: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  getUrl() async {
    final ref = FirebaseStorage.instance.ref().child('Images/img1');
// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    imageUrl = url;
  }
}

