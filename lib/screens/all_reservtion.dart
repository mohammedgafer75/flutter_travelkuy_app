import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/home_controller.dart';
import 'package:flutter_travelkuy_app/screens/edit_reservation.dart';
import 'package:flutter_travelkuy_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/style/theme.dart' as theme;

class AllReservtion extends StatelessWidget {
  const AllReservtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات'),
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (logic) {
          return logic.reservaiton.isEmpty
              ? const Center(child: Text('No Resrvations Founded'))
              : ListView.builder(
                  itemCount: logic.reservaiton.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              theme.Colors.loginGradientEnd
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "حجز باسم:   ${logic.reservaiton[index].name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "رحلة رقم:   ${logic.reservaiton[index].No}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'عدد المقاعد:  ${logic.reservaiton[index].passNumber}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'مسار الرحلة:  ${logic.reservaiton[index].from}-${logic.reservaiton[index].to}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'السعر:  ${logic.reservaiton[index].price!}'
                                ' ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'الزمن:  ${DateFormat.yMd().format(logic.reservaiton[index].time!)}'
                                '  ${DateFormat.jm().format(logic.reservaiton[index].time!)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CustomTextButton(
                                    lable: 'تعديل',
                                    ontap: () {
                                      Get.to(EditResrvation(
                                          data: logic.reservaiton[index]));
                                    }),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomTextButton(
                                    lable: 'الغاء حجز',
                                    ontap: () {
                                      logic.deleteResrvation(
                                          logic.reservaiton[index].id!,
                                          logic.reservaiton[index].travelId!,
                                          logic.reservaiton[index].passNumber!);
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
