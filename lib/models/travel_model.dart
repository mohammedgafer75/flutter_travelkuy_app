import 'package:cloud_firestore/cloud_firestore.dart';

class Travel {
  String? id;
  String? from;
  String? to;
  String? image;
  DateTime? time;
  int? count;
  int? No;
  int? price;

  Travel({
    this.id,
    required this.time,
    required this.from,
    required this.to,
    required this.image,
    required this.count,
    required this.price,
    required this.No,
  });

  Travel.fromMap(DocumentSnapshot data) {
    id = data.id;
    from = data["from"];
    to = data["to"];
    image = data["image"];
    count = data["count"];
    time = data["time"].toDate();
    price = data["price"];
    No = data["No"];
  }
}
