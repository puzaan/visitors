class VisitorList{
  int id;
  String visitorName;
  String address;
  String number;
  bool visitedStatus;

  VisitorList({this.id,this.visitorName,this.number,this.address,this.visitedStatus});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "visitorName":this.visitorName,
      "address":this.address,
      "number":this.number,
      "visitedStatus":(this.visitedStatus).toString(),
    };
    return map;
  }

}