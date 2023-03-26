import 'package:pokemon_heb/app/global_widgets/user_blocked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../config/utils.dart';
import '../../global_widgets/in_construction.dart';
import '../../global_widgets/loading_info.dart';
import '../../global_widgets/user_day_not_working.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: themeApp.colorBackGround,
          body: _.loading
              ? LoadingInfo()
              : Utils.userBlocked
                  ? UserBlocked()
                  : Utils.userDayNotWorking
                      ? UserDayNotWorking()
                      : InConstruction(),
        ),
      ),
    );
  }
}
