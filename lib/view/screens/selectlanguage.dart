import 'package:delivery/core/constant/routes.dart';
import 'package:delivery/core/localization/changelocal.dart';
import 'package:delivery/view/widgets/selectlanguagebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguage extends GetView<LocaleController> {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "1".tr,
              style: Theme.of(context).textTheme.headline1,
            ),
            SelectLanguageButton(
              buttontext: "Arabic",
              onPressed: () {
                controller.changelanguage("ar");
                Get.offAllNamed(AppRoutes.login);
              },
            ),
            SelectLanguageButton(
              buttontext: "English",
              onPressed: () {
                controller.changelanguage("en");
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      )),
    );
  }
}
