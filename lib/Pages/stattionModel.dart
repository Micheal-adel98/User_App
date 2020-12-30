class Station{
  String id,name;

  Station({this.name,this.id});
}

class Drivier{
  String name,id;
  Station driverStation;

  Drivier({this.id,this.name,this.driverStation});
}