import 'package:delivery/core/class/crud.dart';
import 'package:delivery/data/static/applink.dart';

class SignUpData {
  Crud crud;

  SignUpData({required this.crud});

  postData(String username, String password, String email, String phone) async {
    var response = await crud.postData(AppLinks.signup, {
      "delivery_name": username,
      "delivery_password": password,
      "delivery_email": email,
      "delivery_phone": phone
    });
    print(username);
    return response.fold((l) => l, (r) => r);
  }
}
