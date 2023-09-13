import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class CheckemailData {
  Crud crud;

  CheckemailData({required this.crud});

  postData(String email) async {
    var response = await crud.postData(AppLinks.checkemail, {
      "delivery_email":email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
