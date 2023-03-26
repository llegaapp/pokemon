import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/responsive_app.dart';
import '../stores/stores_page.dart';
import '../teams/teams_page.dart';
import '../diary/list_route_page.dart';
import '../group/group_page.dart';
import '../supervisor_controller.dart';

class ShowHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => Container(
        child: _.indexPage == 0
            ? StoresPage()
            : _.indexPage == 1
                ? ListRoutePage()
                : TeamsPage(),
      ),
    );
  }
}
