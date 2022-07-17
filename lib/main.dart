import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'controller/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        textDirection: ui.TextDirection.rtl,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreenView(
          navigateRoute: controller.route,
          backgroundColor: Colors.indigo,
          duration: 3000,
          imageSize: 130,
          imageSrc: 'assets/images/travel_bus.png',
          text: 'TravelKuy App',
          textType: TextType.TyperAnimatedText,
          textStyle: const TextStyle(fontSize: 30.0, color: Colors.white),
        ));
  }
}
