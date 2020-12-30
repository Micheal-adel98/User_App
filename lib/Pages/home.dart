
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup/Pages/Myaccount.dart';
import 'package:login_signup/Pages/busline.dart';
import 'package:login_signup/Pages/confirmed.dart';
import 'package:login_signup/Pages/loading.dart';
import 'package:login_signup/ui/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/Pages/trackDetails.dart';
import 'package:login_signup/Pages/trackDetails2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/model.dart';


class Home extends StatefulWidget {
  Home({Key key, this.uid})
  
      : super(key: key); //update this to include the uid in the constructor
Model myModel;
  final String uid;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name='';
  var email='';
  var confirm='';
  var line='';
  String confirmed='false';
bool checkValue = false;
bool loading = false;
   
confirmedemail() async{
     final DocumentReference document =   Firestore.instance.collection("Users").document(widget.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      
      setState(() {
        confirm =snapshot.data['confirm'];
        name = snapshot.data['name'];
        email = snapshot.data['EmailUser'];
        line= snapshot.data['Line_Number'];
        
      });
    });
await Future.delayed(Duration()).then((value) {
  if(confirm==confirmed){
    setState(() =>loading=true);
   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Confirmed(
                              
                            )));

  }

  
});

            
            

}
  void initState() {
    super.initState();
 confirmedemail();
  
   
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar( backgroundColor: Colors.white,
      
    ),
       
       
         
      drawer: Drawer(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
      

          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/future.jpg"),


            ),
            accountName: Text(

              name,
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text(
                  email,
                  style: TextStyle(fontSize: 15),
                )),
        
          ),
          
          InkWell(
            onTap:(){ Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyAccount(uid: widget.uid)));
        },
            child: ListTile(
                title:Text("My account"),
                leading: Icon(Icons.person)
            ),
          ),
          InkWell(
            onTap:(){launch('tel:01221732299');},
            child: ListTile(
                title:Text("Contact Us"),
                leading: Icon(Icons.call)
            ),
          ),
          Divider(),
          InkWell(
            onTap:()async{
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

             // var status = prefs.getBool('isLoggedIn') ?? false;
             // print(status);
             // runApp(MaterialApp(home: status == false ? SignInPage() : Home(),debugShowCheckedModeBanner: false));
              
              FirebaseAuth.instance.signOut().then((currentUser) =>
                  Firestore.instance
                      .collection("Users")
                      .document(widget.uid)
                      .get()
                      .then((DocumentSnapshot result) =>

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      SignInScreen()), (Route<dynamic> route) => false)));

            },
            child: ListTile(
                title:Text("Logout"),
                leading: Icon(Icons.exit_to_app)
            ),
          )
        ]),
      ),
       bottomSheet:  Column(
      
         crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
 Expanded(
                            child: Container(
                              
                              
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                           
                              child: Row(
                                 
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                
                                      "Choose your \nBus Line ",
                                      style: TextStyle(
                                          color: Colors
                                              .blueGrey,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Image.asset(
                                      "assets/images/MasrLogo.png",
                                      scale: 5,
                                    )
                                  ]),
                            ),

                          ),
                         
                         
            Expanded(
              
              
              flex:5,
                          child: StreamBuilder(
                  stream: Firestore.instance.collection('Lines').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Text('Loading data...please wait..');
                      print('Len:${ snapshot.data.documents.length}');
                    return ListView.builder(
                      
                      itemBuilder: (context, index) {
                        Model m=Model(
                          id: snapshot.data.documents[index]['uid_line'].toString(),
                          lineNumber: snapshot.data.documents[index]['LineNumber'].toString(),
                          stations:   snapshot.data.documents[index]['Stations'],
                          time:   snapshot.data.documents[index]['Times'],
                          return_stations: snapshot.data.documents[index]['Return_stations'] ,
                          return_times: snapshot.data.documents[index]['Return_Times'] , 
                          type:snapshot.data.documents[index]['type'].toString(),
                          stationName:snapshot.data.documents[index]['StationName'].toString()
                        );
                        return Column(
                          
                          children: <Widget>[
                            
                            
                        Container(
                          
                        height: 110,
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        
                        child: Card(
                          
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0)),
                        elevation: 1,
                        child: InkWell(
                          onTap: () {
                            if(m.lineNumber==line){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AccessTrack(
                                       m
                                        )));
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BusLine(
                                         
                                        )));
                            }
                          },
                          child: Column(
                            
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 2, 10, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text("ID#${m.lineNumber}",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),
                                    Spacer(flex: 8,),
                                    Container(
                                      
                                      height: 32,
                                      width: 87,
                                      decoration: new BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius:
                                              new BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(10),
                                            bottomRight:
                                                Radius.circular(10),
                                          )),
                                      child: new Center(
                                        child: new Text(
                                            "Access road",
                                            style: TextStyle(
                                                color:
                                                    Colors.white)),
                                      ),
                                    ),Spacer(flex:1)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Line",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),
                                    Spacer(flex:10),
                                    Text(
                                      "Bus Type",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),Spacer(flex:3)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 10),
                                child: Row(
                               
                                  children: <Widget>[
                              
                                  Text(
                                      snapshot
                                          .data
                                          .documents[index]
                                              ['StationName']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          wordSpacing: -3,
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                   Spacer(flex:3),
                                    Text(
                                      m.type,
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 17),
                                    ), 
                                    Icon(Icons.directions_bus,
                                        color: Colors.blueGrey),Spacer(flex: 1),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ),
                        ),
                        Container(
                        height: 110,
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0)),
                        elevation: 1,
                        child: InkWell(
                          onTap: () {
                            if(m.lineNumber==line){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Return(
                                         m,widget.uid
                                        )));
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BusLine(
                                         
                                        )));
                            }
                          },
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 2, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "ID#${m.lineNumber}" ,
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),
                                    Spacer(flex: 9,),
                                    Container(
                                      height: 32,
                                      width: 125,
                                      decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              new BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(10),
                                            bottomRight:
                                                Radius.circular(10),
                                          )),
                                      child: new Center(
                                        child: new Text(
                                            "Return at 3:00 PM",
                                            style: TextStyle(
                                                color:
                                                    Colors.white)),
                                      ),
                                    ),Spacer(flex:1)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Line",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),
                                   Spacer(flex: 10,),
                                    Text(
                                      "Bus Type",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey[200],
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),Spacer(flex:3)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 0, 0, 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      snapshot
                                          .data
                                          .documents[index]
                                              ['StationName']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Spacer(flex: 3),
                                    Text(
                                      m.type,
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          wordSpacing: -5,
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Icon(Icons.directions_bus,
                                        color: Colors.blueGrey),Spacer()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ),
                        ),
                              ],
                        );
                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  }),
            ),
          ],
        ));
  }
}
