
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class OrdersData {
  Crud crud;

  OrdersData(this.crud);



  ordersPendingData() async {
    var response = await crud.postData(AppLinks.viewpending, {});

    return response.fold((l) => l, (r) => r);
  }
  ordersApproveData(String ordersid,String userid,String deliveryid) async {
    var response = await crud.postData(AppLinks.orderapprove, {
      "orderid": ordersid.toString(),
      "userid":userid.toString(),
      "delivery_id":deliveryid.toString()
    });
    return response.fold((l) => l, (r) => r);
  }
  ordersDone(String ordersid,String userid) async {
    var response = await crud.postData(AppLinks.orderdone, {
      "orderid": ordersid.toString(),
      "userid":userid.toString(),

    });
    return response.fold((l) => l, (r) => r);
  }
  ordersDetailsData(String ordersid) async {
    var response = await crud.postData(AppLinks.orderDetails, {
      "ordersid": ordersid.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  ordersArchieveData(String userid) async {
    var response = await crud.postData(AppLinks.archieve, {
      "id": userid.toString(),
    });

    return response.fold((l) => l, (r) => r);
  }
  ordersAcceptedData(String id) async {
    var response = await crud.postData(AppLinks.viewaccepted, {
      "delivery_id":id.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
