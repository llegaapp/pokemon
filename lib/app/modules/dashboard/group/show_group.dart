import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (_) => Container(
              child: Center(
                child: Text('Show Group'),
              ),
            ));
  }
}
