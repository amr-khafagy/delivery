import 'package:delivery/controller/tracking_controller.dart';
import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/function/handlingdata.dart';
import 'package:delivery/core/services/services.dart';
import 'package:delivery/data/datasource/remote/orders/orders.dart';
import 'package:delivery/data/model/ordersmodel.dart';
import 'package:get/get.dart';

class PendingOrdersController extends GetxController {
  List<OrdersModel> ordersList = [];
  StatuesRequest statuesRequest = StatuesRequest.none;
  MyServices myServices = Get.find();
  OrdersData orders = OrdersData(Get.find());

  getOrders() async {
    ordersList.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await orders.ordersPendingData();
    statuesRequest = handlingData(response);
    if (StatuesRequest.success == statuesRequest) {
      if (response['status'] == "success") {
        List listdata = response['data'];
        ordersList.addAll(listdata.map((e) => OrdersModel.fromJson((e))));
      } else {
        statuesRequest = StatuesRequest.failure;
      }
      update();
    }
  }

  approveOrders(String ordersid, String userid) async {
    ordersList.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await orders.ordersApproveData(
        ordersid, userid, myServices.sharedPreferences.getString("id")!);
    statuesRequest = handlingData(response);
    if (StatuesRequest.success == statuesRequest) {
      if (response['status'] == "success") {
        TrackingController trackingController=Get.put(TrackingController());
      } else {
        statuesRequest = StatuesRequest.failure;
      }
      update();
    }
  }

  String ordersType(String val) {
    if (val == "0") {
      return "delivery";
    } else {
      return "Recive";
    }
  }

  String paymentmethod(String val) {
    if (val == "0") {
      return "card";
    } else {
      return "cash";
    }
  }

  String ordersStatues(String val) {
    if (val == "0") {
      return "Pending Approval";
    } else if (val == "1") {
      return "The order is pending prepare";
    } else if (val == "2") {
      return "Ready to picked up by delivery man";
    } else if (val == "3") {
      return "on the way";
    } else {
      return "archieve";
    }
  }

  refreshorders() {
    getOrders();
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}
