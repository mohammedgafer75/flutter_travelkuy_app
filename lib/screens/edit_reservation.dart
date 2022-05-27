import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/widgets/custom_button.dart';
import 'package:flutter_travelkuy_app/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class EditResrvation extends StatelessWidget {
  EditResrvation({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.name.text = data.name;
    controller.passNumber.text = data.passNumber.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل حجز'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              CustomTextField(
                  controller: controller.passNumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please add filed";
                    }
                    return null;
                  },
                  lable: 'عدد المقاعد',
                  icon: const Icon(Icons.numbers),
                  input: TextInputType.text),
              const SizedBox(
                height: 30,
              ),
              CustomTextButton(
                  lable: 'حفظ',
                  ontap: () {
                    controller.editResrvation(data.id, data.travelId);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
