import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/models/travel_model.dart';
import 'package:flutter_travelkuy_app/widgets/loading.dart';
import 'package:flutter_travelkuy_app/widgets/snackbar.dart';
import 'package:get/get.dart';

class MakeReservtion extends GetxController {
  late TextEditingController name, passNumber;
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late Travel travel;
  auth.User? user;
  @override
  void onInit() {
    name = TextEditingController();
    passNumber = TextEditingController();
    collectionReference = firebaseFirestore.collection("Reservtions");
    user = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "الرجاء ادخال الاسم";
    }
    return null;
  }

  String? validateCount(String value, int count) {
    if (value.isEmpty) {
      return "الرجاء ادخال عدد الركاب";
    }
    if (int.tryParse(value)! > count) {
      return 'عدد المقاعد غير متوفر';
    }
    return null;
  }

  Future<Travel> getTravelById(String id) async {
    var res =
        await FirebaseFirestore.instance.collection("Travel").doc(id).get();
    travel = Travel.fromMap(res);
    return travel;
  }

  void makeReserve(String id, int count, int No, DateTime time, String from,
      String to, int price) async {
    bool ch = (formKey2.currentState!.validate());
    if (ch) {
      showdilog();
      var res2 = await FirebaseFirestore.instance
          .collection("wallet")
          .where('uid', isEqualTo: user!.uid)
          .get();

      if (res2.docs.isEmpty) {
        Get.back();
        showbar('title', 'subtitle', 'ليس لديك محفظة!!', false);
      } else if (res2.docs[0]['balance'] < price) {
        Get.back();
        showbar('title', 'subtitle', 'ليس لديك مبلغ كافي', false);
      } else {
        try {
          late int number;
          var res = await FirebaseFirestore.instance.collection('users').get();
          for (var element in res.docs) {
            if (element['uid'] == user!.uid) {
              number = element['number'];
            }
          }
          var data = <String, dynamic>{
            "travelId": id,
            "userId": user!.uid,
            "name": user!.displayName,
            "passNumber": int.tryParse(passNumber.text),
            "from": from,
            "to": to,
            "number": number,
            "time": time,
            "No": No,
            "price": price * int.tryParse(passNumber.text)!
          };
          await collectionReference.doc().set(data).whenComplete(() async {
            FirebaseFirestore.instance
                .collection('Travel')
                .doc(id)
                .update({"count": count - int.tryParse(passNumber.text)!});
            FirebaseFirestore.instance
                .collection('wallet')
                .doc(res2.docs[0].id)
                .update({
              "balance": res2.docs[0]['balance'] -
                  price * int.tryParse(passNumber.text)!
            });
            var re = await FirebaseFirestore.instance
                .collection('Travel')
                .doc(id)
                .get();
            if (re['count'] == 0) {
              FirebaseFirestore.instance.collection('notification').doc().set({
                "travelId": id,
                "No": No,
                "time": time,
              });
            }
            name.clear();
            passNumber.clear();
            await getTravelById(id);
            update(['new']);
            Get.back();
            showbar('title', 'subtitle', 'تمت عملية الحجز', true);
          });
        } catch (e) {
          Get.back();
          showbar('title', 'subtitle', 'يوجد خطأ', false);
        }
      }
    }
  }
}
