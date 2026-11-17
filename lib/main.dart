import 'package:delivery/bindings/initialbindings.dart';
import 'package:delivery/core/localization/changelocal.dart';
import 'package:delivery/core/localization/translation.dart';
import 'package:delivery/core/services/services.dart';
import 'package:delivery/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initalservices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(builder: (context,child){
      return GetMaterialApp(
          initialBinding:InitialBindings(),
          locale: controller.language,
          translations: MyTranslation(),
          debugShowCheckedModeBanner: false,
          // home: const SelectLanguage(),
          getPages:routes,
          theme: controller.apptheme);

    },designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,);
  }
}