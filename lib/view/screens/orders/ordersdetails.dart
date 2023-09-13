import 'package:delivery/controller/orders/ordersdetails.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/constant/routes.dart';
import 'package:delivery/core/shared/appbar.dart';
import 'package:delivery/view/widgets/login/buttonauth.dart';
import 'package:delivery/view/widgets/orders/details/orderdetailscard.dart';
import 'package:delivery/view/widgets/orders/details/pricecard.dart';
import 'package:delivery/view/widgets/orders/details/shippingaddresscard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsController());
    return Scaffold(
      body:
          GetBuilder<OrderDetailsController>(builder: (orderDetailsController) {
        return HandlingDataView(
            statuesRequest: orderDetailsController.statuesRequest,
            widget: ListView(
              children: [
                const OrdersAppBar(tittle: "Order Details"),
                OrderDetailsCard(cartModel: orderDetailsController.data),
                PriceCard(ordersModel: orderDetailsController.ordersModel),
                if (orderDetailsController.ordersModel.ordersType == "0")
                  ShippingAddressCard(
                      ordersModel: orderDetailsController.ordersModel),
                if (orderDetailsController.ordersModel.ordersType == "0")
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: orderDetailsController.markers.toSet(),
                          initialCameraPosition:
                              orderDetailsController.cameraPosition!,
                          onMapCreated: (GoogleMapController controllermap) {
                            orderDetailsController.completerController
                                .complete(controllermap);
                          },
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (orderDetailsController.ordersModel.ordersType == "0" &&
                    orderDetailsController.ordersModel.ordersStatues == "3")
                  MaterialButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.tracking,arguments:{"ordersModel":orderDetailsController.ordersModel} );
                    },
                    color: AppColor.favoritecolor,
                    child: const Text(
                      "Tracking",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ));
      }),
    );
  }
}
