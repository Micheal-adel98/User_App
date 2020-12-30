import 'package:flutter/material.dart';
import 'package:login_signup/Pages/home.dart';
import 'package:login_signup/Pages/loading.dart';
import 'package:login_signup/ui/widgets/customappbar.dart';
import 'package:login_signup/ui/widgets/responsive_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
 
  TextEditingController name, id, email, password,confirmPassword, phone;
  bool loading = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final db = Firestore.instance;
 

 String selectedSalutation,selectedSalutation2,selectedSalutation3;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
 List<String> names=[];
  Future<dynamic> getData() async {

    final DocumentReference document =   Firestore.instance.collection("LineNum").document('J8wDCslmgBYtsSzpJeFd');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      
      setState(() {
        
         names = List.from(snapshot.data['linesids']);
        
      });
    });
  }
  @override

  initState() {
    getData();
    name = new TextEditingController();
    id = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    confirmPassword = new TextEditingController();
    phone = new TextEditingController();
    super.initState();
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return loading ? Loading() : Material(
      
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        
      ),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      top: _large ? _height / 30 : (_medium
                          ? _height / 25
                          : _height /
                          20)),
                  child: Image.asset(
                    'assets/images/register.png',
                    height: _height / 4.5,

                  ),

                ),
                Text(
                  "Please enter your personal info",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: _large ? 20 : (_medium ? 17.5 : 15),
                  ),
                ),


                form(),

                SizedBox(height: _height / 40.0),


                
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[


            TextFormField(
              controller: name,
              
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.account_circle),
                labelText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),
                
              ),

            ),
            SizedBox(height: _height / 40.0),
            TextFormField(
              controller: id,
              keyboardType: TextInputType.phone,
              validator: (input) {
                if (input.length < 9) {
                  return 'Please enter your ID';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.account_circle),
                labelText: 'ID Student',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),
              ),

            ),
            SizedBox(height: _height / 40.0),
            TextFormField(
              controller: email,
              validator: (val) =>
              !val.contains('@fa-hists.edu.eg')
                  ? 'Invalid! Please enter email'
                  : null,


              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.email),
                labelText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),
              ),
            ),
            SizedBox(height: _height / 40.0),
            TextFormField(
              controller: password,

              obscureText: _obscureText,

              validator: pwdValidator,
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.lock),

                labelText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                    _obscureText ? 'show password' : 'hide password',
                  ),
                ),
              ),

            ),
            SizedBox(height: _height / 40.0),
            TextFormField(
              controller: confirmPassword,

              obscureText: _obscureText,

              validator: pwdValidator,
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.lock),

                labelText: 'Confirm Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),

              ),

            ),

            SizedBox(height: _height / 50.0),
             DropdownButtonFormField<String>(
              value: selectedSalutation3,
 decoration: InputDecoration(
                                                      prefixIcon: new Icon(Icons.line_style),

                                         
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(38.0))),

              hint: Text(
                'Departement',
              ),
              onChanged: (salutation3) =>
                  setState(() => selectedSalutation3 = salutation3),
              validator: (value) => value == null ? 'please select your departement' : null,
              items:
                  ['Computer science', 'Administration (EN)','Administration (AR)','Information systems'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isDense: true,
            ),
           
             
       
        SizedBox(height: _height / 50.0),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.phone,
              validator: (input) {
                if (input.length < 11) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.phone),

                labelText: 'Phone Number',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(38.0)),

              ),

            ),
            SizedBox(height: _height / 40.0),
            
            
        
           
           
          
               DropdownButtonFormField<String>(
              value: selectedSalutation,
 decoration: InputDecoration(
                                                      prefixIcon: new Icon(Icons.line_style),

                                         
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(38.0))),

              hint: Text(
                'Line Number',
              ),
              onChanged: (salutation) =>
                  setState(() => selectedSalutation = salutation),
              validator: (value) => value == null ? 'please select your line number' : null,
              items:
                  names.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isDense: true,
            ),
           
             
       
        SizedBox(height: _height / 80.0),
          DropdownButtonFormField<String>(
              value: selectedSalutation2,
 decoration: InputDecoration(
                                                      prefixIcon: new Icon(Icons.perm_identity),

                                          
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(38.0))),

              hint: Text(
                'Level',
              ),
              onChanged: (salutation2) =>
                  setState(() => selectedSalutation2 = salutation2),
              validator: (value) => value == null ? 'please select your level' : null,
              items:
                  ['One', 'Two','Three','Four'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isDense: true,
            ),
            SizedBox(height: _height / 50.0),
               Text(
    'Note to students:                                                               ',
    style: TextStyle(fontSize: 16.0,color: Colors.redAccent),
    
  ),
        Text(
    'The student can log in, but if the student does not pay the bus subscription fees he cannot login by this account.',
    style: TextStyle(fontSize: 14.0,color: Colors.redAccent[300]),
    
  ),
  
SizedBox(height: _height / 30.0),
            RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: (){
                
                if (_key.currentState.validate()) {
                  setState(() =>loading=true);
                  if (password.text ==
                      confirmPassword.text) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text)
                        .then((currentUser) => Firestore.instance
                        .collection("Users")
                        .document(currentUser.user.uid)
                        .setData({
                      "uid":currentUser.user.uid,
                      "confirm": 'false',
                      "name": name.text,
                      "Id": id.text,
                      "EmailUser": email.text,
                      "PassUser": password.text,
                      "phone": phone.text,
                      "Department":selectedSalutation3,
                      "Line_Number":selectedSalutation,
                      "level":selectedSalutation2,
                    })
                        .then((result) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                uid: currentUser.user.uid,
                              )),
                              (_) => false),
                      name.clear(),
                      id.clear(),
                      email.clear(),
                      password.clear(),
                      confirmPassword.clear()
                    })
                        .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("The passwords do not match"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  }
                }
                
                  
              },
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              child: Container(
                alignment: Alignment.center,
                width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width /
                    3.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                    colors: <Color>[Colors.blue[200], Colors.blueAccent],
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text('Submit', style: TextStyle(
                    fontSize: _large ? 16 : (_medium ? 12 : 10))),
              ),

            ),
          ],
        ),
      ),

    );
  }


  }

