import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Confirmed extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Confirmed> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        
        Container(
        margin: const EdgeInsets.only(left: 145.0,top: 250),
          child: CircleAvatar(
          backgroundImage: ExactAssetImage('assets/images/wrong.png'),
          minRadius: 30,
          maxRadius: 70,
        )),
             Column(
              children: <Widget>[
                Container(
                  
                ),
                SizedBox(height: 450.0),
                Text(
                  'Please wait to review and check your information\n                    by admin and try again later',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                     ),
                ),
                
               SizedBox(height: 50),
                              Container(
                    height: 40.0,
                    width: 110.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent,
                      color: Colors.blue,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () async {
SharedPreferences prefs = await SharedPreferences.getInstance();

                checkValue = prefs.getBool("check");
                if (checkValue != null) {
                  if (checkValue == true) {
                    prefs.remove("password");
                  }
                }else{
                  checkValue=false;
                  prefs.clear();
                }

      
              FirebaseAuth.instance.signOut().then((currentUser) =>
                  Firestore.instance
                      .collection("Users")
                      .document()
                      .get()
                      .then((DocumentSnapshot result) =>

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      SignInScreen()), (Route<dynamic> route) => false)));


                        },
                        child: Center(
                          child: Text(
                            'Log out',
                            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ))
              ],
            )
      ]
    
      
    )
    );
  }
}


