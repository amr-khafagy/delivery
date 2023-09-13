
import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class LoginData {
  Crud crud;

  LoginData({required this.crud});

  postData(String password, String email) async {
    var response = await crud.postData(AppLinks.login, {
      "delivery_password":password,
      "delivery_email":email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
