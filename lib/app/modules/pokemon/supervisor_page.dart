import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'supervisor_controller.dart';
import 'widgets/body_page.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/custom_appbar.dart';

class SupervisorPage extends StatelessWidget {
  DashboardController dashController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: CustomAppBar(),
            body: BodyPage(),
            bottomNavigationBar: BottomNavBar(),
          )),
    );
  }
}
