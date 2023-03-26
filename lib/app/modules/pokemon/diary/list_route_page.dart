import 'package:pokemon_heb/app/global_widgets/user_day_not_working.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/responsive_app.dart';
import '../../../global_widgets/loading_info.dart';
import '../../../global_widgets/header_schedule_supervisor.dart';
import '../supervisor_controller.dart';
import 'view_route_info.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<SupervisorController>(
      id: 'SupervisorListRoutePage',
      builder: (_) => _.loading
          ? CircularProgressIndicator()
          : _.itemsRouteSup.length == 0
              ? LoadingInfo()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                      child: Align(
                        alignment: Alignment.center,
                        child: HeaderScheduleSupervisor(
                          dateCurrent: _.dateCurrentStr,
                          count: _.itemsRouteSup.length.toString(),
                          total: _.totalItemsRouteSupPaginator.toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() => LazyLoadScrollView(
                            onEndOfPage: _.loadNextPage,
                            isLoading: _.lastPage,
                            child: ListView.builder(
                              controller: _.scrollController,
                              itemCount: _.itemsRouteSup.length,
                              itemBuilder: (context, index) {
                                return ViewRouteInfo(
                                    _.itemsRouteSup[index], index);
                              },
                            ),
                          )),
                    ),
                  ],
                ),
    );
  }
}
