import 'package:delivery/controller/orders/ordersdetails.dart';
import 'package:delivery/controller/tracking_controller.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/function/getpolyline.dart';
import 'package:delivery/core/shared/appbar.dart';
import 'package:delivery/view/widgets/orders/details/orderdetailscard.dart';
import 'package:delivery/view/widgets/orders/details/pricecard.dart';
import 'package:delivery/view/widgets/orders/details/shippingaddresscard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTracking extends StatelessWidget {
  const OrderTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TrackingController());
    return Scaffold(
      body: GetBuilder<TrackingController>(builder: (orderTrackingController) {
        return HandlingDataView(
            statuesRequest: orderTrackingController.statuesRequest,
            widget: Column(
              children: [
                OrdersAppBar(tittle: "Tracking"),
                if (orderTrackingController.ordersModel.ordersType == "0")
                  ShippingAddressCard(
                      ordersModel: orderTrackingController.ordersModel),
                if (orderTrackingController.ordersModel.ordersType == "0")
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GoogleMap(
                            polylines: orderTrackingController.polylineset,
                            mapType: MapType.normal,
                            markers: orderTrackingController.marker.toSet(),
                            initialCameraPosition:
                                orderTrackingController.cameraPosition!,
                            onMapCreated: (GoogleMapController controllermap) {
                              orderTrackingController.gmc = controllermap;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  child: MaterialButton(onPressed: () {
                    orderTrackingController.donedelivery();
                  },color:AppColor.favoritecolor,child: Text("The order has been deliveried")),
                )
              ],
            ));
      }),
    );
  }
}
