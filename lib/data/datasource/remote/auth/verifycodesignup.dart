
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class VerifyCodeSignUpData {
  Crud crud;

  VerifyCodeSignUpData({required this.crud});

  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLinks.verifycodeSignup, {
      "delivery_email": email,
      "delivery_verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }
  resenddata(String email) async {
    var response = await crud.postData(AppLinks.resendcode, {
      "delivery_email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
