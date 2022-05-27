import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/home_controller.dart';
import 'package:flutter_travelkuy_app/widgets/custom_button.dart';
import 'package:flutter_travelkuy_app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class Complains extends StatelessWidget {
  const Complains({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة شكوى'),
      ),
      body: GetBuilder<HomeController>(
        builder: (logic) {
          return Form(
            key: logic.formKey2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                      controller: logic.complain,
                      validator: (validator) {
                        return logic.validate(validator!);
                      },
                      lable: 'الشكوى',
                      icon: const Icon(Icons.report),
                      input: TextInputType.text),
                  CustomTextButton(
                      lable: 'ارسال',
                      ontap: () {
                        logic.addComplains();
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
