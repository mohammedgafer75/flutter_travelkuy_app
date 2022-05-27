import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter_travelkuy_app/screens/search_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_travelkuy_app/widgets/loading.dart';
import 'package:flutter_travelkuy_app/widgets/snackbar.dart';
import '../models/travel_model.dart';
import 'package:intl/intl.dart';

class SearchController extends GetxController {
  RxList<Travel> travels = RxList<Travel>([]);
  late CollectionReference collectionReference;
  late TextEditingController from,to;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Travel> result = [];
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  @override
  void onInit()  {
    from = TextEditingController();
    to = TextEditingController();
    collectionReference = firebaseFirestore.collection("Travel");
    travels.bindStream(getAllTravels());
    loading.value = false;

    super.onInit();
  }

  Stream<List<Travel>> getAllTravels() =>
      collectionReference.snapshots().map((query) =>
          query.docs
              .map((item) => Travel.fromMap(item))
              .toList());

  search() async {
    result.clear();
    showdilog();
    for (var element in travels) {
      if (element.from == from.text &&
          element.to == to.text
      ) {
        result.add(element);
      }
    }
    if (result.isNotEmpty) {
      Get.back();
      Get.to(() => SearchResult(result: result));
    } else {
      Get.back();
      showbar('title', 'subtitle', 'لا توجد رحل', false);
    }
  }

}
