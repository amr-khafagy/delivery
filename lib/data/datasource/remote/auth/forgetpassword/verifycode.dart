import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class VerifyCodeData {
  Crud crud;

  VerifyCodeData({required this.crud});

  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLinks.verifycode, {
      "delivery_email": email,
      "delivery_verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }
}