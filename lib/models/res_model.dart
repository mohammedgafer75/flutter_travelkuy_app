import 'package:cloud_firestore/cloud_firestore.dart';

class Resrvation {
  String? id;
  String? travelId;
  String? userId;
  String? name;
  String? from;
  String? to;
  DateTime? time;
  int? passNumber;
  int? price;
  int? No;
  int? number;

  Resrvation({
    this.id,
    required this.time,
    required this.travelId,
    required this.name,
    required this.from,
    required this.to,
    required this.passNumber,
    required this.price,
    required this.number,
    required this.No,

  });

  Resrvation.fromMap(DocumentSnapshot data) {
    id = data.id;
    travelId = data["travelId"];
    name = data["name"];
    from = data["from"];
    to = data["to"];
    passNumber = data["passNumber"];
    price = data["price"];
    number = data["number"];
    No = data["No"];
    time = data["time"].toDate();

  }
}