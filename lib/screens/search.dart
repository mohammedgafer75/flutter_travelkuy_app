import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/search_controller.dart';
import 'package:flutter_travelkuy_app/widgets/custom_button.dart';
import 'package:flutter_travelkuy_app/widgets/custom_textfield.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (logic) {
        return logic.loading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Scaffold(
            appBar: AppBar(
              title: const Text('صفحة البحث'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(controller: logic.from, validator: (value){},
                      lable: 'من', icon: const Icon(Icons.not_listed_location_outlined), input: TextInputType.text),
                  CustomTextField(controller: logic.to, validator: (value){},
                      lable: 'الى', icon: const Icon(Icons.not_listed_location_outlined), input: TextInputType.text),

                  CustomTextButton(lable: 'بحث', ontap: () {
                    logic.search();
                  })
                ],
              ),
            )
        );
      });

  }
}
