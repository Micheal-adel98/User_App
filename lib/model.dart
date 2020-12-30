



class Model{
  String id;
  var stations=[];
  var return_stations=[];
  var return_times=[];
  String lineNumber;
  String type;
  var time=[];
  String stationName;

  
  Model({this.id,this.lineNumber,this.stations,this.type,this.time,this.stationName,this.return_stations,this.return_times});
}