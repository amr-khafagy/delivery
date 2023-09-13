import 'package:delivery/controller/home/homescreen_controller.dart';
import 'package:delivery/view/widgets/Home/custombottomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerIMP>(
      builder: (controller) => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          children: [
            ...List.generate(controller.listpage.length, ((index) {
              return Expanded(
                child: CustomBottomAppBar(
                        iconData: controller.iconbottombar[index],
                        active: controller.currentpage == index ? true : false,
                        textButton: controller.tittlebottombar[index],
                        onPressed: (){
                          controller.changepage(index);
                        },
                      ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
