import 'package:delivery/controller/auth/forgetpassword/checkemail.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/function/validinput.dart';
import 'package:delivery/view/widgets/login/bodytextauth.dart';
import 'package:delivery/view/widgets/login/buttonauth.dart';
import 'package:delivery/view/widgets/login/textformfieldauth.dart';
import 'package:delivery/view/widgets/login/tittletextauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Get.put(ForgetPasswordControllIMP());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.backgroundcolor,
          elevation: 0.0,
          title: Text(
            "14".tr,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColor.grey),
          ),
        ),
        body: GetBuilder<ForgetPasswordControllIMP>(
          builder: (controller)  {
            return HandlingDataView(statuesRequest: controller.statuesRequest, widget: Form(
              key: controller.formstate,
              child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TittleTextAuth(
                            tittletext: "27".tr,
                          ),
                          BodyTextAuth(
                            bodytextauth: "29".tr,
                          ),
                          TextFormFieldAuth(
                            keyboardtype: TextInputType.emailAddress,
                            valid: (value) {
                              return validinput(value!, 3, 40, "email");
                            },
                            authcontroller: controller.email,
                            textlabelauth: "18".tr,
                            suffixiconauth: Icons.email,
                            hinttextauth: "12".tr,
                          ),
                          ButtonAuth(
                            buttontext: "30".tr,
                            onpressed: () {
                              controller.checkemail();
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),);
          }
        ));
  }
}
