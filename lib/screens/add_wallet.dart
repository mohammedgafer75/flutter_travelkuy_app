import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      appBar: AppBar(
        title: const Text('اضفة محفظة'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.only(
                  top: data.padding.top * .7,
                  // bottom: data.padding.bottom * .3),
                ),
                height: height * 0.6,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(
                          right: width / 100, left: width / 100),
                      height: height * 0.1,
                      width: width * 0.8,
                      // decoration: BoxDecoration(
                      //  color: Colors.white.withOpacity(0.5),
                      // borderRadius: BorderRadius.circular(16),
                      // ),
                      child: TextFormField(
                        controller: number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your account number";
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(.7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          prefixIcon: const Icon(
                            Icons.account_box,
                            size: 24,
                            color: Colors.black,
                          ),

                          labelText: 'رقم الحساب',

                          labelStyle: const TextStyle(color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.black),

                          // hintText: hint,
                          //  hintStyle: kBodyText,
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(
                          right: width / 100, left: width / 100),
                      height: height * 0.1,
                      width: width * 0.8,
                      // decoration: BoxDecoration(
                      //  color: Colors.white.withOpacity(0.5),
                      // borderRadius: BorderRadius.circular(16),
                      // ),
                      child: TextFormField(
                        controller: password,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your account password";
                          }
                          if (val.length < 6) {
                            return "length must be more than 5";
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(.7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            size: 24,
                            color: Colors.black,
                          ),

                          labelText: 'كلمة السر',

                          labelStyle: const TextStyle(color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.black),

                          // hintText: hint,
                          //  hintStyle: kBodyText,
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Center(
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: height / 45,
                              bottom: height / 45,
                              left: width / 10,
                              right: width / 10)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Colors.blueAccent)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showLoadingDialog(context);
                          });
                          auth.User? user = FirebaseAuth.instance.currentUser;
                          String? name = user!.displayName;
                          Map<String, dynamic> data = <String, dynamic>{
                            "uid": user.uid,
                            "name": name,
                            "account number": number.text,
                            "password": password.text,
                            "balance": 5000000000000000000,
                          };
                          try {
                            await FirebaseFirestore.instance
                                .collection('wallet')
                                .doc()
                                .set(data);
                            setState(() {
                              Navigator.of(context).pop();
                              showBar(context, 'تم انشاء المحفظة', 1);

                              //print('this is result:$res');
                            });
                          } catch (e) {
                            setState(() {
                              Navigator.of(context).pop();
                              showBar(context, e.toString(), 1);
                            });
                          }
                        }
                      },
                      child: const Text(
                        'انشاء',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }

  void showBar(BuildContext context, String msg, int ch) {
    var bar = SnackBar(
      backgroundColor: ch == 0 ? Colors.red : Colors.green,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: SpinKitFadingCube(
            color: Colors.blue,
            size: 50,
          ),
        ),
      ),
    );
  }
}
