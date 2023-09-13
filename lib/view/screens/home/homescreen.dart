import 'package:delivery/controller/home/homescreen_controller.dart';

import 'package:delivery/view/widgets/Home/customappbarhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerIMP());
    return GetBuilder<HomeScreenControllerIMP>(
        builder: (controller) => Scaffold(
              bottomNavigationBar: const CustomAppBarHome(),
              body: WillPopScope(
                onWillPop: () {
                  controller.onPop();
                  return Future.value(false);
                },
                child: controller.listpage.elementAt(controller.currentpage),
              ),
            ));
  }
}
