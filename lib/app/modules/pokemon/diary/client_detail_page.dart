import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../global_widgets/pull_to_refresh.dart';
import '../supervisor_controller.dart';
import '../widgets/custom_appbar.dart';
import 'content_client_detail.dart';

class ClientDetailPage extends StatelessWidget {
  final RefreshController refreshController;
  const ClientDetailPage(this.refreshController);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CustomAppBar(),
          body: PullToRefresh(
              child: ContentClientDetail(),
              controller: refreshController,
              onRefresh: () {
                _.onRefreshSupervisor(refreshController);
              }),
        ),
      ),
    );
  }
}
