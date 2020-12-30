import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ResetPasswordPage extends StatefulWidget {

 @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ResetPasswordPage> {



  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/images/lock.png"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('The text message will be sent to this email',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        
                        textAlign: TextAlign.center,
                      )
                      
                    ],
                  ),
                ),
                SizedBox(
                        height: 30,
                      ),
                Container(
                  width: double.infinity,
                  child: Form(
                  key: key,
                  child: Column(
                    children: <Widget>[
                    TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val) =>
              !val.contains('@fa-hists.edu.eg')
                  ? 'Invalid! Please enter email'
                  : null,


              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: new Icon(Icons.email),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),
              ),
            ),
            
            
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [
                              Colors.blueAccent
                              ,Colors.blue
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: SizedBox.expand(
                          child: FlatButton(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                             
                            if (key.currentState.validate()) {
                         FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                          Navigator.pop(context);
                             }
                      
                              
                            },
                          ),
                        ),
                      ),
                     
                       
                    ],
                  ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}