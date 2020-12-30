
import 'package:flutter/material.dart';



class BusLine extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<BusLine> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        
        Container(
        margin: const EdgeInsets.only(left: 145.0,top: 250),
          child: CircleAvatar(
          backgroundImage: ExactAssetImage('assets/images/Busline.png'),
          minRadius: 30,
          maxRadius: 70,
        )),
             Column(
              children: <Widget>[
                Container(
                  
                ),
                SizedBox(height: 450.0),
                Text(
                  'This is not your bus line',
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
                  Navigator.of(context).pop();


                        },
                        child: Center(
                          child: Text(
                            'Back',
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


