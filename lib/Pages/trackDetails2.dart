
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/Feedback/homepage.dart';
import 'package:login_signup/Pages/myMap.dart';
import 'package:login_signup/Pages/ratealert.dart';
import 'package:timeline_node/timeline_node.dart';
import '../model.dart';
import 'h.dart';

class Return extends StatelessWidget {
    String now =DateTime.now().day.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().year.toString();

  final List<HomePageTimelineObject> timelineObject = [
    HomePageTimelineObject(
        message: 'St Patrick \n 123 abc st, Nasr City, Cairo ',
        style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.BottomHalf, lineColor: Colors.red)),
    HomePageTimelineObject(
        message: 'St Patrick \n 123 abc st, Nasr City, Cairo ',
        style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.Full, lineColor: Colors.red)),
    HomePageTimelineObject(
        message: 'St Patrick \n 123 abc st, Nasr City, Cairo ',
        style: TimelineNodeStyle(
            lineType: TimelineNodeLineType.TopHalf, lineColor: Colors.red)),
  ];
  Model myModel;
  final String uid;

  Return(this.myModel,this.uid);
    
  var today,id;

  List<int> getUserLocationIndexs() {
    List<int> indexs = [];
    
    for (int i = 0; i < myModel.stations.length; i++) {
      indexs.add(i);
     
    }
    
    print(indexs);
    return indexs;
  }
   
  List<Widget> getLine() {
    var myIndexs = getUserLocationIndexs();
    List<Widget> line = [];

    for (int index = 0; index < myModel.stations.length; index++) {
      line.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Column(
          children: <Widget>[
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               
                    Container(
                  width: 50,
                  child: Text(
                    myModel.return_times[index],
                    textAlign: TextAlign.right,
                    style: TextStyle(
         
                        color: (index == myModel.return_times.length - 1)
                            ? Colors.green
                            : Colors.grey,
                            fontWeight: FontWeight.bold,
        
                        fontSize: 15),
                  ),
                ),
                Container(
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(3),
                          width: 15.0,
                          height: 15.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color:(myIndexs.contains(index))? Colors.green:
                                Colors.white
                                , shape: BoxShape.circle),
                          )),
                      SizedBox(height: 5),
                      (index == myModel.return_stations.length - 1)
                          ? Container()
                          : Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey,
                            )
                    ],
                  ),
                ),
                Container(
                  width: 122,
                  child: Text(
                    myModel.return_stations[index],
                    textAlign: TextAlign.right,
                    style: TextStyle(
        
                        color: (index == myModel.return_stations.length - 1)
                            ? Colors.green
                            : Colors.grey,
                            fontWeight: FontWeight.bold,
  
                        fontSize: 15),
                  ),
                ),
                
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ));
    }
    return line;
  }
 
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users')
              .document(uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            
           // name = snapshot.data['name'];
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                //name = snapshot.data['name'];
                return Text('Loading ..');
              default:
              
                today = snapshot.data['today'];

              
              
                return Center(
                  
                );
            }
          }),
        bottomSheet: Container(
          height: double.infinity,
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 17),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blueGrey,
                      size: 30,
                    )),
                Text(
                  "Bus Station ",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                
              ]),
                  ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Row(children: <Widget>[
                            Text("ID#${myModel.lineNumber}",
                                style: TextStyle(
                                    wordSpacing: -5,
                                    color: Colors.blueGrey[200],
                                    fontWeight: FontWeight.bold)),
                            Spacer()
                          ])),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: Row(children: <Widget>[
                            Text("Line",
                                style: TextStyle(
                                    color: Colors.blueGrey[200],
                                    fontSize: 15,
                                    wordSpacing: -5,
                                    fontWeight: FontWeight.bold)),
                            Spacer(
                              flex: 10,
                            ),
                            Text("Bus Type",
                                style: TextStyle(
                                    color: Colors.blueGrey[200],
                                    wordSpacing: -5,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Spacer(
                              flex: 3,
                            )
                          ])),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 8, 0),
                          child: Row(children: <Widget>[
                            Text(this.myModel.stationName,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    wordSpacing: -5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            Spacer(flex: 4),
                            Text(this.myModel.type,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    wordSpacing: -5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)),
                            Icon(Icons.directions_bus,
                            
                                color: Colors.blueGrey),
                            Spacer(
                              flex: 2,
                            )
                          ]))
                    ]))),
                   SizedBox(height: 25,), 
                   Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[RaisedButton(
                  child: Text(
                    "TRACK THIS BUS",
                    style: TextStyle(fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  onPressed: () {
                    Navigator.push(
                                   context,
                                  MaterialPageRoute(
                            builder: (context) => MyMap(myModel)));

                    
                  }),
              
                  RaisedButton(
                  child: Text(
                    "RATE DRIVER",
                    style: TextStyle(fontSize: 15),
                  ),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  onPressed: () async{
                   
                   if(now!=today){
             await Firestore.instance.collection('Users').document(uid).updateData({"today": now});

                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(myModel
                            )));
                   }
                   else{
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Rate(
                            )));
                   }
                    
                  }),
                  
                           ],  
            )),
          
            
            
                SizedBox(height: 25,),
                  Expanded(
                                    child: SingleChildScrollView(
                                                                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[...getLine()  ],
      ),
                                    ),
                  ),
        
          
                  
                ]),
        ));
  }
}
