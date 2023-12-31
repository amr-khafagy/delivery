import 'package:delivery/core/constant/color.dart';
import 'package:delivery/data/model/ordersmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceCard extends StatelessWidget {
  final OrdersModel ordersModel;
  const PriceCard({Key? key, required this.ordersModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      child: Text(
        "Price:${ordersModel.ordersTotalprice}\$",
        textAlign: TextAlign.center,
        style:TextStyle(
            color: AppColor.favoritecolor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
