import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/loading_info.dart';
import '../../../global_widgets/pull_to_refresh.dart';
import '../supervisor_controller.dart';
import 'show_home.dart';

class BodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => PullToRefresh(
          child: _.loading ? LoadingInfo() : ShowHome(),
          controller: _.refreshControllerSupervisor,
          onRefresh: () {
            _.onRefreshSupervisor(_.refreshControllerSupervisor);
          }),
    );
  }
}
