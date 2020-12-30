import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model.dart';
import 'dart:ui' as ui;

class MyMap extends StatefulWidget {
  String lineNumber;
  Model m;

MyMap(this.m);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  String name='';
  String metal='';
  String brand='';
  
  String colorr;

  Map<String,Color> colors = {
    'blue': Colors.blue, // blue
    'purple': Colors.black, // purple
    'pink': Colors.white, // pink
    'red': Colors.red, // red
    'orange': Colors.orange, // orange
    'yellow': Colors.yellow, // yellow
    'green': Colors.green, // green
    'sky blue': Colors.blueGrey, // sky blue
  };
  Completer<GoogleMapController> _controller = Completer();
  LatLng _latLng = LatLng(0.0, 0.0);
  StreamSubscription subscription;
  BitmapDescriptor bitmapDescriptor;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  
_createPoints() {
    final List<LatLng> points = <LatLng>[];
    /*
    subscription = Firestore.instance
        .collection('Drivers')
        .where("Line_Number", isEqualTo: widget.m.lineNumber )
        .snapshots()
        .listen((data) async {
          
      points.add(LatLng(data.documentChanges[0].document['lat'],
          data.documentChanges[0].document['lng']));
            });
            */
    points.add(LatLng(30.1189, 31.3399));
    points.add(LatLng(30.112001, 31.345172));
    points.add(LatLng(30.111435, 31.345365));
    points.add(LatLng(30.111036, 31.345494));
    points.add(LatLng(30.110934, 31.345901));
    points.add(LatLng(30.111314, 31.346202));
    points.add(LatLng(30.118458, 31.356590));
    points.add(LatLng(30.116633, 31.364226));
    points.add(LatLng(30.115779, 31.365986));
    points.add(LatLng(30.116058, 31.366790));
    points.add(LatLng(30.116559, 31.367241));
    points.add(LatLng(30.117097, 31.367488));
    points.add(LatLng(30.117988, 31.368325));
    points.add(LatLng(30.136325, 31.392356));
    points.add(LatLng(30.140371, 31.400531));
    points.add(LatLng(30.142254, 31.401239));
    points.add(LatLng(30.165268, 31.484467));
    points.add(LatLng(30.174135, 31.554917));
    points.add(LatLng(30.174649, 31.554955));
    points.add(LatLng(30.1723, 31.5362));
    points.add(LatLng(30.1728, 31.5361));

    return points;
    
  }

  void _add() {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.blueAccent,
      width: 5,
      points: _createPoints(),

    );

    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
  }
 


        


   getData()async{
    Firestore.instance.collection('Buses').where("Line_Number", isEqualTo: widget.m.lineNumber )
    .snapshots().listen(
         (data) {
          metal= data.documents[0]['metal'];
          brand= data.documents[0]['Brand'];
          colorr= data.documents[0]['color'];
            
           }
    );
      Firestore.instance.collection('Drivers').where("Line_Number", isEqualTo: widget.m.lineNumber )
    .snapshots().listen(
         (data) {
          name= data.documents[0]['name'];
          
           }
    );

   }
  @override
  void initState() {
    super.initState();
   _add();
  
getData();
   getBytesFromAsset('assets/images/Bus_c-512.png', 150).then((v) {
      bitmapDescriptor = BitmapDescriptor.fromBytes(v);
      setState(() {});
    });

    markers.add(Marker(
        markerId: MarkerId('1'), position: _latLng, icon: bitmapDescriptor));
    subscription = Firestore.instance
        .collection('TrackDriver')
        .where("Line_Number", isEqualTo: widget.m.lineNumber )
        .snapshots()
        .listen((data) async {
      LatLng newLatLng = LatLng(data.documentChanges[0].document['lat'],
          data.documentChanges[0].document['lng']);

      _latLng = newLatLng;

      subscription.pause();

      await _controller.future.then((control) {
        control.animateCamera(
          CameraUpdate.newLatLng(_latLng),
        );
        markers.clear();
        markers.add(Marker(
            markerId: MarkerId('1'),
            position: _latLng,
            infoWindow: InfoWindow(title: widget.m.lineNumber),
            icon: bitmapDescriptor));
        setState(() {});
        subscription.resume();
      });
    });
    
  }

  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text('Future Academy'),
      ),
        body: GoogleMap(
      markers: Set.from(markers),
      polylines: Set<Polyline>.of(_mapPolylines.values),
      initialCameraPosition: CameraPosition(
        target: _latLng,
        zoom: 17,
      ),
      
      onMapCreated: (con) {
        if (_controller.isCompleted == false) {
          _controller.complete(con);
         
        }
      },
      
    ),
   
               
                
                
                bottomNavigationBar:Container(
                  
                      height: 135,
                     
                      child: ListView(
                      
                        children: <Widget>[
                        
                          makeItem(image: 'assets/images/future.jpg'),
                         

                
                        ],

                ),
   
    
    
    ),
    
    
    );
    
  }
   Widget makeItem({image}) {
    return AspectRatio(
      aspectRatio: 1.70 / 0.53,
      
      child: Container(
        margin: EdgeInsets.only(right:0),
        padding: EdgeInsets.all(20),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          
        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
             
            Icon(Icons.directions_bus,color: colors[colorr]),
                    

           
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                         Text("$metal\t($brand)"),
                Text(
      name, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
 
                
            
          
    
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover
                    ),
                    color: Colors.grey[200]
                    
                  ),
                
                  child: 
                  Text('\t\t\t\t\t\t\t\t\t\t\t\t\t', style: TextStyle(color: Colors.grey[500]),
                  
                  ),
                  
                )
                
              ],
            ),
              
            SizedBox(height: 0.5,),
             Text('Future Academy - Higher Future Institute For Specialized\nTechnological Studies', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),

                      
                      
           
          ],
        ),
      ),
    );
   
  }
  
}