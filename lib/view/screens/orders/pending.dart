import 'package:delivery/controller/orders/acceptedprdercontroller.dart';
import 'package:delivery/controller/orders/pendingordercontroller.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/core/shared/appbar.dart';
import 'package:delivery/view/widgets/orders/pending/orderscard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pending extends StatelessWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrdersController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PendingOrdersController>(builder: (controller) {
          return HandlingDataView(statuesRequest: controller.statuesRequest, widget:SingleChildScrollView(
            child: Column(
              children: [
                const  OrdersAppBar(tittle: "Orders"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.ordersList.length,
                  itemBuilder: (context, index) {
                    return OrdersCard(orderslistmodel: controller.ordersList[index]);
                  },
                ),
              ],
            ),
          ));
        }),
      ),
    );
  }
}

