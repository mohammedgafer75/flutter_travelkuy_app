import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/make_reservation.dart';
import 'package:flutter_travelkuy_app/widgets/custom_button.dart';
import 'package:flutter_travelkuy_app/widgets/custom_textfield.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class Details extends StatelessWidget {
  const Details({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
        body: GetBuilder<MakeReservtion>(
      id: 'new',
      builder: (logic) {
        String? id = logic.travel.id;
        int? count = logic.travel.count;
        DateTime? time = logic.travel.time;
        String? from = logic.travel.from;
        String? to = logic.travel.to;
        int? price = logic.travel.price;
        int? No = logic.travel.No;
        return ListView(
          children: [
            Stack(
              children: [
                Hero(
                  tag: Image.network(logic.travel.image!),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(17),
                                bottomRight: Radius.circular(17)),
                            image: DecorationImage(
                              image: NetworkImage(
                                logic.travel.image!,
                              ),
                              fit: BoxFit.fill,
                            )),
                        height: data.size.height * 0.5,
                        // child: Image.network(
                        //
                        // ),
                      ),
                      SizedBox(
                        height: data.size.height * 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(17),
                                bottomRight: Radius.circular(17)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: data.size.height * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.07, vertical: height * .07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Container(),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .07,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          width: width * 0.5,
                          height: height * 0.06,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: Center(
                            child: Text(
                              "من ${logic.travel.from!} "
                              "الى ${logic.travel.to!} ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 0,
                          bottom: 16,
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // const Spacer(),
                                  Text(
                                    // ignore: prefer_adjacent_string_concatenation
                                    '${logic.travel.price}'
                                    "  جنيه",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الزمن: ${DateFormat.jm().format(logic.travel.time!)}'
                                    "  ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'التاريخ: ${DateFormat.yMd().format(logic.travel.time!)}'
                                    "  ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المقاعد المتوفرة: ${logic.travel.count}'
                                    "  ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              // alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(15),
              child: Container(
                // height: data.size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: GetBuilder<MakeReservtion>(
                    builder: (logic) {
                      return Form(
                        key: logic.formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        
                            CustomTextField(
                                controller: logic.passNumber,
                                validator: (value) {
                                  return logic.validateCount(value!, count!);
                                },
                                lable: 'عدد المقاعد',
                                icon: const Icon(Icons.numbers),
                                input: TextInputType.number),
                            CustomTextButton(
                                lable: 'حجز',
                                ontap: () => logic.makeReserve(id!, count!, No!,
                                    time!, from!, to!, price!))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
