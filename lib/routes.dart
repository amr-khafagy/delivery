import 'package:delivery/core/constant/routes.dart';
import 'package:delivery/core/middleware/middleware.dart';
import 'package:delivery/view/screens/auth/forgetpassord/checkemail.dart';
import 'package:delivery/view/screens/auth/forgetpassord/resetpassword.dart';
import 'package:delivery/view/screens/auth/forgetpassord/successresetpassword.dart';
import 'package:delivery/view/screens/auth/forgetpassord/verifycode.dart';
import 'package:delivery/view/screens/auth/login.dart';
import 'package:delivery/view/screens/auth/signup.dart';
import 'package:delivery/view/screens/auth/successsignup.dart';
import 'package:delivery/view/screens/auth/verifycodesignup.dart';
import 'package:delivery/view/screens/home/homescreen.dart';
import 'package:delivery/view/screens/orders/ordersdetails.dart';
import 'package:delivery/view/screens/orders/tracking.dart';
import 'package:delivery/view/screens/selectlanguage.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/",
      page: () => const SelectLanguage(),
      middlewares: [MiddleWare()]),
// GetPage(name: "/", page: ()=>const TestView()),
//onboarding
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.signup, page: () => const SignUp()),
  GetPage(name: AppRoutes.successsignup, page: () => const SucessSignUp()),
  GetPage(
      name: AppRoutes.verifycodesignup, page: () => const VerifyCodeSignUp()),

  //forgetten password
  GetPage(
      name: AppRoutes.successresetpassword,
      page: () => const SucessResetPassword()),
  GetPage(name: AppRoutes.forgetpassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoutes.resetpassword, page: () => const ResetPassword()),
  GetPage(name: AppRoutes.verifycode, page: () => const VerifyCode()),
  //Home
  GetPage(name: AppRoutes.homepage, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.details, page: () => const OrderDetails()),
//tracking
  GetPage(name: AppRoutes.tracking, page: () => const OrderTracking()),

];
