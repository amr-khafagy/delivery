import 'package:delivery/core/class/statusrequest.dart';
import 'package:delivery/core/constant/routes.dart';
import 'package:delivery/core/function/handlingdata.dart';
import 'package:delivery/data/datasource/remote/auth/forgetpassword/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordControll extends GetxController {
  checknewpassword();
  gotosuccessresetpassword();
}

class ResetPasswordControllIMP extends ResetPasswordControll {
  late TextEditingController newpassword;
  late TextEditingController confirmnewpassword;
  bool isshowpassword=true;
  ResetPasswordlData resetPasswordlData =
  ResetPasswordlData(crud: Get.find());
  StatuesRequest? statuesRequest;
  String? email;
  List data = [];
  GlobalKey<FormState>formstate=GlobalKey<FormState>();
  @override
  checknewpassword() {}

  @override
  gotosuccessresetpassword() async{
    if (newpassword.text != confirmnewpassword.text) {
      return Get.defaultDialog(
          title: "warning", middleText: "Password Not Match");
    }

    if(formstate.currentState!.validate()){
      statuesRequest = StatuesRequest.loading;
      update();
      var response = await resetPasswordlData.postData(email!,newpassword.text);
      statuesRequest=handlingData(response);
      if (StatuesRequest.success == statuesRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.successresetpassword);
        } else {
          Get.defaultDialog(
              title: "48".tr, middleText: "49".tr);
          statuesRequest = StatuesRequest.failure;
        }
      }

      update();
    }
  }
  showpassword(){
    isshowpassword=isshowpassword==true?false:true;
    update();
  }
  @override
  void onInit() {
    email = Get.arguments["email"];
    print(email);
    newpassword = TextEditingController();
    confirmnewpassword = TextEditingController();
    super.onInit;
  }

  @override
  void dispose() {
    newpassword.dispose();
    confirmnewpassword.dispose();
    super.dispose();
  }
}
