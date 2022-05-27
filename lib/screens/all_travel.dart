import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/home_controller.dart';
import 'package:flutter_travelkuy_app/screens/search.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/property.dart';

class AllTravel extends StatelessWidget {
  const AllTravel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الرحلات'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          Get.to(() => const Search());
        },
      ),
      body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          // color: Color.fromRGBO(19, 26, 44, 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetX<HomeController>(
              // autoRemove: false,
              //   init: HomeController(),
              builder: (controller) {
            if (controller.travels.isEmpty) {
              return const Center(child: Text('No Travel Founded'));
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Hero(
                      tag: Image.network(
                        controller.travels[index].image!,
                        fit: BoxFit.fill,
                      ),
                      child: Property(property: controller.travels[index]));
                },
                itemCount: controller.travels.length,
              );
            }
          })),
    );
  }
}
