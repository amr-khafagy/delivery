import 'package:delivery/controller/orders/acceptedprdercontroller.dart';
import 'package:delivery/controller/orders/pendingordercontroller.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/view/widgets/orders/accepted/acceptedorders.dart';
import 'package:delivery/core/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptedOrders extends StatelessWidget {
  const AcceptedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AcceptedOrdersController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AcceptedOrdersController>(builder: (controller) {
          return HandlingDataView(statuesRequest: controller.statuesRequest, widget:SingleChildScrollView(
            child: Column(
              children: [
                const  OrdersAppBar(tittle: "Accepted Orders"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.ordersList.length,
                  itemBuilder: (context, index) {
                    return AcceptedOrdersCard(orderslistmodel: controller.ordersList[index]);
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

