import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/constant/routes.dart';
import 'package:delivery/core/function/getpolyline.dart';
import 'package:delivery/core/services/services.dart';
import 'package:delivery/data/datasource/remote/orders/orders.dart';
import 'package:delivery/data/model/ordersmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingController extends GetxController {
  StreamSubscription<Position>? positionStream;
  GoogleMapController? gmc;
  List<Marker> marker = [];
  StatuesRequest statuesRequest = StatuesRequest.success;
  late OrdersModel ordersModel;
  CameraPosition? cameraPosition;
  double? deslat;
  double? deslong;
  late Timer timer;
  MyServices myServices = Get.find();

  double? currentlat;
  double? cureentlong;

  Set<Polyline> polylineset = {};
  OrdersData ordersData = OrdersData(Get.find());

  donedelivery() async {
    statuesRequest = StatuesRequest.loading;
    update();
    await ordersData.ordersDone(
        ordersModel.ordersId!, ordersModel.ordersUserid!);
    Get.offAllNamed(AppRoutes.homepage);
  }

  getCurrentLocation() {
    cameraPosition = CameraPosition(
        target: LatLng(double.parse(ordersModel.addressLat!),
            double.parse(ordersModel.addressLang!)),
        zoom: 12.476);
    marker.add(Marker(
        markerId: const MarkerId("Destination"),
        position: LatLng(double.parse(ordersModel.addressLat!),
            double.parse(ordersModel.addressLang!))));
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      print("===============current position");
      print(position!.latitude);
      print(position.longitude);
      if (gmc != null) {
        gmc!.animateCamera(
            CameraUpdate.newLatLng(LatLng(currentlat!, cureentlong!)));
      }

      marker.removeWhere((element) => element.mapsId.value == "Current");
      marker.add(Marker(
          markerId: const MarkerId("Current"),
          position: LatLng(position.latitude, position.longitude)));
      update();
    });
  }

  refreshLocation() async {
    await Future.delayed(Duration(seconds: 2));
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      FirebaseFirestore.instance
          .collection("delivery")
          .doc(ordersModel.ordersId)
          .set({
        "lat": currentlat,
        "long": cureentlong,
        "delivery": myServices.sharedPreferences.getString("id")
      });
    });
  }

  initpolyLine() async {
    deslat = double.parse(ordersModel.addressLat!);
    deslong = double.parse(ordersModel.addressLang!);
    await Future.delayed(Duration(seconds: 1));
    polylineset = await getPolyline(30.466160, 31.179310, deslat, deslong);
    update();
  }

  @override
  void onInit() {
    ordersModel = Get.arguments['ordersModel'];
    initpolyLine();
    getCurrentLocation();
    refreshLocation();
    super.onInit();
  }

  @override
  void onClose() {
    positionStream!.cancel();
    gmc!.dispose();
    timer.cancel();
    super.onClose();
  }
}
//()
