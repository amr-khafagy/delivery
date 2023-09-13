import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class ResetPasswordlData {
  Crud crud;

  ResetPasswordlData({required this.crud});

  postData(String email,String password) async {
    var response = await crud.postData(AppLinks.resetpassword, {
      "delivery_email":email,
      "delivery_password":password,
    });
    return response.fold((l) => l, (r) => r);
  }
}