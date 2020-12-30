import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup/model.dart';


class HomePage extends StatefulWidget {
  HomePage(this.m);
       //update this to include the uid in the constructor


  Model m;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  IconData myFeedback = FontAwesomeIcons.sadTear;
  Color myFeedbackColor = Colors.red;
  String value;
  dynamic sum;
  var id_driver;
  var name;
  //var firstrate;
  int _count = 0;
  int firstvalue;
   List<DocumentSnapshot> _myDocCount;
   
  void countDocuments() async {
  
    QuerySnapshot _myDoc = await Firestore.instance.collection('Drivers')
              .document(id_driver)
              .collection('Feedback').getDocuments();
               
     _myDocCount = _myDoc.documents;
   
     
      
}

Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 2));

    setState(() {
      _count += 1;
    });

    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      bottomSheet: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          children: <Widget>[
            SizedBox(height:70.0),
            Container(child:Padding(
              padding: const EdgeInsets.all(16.0),

              child: Container(child: Text("On a scale of 1 to 5, how do you rate $name?",
                style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),)),
            ),),
            SizedBox(height:30.0),
            Container(
              child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                      width: 350.0,
                      height: 400.0,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Text(myFeedbackText,
                            style: TextStyle(color: Colors.black, fontSize: 22.0),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Icon(
                            myFeedback, color: myFeedbackColor, size: 100.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Slider(
                              min: 0.0,
                              max: 5.0,
                              divisions: 5,
                              value: sliderValue,
                              activeColor: Color(0xffff520d),
                              inactiveColor: Colors.blueGrey,
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue = newValue;
                                  if (sliderValue >= 0.0 && sliderValue <= 1.0) {
                                    firstvalue=1;
                                    myFeedback = FontAwesomeIcons.sadTear;
                                    myFeedbackColor = Colors.red;
                                    myFeedbackText = "Bad";
                                    value='1';
                                  }
                                  if (sliderValue >= 1.1 && sliderValue <= 2.0) {
                                    firstvalue=2;
                                    myFeedback = FontAwesomeIcons.frown;
                                    myFeedbackColor = Colors.yellow;
                                    myFeedbackText = "Normal";
                                    value='2';
                                  }
                                  if (sliderValue >= 2.1 && sliderValue <= 3.0) {
                                    firstvalue=3;
                                    myFeedback = FontAwesomeIcons.meh;
                                    myFeedbackColor = Colors.amber;
                                    myFeedbackText = "Good";
                                    value='3';
                                  }
                                  if (sliderValue >= 3.1 && sliderValue <= 4.0) {
                                    firstvalue=4;
                                    myFeedback = FontAwesomeIcons.smile;
                                   
                                    myFeedbackColor = Colors.blueGrey;
                                    myFeedbackText = "Very good";
                                    value='4';
                                  }
                                  if (sliderValue >= 4.1 && sliderValue <= 5.0) {
                                    firstvalue=5;
                                    myFeedback = FontAwesomeIcons.laugh;
                                     myFeedbackColor = Colors.green;
                                    myFeedbackText = "EXCELLENT";
                                    value='5';
                                  }
                                });
                              },
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Text("You choose rating: $sliderValue",
                            style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Align(
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Color(0xffff520d),
                              child: Text('Submit',
                                style: TextStyle(color: Color(0xffffffff)),),
                              onPressed: () async{
                                       Navigator.pop(context);
                                       countDocuments();
                                await Firestore.instance.collection('Drivers').document(id_driver).collection('Feedback').document().setData({"Student": value});
                               if(_myDocCount.length==0){
                               await Firestore.instance.collection('Drivers').document(id_driver).updateData({"Rate": firstvalue});
                               }if(_myDocCount.length!=0){
                               await Firestore.instance.collection('Drivers').document(id_driver).updateData({"Rate": (sum)/(_myDocCount.length+1)});
                               }
                            



                              },
                            ),
                          )),
                        ),
                      ],)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Drivers')
                  .where("Line_Number", isEqualTo: widget.m.lineNumber )
                  .snapshots(),
                  builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
          
                return Text('Loading............');
              default :
              id_driver = snapshot.data.documentChanges[0].document['uid'];
              name = snapshot.data.documentChanges[0].document['name'];
              //firstrate = snapshot.data.documentChanges[0].document['firstrate'];


              return Center(
 child:StreamBuilder(
          stream: Firestore.instance
              .collection('Drivers')
              .document(id_driver)
              .collection('Feedback')
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  
                  DocumentSnapshot documentSnapshot =
                  snapshot.data.documents[index];
                  sum = snapshot.data.documents.fold(0, (prev, next) => prev + int.parse(next['Student']));
                  print(sum);



                  return Text(documentSnapshot['Student']);
                  
                });
          }),
              );
                  }})      
                
     
    );
  }
}