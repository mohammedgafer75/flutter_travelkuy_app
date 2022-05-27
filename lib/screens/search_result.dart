import 'package:flutter/material.dart';
import 'package:flutter_travelkuy_app/controller/home_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
// import 'package:travelkuy_dashboard/controller/all_travel_controller.dart';

import '../widgets/property.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.result}) : super(key: key);
  final dynamic result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' الرحلات'),
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
          child: ListView.builder(
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Hero(
                          tag: Image.network(
                            result[index].image!,
                            fit: BoxFit.fill,
                          ),
                          child: Property(
                              property: result[index]));
                    },
                    itemCount: result.length,

    )




    ));
  }
}
