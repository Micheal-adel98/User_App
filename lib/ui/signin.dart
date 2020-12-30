import 'package:login_signup/Pages/loading.dart';
import 'package:login_signup/constants/constants.dart';
import 'package:login_signup/ui/forgetpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/Pages/home.dart';
import 'package:login_signup/ui/widgets/custom_shape.dart';
import 'package:login_signup/ui/widgets/responsive_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _obscureText = true;
  bool loading = false;
  String error='';
  SharedPreferences sharedPreferences;
  bool checkValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
// final bool connected =
                    //  connectivity != ConnectivityResult.none;

 // static get connectivity => null;

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", emailController.text);
      sharedPreferences.setString("password", passwordController.text);
      sharedPreferences.commit();
      getCredential();

    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          emailController.text = sharedPreferences.getString("username");
          passwordController.text = sharedPreferences.getString("password");

        } else {
          emailController.text = "";
          passwordController.text = "";
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
       
      }
    });
  }
  savePref(bool value)async{
    sharedPreferences  = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("username", emailController.text);
      sharedPreferences.setString("password", passwordController.text);
      sharedPreferences.commit();
      getPref();
     
    });

  }

  getPref()async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = sharedPreferences.getString("username");
      passwordController.text = sharedPreferences.getString("password");
    });

  }


  @override
  void initState() {
    super.initState();

    getCredential();
    getPref();
    Future.delayed(Duration()).then((value) {
      if (_key.currentState.mounted) {
        if(emailController.text.isNotEmpty==true && passwordController.text.isNotEmpty==true ){
          setState(() => loading=true);
        }
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text)
            .then((currentUser) =>
            Firestore.instance
                .collection("Users")
                .document(currentUser.user.uid)
                .get()
                .then((DocumentSnapshot result) =>
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Home(
                              uid: currentUser.user.uid,
                            ))))
                .catchError((err) => print(err)))
            .catchError((err) => print(err));

      }
    });

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
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
             
              forgetPassTextRow(),
               SizedBox(height: _height / 15),
              signUpTextRow(),
              


            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(

      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large ? _height / 4 : (_medium
                  ? _height / 3.75
                  : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large ? _height / 4.5 : (_medium
                  ? _height / 4.25
                  : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200], Colors.blueAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large ? _height / 30 : (_medium ? _height / 25 : _height /
                  20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "TransitMisr",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 39 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to user account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
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
              keyboardType: TextInputType.emailAddress,
              controller:emailController ,
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
            SizedBox(height: _height / 40.0),
            TextFormField(
              controller:passwordController,
              obscureText: _obscureText,

              validator: (input) {
                if (input.length < 6) {
                  return 'Please enter password';
                }
                return null;
              },
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
            
            SizedBox(height: 12.0),
            
            Text(error,
                style:TextStyle(color: Colors.red,fontSize: 14.0)),

            new CheckboxListTile(
              value: checkValue,
              onChanged: _onChanged,
              title: new Text("Remember me"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
              
            RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () async{

                  if (_key.currentState.validate()) {
                    savePref(true);
                    setState(() =>loading=true);
                    dynamic result = await
                   // updateData();
                    //stat(emailController,passwordController);

                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((currentUser) =>

                        Firestore.instance
                            .collection("Users")
                            .document(currentUser.user.uid)
                            .get()
                            .then((DocumentSnapshot result) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>

                                        Home(

                                          uid: currentUser.user.uid
                                        ))))
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                    if ( result == null){
                      loading=false;
                      setState(() => error='Incorrect email and/or password. Please try again');
                      sharedPreferences.clear();
                    }
                  }
                },
                textColor: Colors.white,
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  width: _large ? _width / 4 : (_medium
                      ? _width / 3.75
                      : _width / 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                      colors: <Color>[Colors.blue[200], Colors.blueAccent],
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text('SIGN IN', style: TextStyle(
                      fontSize: _large ? 14 : (_medium ? 14 : 12))),
                )
                ),
             
          ],
        ),
      ),
    );
  }
   Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue[200],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
    Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ResetPasswordPage(
                              
                            )));
              
            },
            child: Text(
              "Forgot your password",
              style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.w400,
                 color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
/*Future stat(email,password) async   {
  

                         
                         /* return await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text)
                          .then((currentUser)  async => NetworkSensitive(currentUser.user.uid)
    
    
  );*/  await Firestore.instance
                              .collection('Drivers')
                              .document(currentUser.user.uid)
                              .updateData('status': "online"
                          );
                            }*/





 



  }


 









