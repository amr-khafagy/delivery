import 'dart:io';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/view/screens/orders/acceptedorders.dart';
import 'package:delivery/view/screens/orders/pending.dart';
import 'package:delivery/view/screens/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changepage(int page);
}

class HomeScreenControllerIMP extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listpage = [
    const Pending(),
    const AcceptedOrders(),
    const Setting(),
  ];
  List tittlebottombar = ["pending", "accept orders", "Setting"];
  List iconbottombar = [Icons.home, Icons.add, Icons.settings];

  onPop() {
    Get.defaultDialog(
        title: "Warning",
        middleText: "Do you want exit the app",
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColor.primarycolor,
        ),
        onCancel: () {},
        cancelTextColor: AppColor.primarycolor,
        confirmTextColor: Colors.white,
        buttonColor: AppColor.primarycolor,
        onConfirm: () {
          exit(0);
        });
  }

  @override
  changepage(int page) {
    currentpage = page;
    update();
  }
}
