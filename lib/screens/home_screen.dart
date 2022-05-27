import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_travelkuy_app/constants/color_constant.dart';
import 'package:flutter_travelkuy_app/controller/home_controller.dart';
import 'package:flutter_travelkuy_app/controller/make_reservation.dart';
import 'package:flutter_travelkuy_app/models/travlog_model.dart';
import 'package:flutter_travelkuy_app/screens/all_reservtion.dart';
import 'package:flutter_travelkuy_app/screens/all_travel.dart';
import 'package:flutter_travelkuy_app/screens/complains.dart';
import 'package:flutter_travelkuy_app/screens/details.dart';
import 'package:flutter_travelkuy_app/widgets/bottom_navigation_travelkuy.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  // late final Destination destination;
  _HomeScreenState();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('الصفحة الرئيسية'),
        elevation: 0,
      ),
      backgroundColor: mBackgroundColor,
      bottomNavigationBar: const BottomNavigationTravelkuy(),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (logic) {
          return logic.travels.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            MaterialButton(
                                color: Colors.blueAccent,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    "حجوزاتي",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () =>
                                    Get.to(() => const AllReservtion())),
                            Container(
                              // margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.only(right: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mBorderColor, width: 1),
                              ),
                              child: MaterialButton(
                                  color: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Text(
                                      "عرض رحلات",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: "WorkSansBold"),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Get.to(() => const AllTravel())),
                            ),
                            Container(
                              // margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.only(right: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mBorderColor, width: 1),
                              ),
                              child: MaterialButton(
                                  color: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Text(
                                      "اضافة شكوى",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: "WorkSansBold"),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Get.to(() => const Complains())),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16, bottom: 24),
                      child: Text(
                        '   مرحب بيكم! 👋 ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: mTitleColor,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 190,
                            child: GetBuilder<MakeReservtion>(
                              init: MakeReservtion(),
                              builder: (log) {
                                return Swiper(
                                  outer: true,
                                  scrollDirection: Axis.horizontal,
                                  onIndexChanged: (index) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                  autoplay: true,
                                  layout: SwiperLayout.DEFAULT,
                                  itemCount: 2,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await log.getTravelById(
                                            logic.travels[index].id!);
                                        Get.to(() => const Details());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          // image: DecorationImage(
                                          //     image: NetworkImage(
                                          //       logic.travels[index].image!,
                                          //     ),
                                          //     fit: BoxFit.cover),
                                        ),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  logic.travels[index].image!,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      (const Icon(Icons.error)),
                                              width: 1000,
                                              height: 190,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.9),
                                                    ],
                                                  ),
                                                ),
                                                width: width * 0.5,
                                                height: height * 0.06,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "من ${logic.travels[index].from} "
                                                    "الى ${logic.travels[index].to} ",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Row(
                          //       children: map<Widget>(
                          //         logic.travels,
                          //         (index, image) {
                          //           return Container(
                          //             alignment: Alignment.centerLeft,
                          //             height: 6,
                          //             width: 6,
                          //             margin: const EdgeInsets.only(right: 8),
                          //             decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: _current == index
                          //                     ? mBlueColor
                          //                     : mGreyColor),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    // Service Section
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
                    //   child: Text(
                    //     '!يلا ارح 👋',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w600,
                    //         color: mTitleColor,
                    //         fontSize: 16),
                    //   ),
                    // ),

                    const Padding(
                      padding: EdgeInsets.only(right: 16, top: 24, bottom: 12),
                      child: Text(
                        ' دي بلدنا 👋 ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: mTitleColor,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 181,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16),
                        itemCount: travlogs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 104,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                travlogs[index].image!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      child: Text(
                                        travlogs[index].name!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: mFillColor),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  travlogs[index].content!,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: mTitleColor),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  travlogs[index].place!,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: mBlueColor),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
