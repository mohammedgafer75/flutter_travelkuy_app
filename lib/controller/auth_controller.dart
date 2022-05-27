import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/screens/home_screen.dart';
import 'package:flutter_travelkuy_app/ui/login_page.dart';
import 'package:flutter_travelkuy_app/widgets/loading.dart';
import 'package:flutter_travelkuy_app/widgets/snackbar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number;

  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onInit();
  }

  String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = const LoginPage();
    } else {
      route = const HomeScreen();
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update(['loginOb']);
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update(['reOb']);
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update(['RreOb']);
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter this filed";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (Rpassword.text != value) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('هل تريد تسجيل الخروج من التطبيق'),
      actions: [
        TextButton(
            onPressed: () async {
              await auth
                  .signOut()
                  .then((value) => Get.offAll(() => const LoginPage()));
            },
            child: const Text('تاكيد')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('رجوع'))
      ],
    ));
  }

  void register() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        repassword.text.isNotEmpty &&
        number.text.isNotEmpty) {
      if (password.text == repassword.text) {
        try {
          // SmartDialog.showLoading();
          showdilog();
          final credential = await auth.createUserWithEmailAndPassword(
              email: email.text, password: password.text);
          credential.user!.updateDisplayName(name.text);
          await credential.user!.reload();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
            'name': name.text,
            'email': email.text,
            'number': int.tryParse(number.text),
            'uid': credential.user!.uid,
          });
          Get.back();
          email.clear();
          password.clear();
          showbar("About User", "User message", "تم التسجيل بنجاح!!", true);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            Get.back();
            showbar(
                "About Login", "Login message", 'الايميل محجوز مسبقا', false);
          }
          if (e.code == 'weak-password') {
            Get.back();
            showbar("About Login", "Login message", 'كلمة المرور ضعيفة', false);
          } else {
            Get.back();
            showbar("About User", "User message", e.toString(), false);
          }
        }
      } else {
        showbar(
            "About User", "User message", 'الرجاء مطابقة كلمة المرور', false);
      }
    } else {
      showbar(
          "About User", "User message", 'الرجاء ادخال جميع البيانات', false);
    }
  }

  void login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        Get.back();
        email.clear();
        password.clear();
        Get.offAll(() => const HomeScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          showbar("About Login", "Login message", 'كلمة السر ضعيفة', false);
        }
        if (e.code == 'email-already-in-use') {
          Get.back();
          showbar("About Login", "Login message", 'الايميل محجوز مسبقا', false);
        }
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message", ' اليوزر غير موجود', false);
        } else {
          Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    } else {
      showbar(
          "About Login", "Login message", 'الرجاء ادخال جميع البيانات', false);
    }
  }
}
