import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/models/res_model.dart';
import 'package:flutter_travelkuy_app/models/travel_model.dart';
import 'package:flutter_travelkuy_app/widgets/loading.dart';
import 'package:flutter_travelkuy_app/widgets/snackbar.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Travel> travels = RxList<Travel>([]);
  List<Travel> list = [];
  RxList<Resrvation> reservaiton = RxList<Resrvation>([]);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController passNumber, name, complain;
  auth.User? user;
  @override
  void onInit() {
    passNumber = TextEditingController();
    name = TextEditingController();
    complain = TextEditingController();
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("Travel");
    travels.bindStream(getAllTravels());
    reservaiton.bindStream(getResrviation());
    super.onInit();
  }

  Stream<List<Travel>> getAllTravels() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Travel.fromMap(item)).toList());
  Stream<List<Resrvation>> getResrviation() => FirebaseFirestore.instance
      .collection('Reservtions')
      .where('userId', isEqualTo: user!.uid)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => Resrvation.fromMap(item)).toList());
  void editResrvation(String id, String travelId) async {
    if (formKey.currentState!.validate()) {
      var res2 =
          await FirebaseFirestore.instance.collection("Travel").doc(id).get();
      // if (res2['count'] < int.tryParse(passNumber.text.toString())) {
      //   showbar('خطأ', '', 'عدد المقاعد غير متوفر', false);
      // } else {
      try {
        showdilog();
        var data = ({"passNumber": int.tryParse(passNumber.text.toString())});
        firebaseFirestore
            .collection("Reservtions")
            .doc(id)
            .update(data)
            .whenComplete(() {
          Get.back();
          Get.back();
          showbar('تعديل', 'subtitle', 'تم التعديل', true);
        });
      } catch (e) {
        Get.back();
        Get.back();
        showbar('تعديل', 'subtitle', e.toString(), false);
        // }
      }
    }
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter this filed";
    }

    return null;
  }

  void deleteResrvation(String id, String travelId, int passNumber) async {
    try {
      showdilog();
      var res =
          await firebaseFirestore.collection("Travel").doc(travelId).get();
      int oldCount = res['count'];
      await firebaseFirestore
          .collection("Travel")
          .doc(travelId)
          .update({"count": oldCount + passNumber});
      await firebaseFirestore
          .collection("Reservtions")
          .doc(id)
          .delete()
          .whenComplete(() {
        update();
        Get.back();
        showbar('الغاء حجز', 'subtitle', 'تم الالغاء', true);
      });
    } catch (e) {
      Get.back();

      showbar('الغاء حجز', 'subtitle', e.toString(), false);
    }
  }

  void addComplains() {
    if (formKey2.currentState!.validate()) {
      try {
        String? name = user!.displayName;
        String? id = user!.uid;
        String? email = user!.email;
        showdilog();
        var data = ({
          "uid": id,
          "name": name,
          "email": email,
          "description": complain.text
        });
        firebaseFirestore
            .collection("complaints")
            .doc()
            .set(data)
            .whenComplete(() {
          Get.back();
          showbar('اضافة شكوى', 'subtitle', 'تمت الاضافة', true);
        });
      } catch (e) {
        Get.back();
        showbar('اضافة شكوى', 'subtitle', e.toString(), false);
      }
    }
  }
}
