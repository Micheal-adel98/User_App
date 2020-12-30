import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:login_signup/model.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key key, this.uid})
      : super(key: key); //update this to include the uid in the constructor
 Model model;
  final String uid;
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<MyAccount> {

  File _image;
  var name='';
  var email='';
  var departement='';
  var level='';
  var id='';
  var phone='';
  var lineNumber='';


  Future<dynamic> getData() async {

    final DocumentReference document =   Firestore.instance.collection("Users").document(widget.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      
      setState(() {
        name =snapshot.data['name'];
        email=snapshot.data['EmailUser'];
        departement=snapshot.data['Department'];
        level=snapshot.data['level'];
        id=snapshot.data['Id'];
        phone=snapshot.data['phone'];
        lineNumber=snapshot.data['Line_Number'];
      });
    });
  }

  @override
  void initState() {

    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.white60
      ),
     
      body:SingleChildScrollView(
      
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: <Widget>[
          
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[

              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 90,

                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image!=null)?Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ):Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.fill,
                      ),

                    ),
                  ),
                ),
              ),


            ],
          ),
          
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(email,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Department',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(departement,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Level',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(level,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ID Academy',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(id,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(phone,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Line Number',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(lineNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
         
        ],
          
      ),
      ),
    );

  }

}