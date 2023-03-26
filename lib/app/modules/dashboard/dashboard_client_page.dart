import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../config/string_app.dart';
import 'dashboard_controller.dart';

class DashboardClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              textStore,
              style: themeApp.textButtonlink,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0,
          ),
          body: Container(),
        ),
      ),
    );
  }
}
