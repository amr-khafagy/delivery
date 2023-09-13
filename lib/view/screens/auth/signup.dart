import 'package:delivery/controller/auth/signup_controller.dart';
import 'package:delivery/core/class/handlingdataview.dart';
import 'package:delivery/core/constant/appimage.dart';
import 'package:delivery/core/constant/color.dart';
import 'package:delivery/core/function/appexit.dart';
import 'package:delivery/core/function/validinput.dart';
import 'package:delivery/view/widgets/login/bodytextauth.dart';
import 'package:delivery/view/widgets/login/buttonauth.dart';
import 'package:delivery/view/widgets/login/havingaccountrow.dart';
import 'package:delivery/view/widgets/login/textformfieldauth.dart';
import 'package:delivery/view/widgets/login/tittletextauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Get.put(SignUpControllIMP());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text(
          "17".tr,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: AppColor.grey),
        ),
      ),
      body: WillPopScope(
          onWillPop: alertexitapp,
          child: GetBuilder<SignUpControllIMP>(
            builder: (controller) {
              return HandlingDataView(statuesRequest: controller.statuesRequest, widget:Form(
                key: controller.formstate,
                child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              AppImageAsset.logo,
                              height: 170,
                            ),
                            TittleTextAuth(
                              tittletext: "10".tr,
                            ),
                            BodyTextAuth(
                              bodytextauth: "24".tr,
                            ),
                            TextFormFieldAuth(
                              keyboardtype: TextInputType.name,
                              valid: (value) {
                                return validinput(value!, 3, 20, "username");
                              },
                              authcontroller: controller.username,
                              textlabelauth: "20".tr,
                              suffixiconauth: Icons.person,
                              hinttextauth: "23".tr,
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
                            TextFormFieldAuth(
                              keyboardtype: TextInputType.phone,
                              valid: (value) {
                                return validinput(value!, 3, 40, "phonenumber");
                              },
                              authcontroller: controller.phonenumber,
                              textlabelauth: "21".tr,
                              suffixiconauth: Icons.phone,
                              hinttextauth: "22".tr,
                            ),
                            GetBuilder<SignUpControllIMP>(
                              builder: (controller) => TextFormFieldAuth(
                                  isshowpassword: controller.isshowpassword,
                                  ontab: () {
                                    controller.showpassword();
                                  },
                                  showicon: Icons.remove_red_eye,
                                  keyboardtype: TextInputType.visiblePassword,
                                  valid: (value) {
                                    return validinput(
                                        value!, 3, 40, "password");
                                  },
                                  authcontroller: controller.password,
                                  textlabelauth: "19".tr,
                                  suffixiconauth: Icons.password,
                                  hinttextauth: "13".tr),
                            ),
                            ButtonAuth(
                              buttontext: "17".tr,
                              onpressed: () {
                                controller.signup();
                              },
                            ),
                            AccountRow(
                              text: "25".tr,
                              inkwelltext: "26".tr,
                              ontap: () {
                                controller.togologin();
                              },
                            )
                          ],
                        ),
                      ),
                    )),
              ),);
            }
          )),
    );
  }
}
