import 'package:pokemon_heb/app/modules/pokemon/stores/stores_content_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/pull_to_refresh.dart';
import '../pokemon_controller.dart';
import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';

class StoreDetailPage extends StatelessWidget {
  final ClientsListByRouteSupervisor item;
  final int index;
  final String currentStoreList;
  final void Function(BuildContext, ClientsListByRouteSupervisor, int, String)
      onPressed;
  const StoreDetailPage(
      this.item, this.onPressed, this.index, this.currentStoreList);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              tiendaStr,
              style: themeApp.textButtonlink,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0,
          ),
          body: PullToRefresh(
              child: StoreConentDetailPage(
                  item, onPressed, index, currentStoreList),
              controller: _.refreshControllerSupervisorItem,
              onRefresh: () {
                _.onRefreshSupervisor(_.refreshControllerSupervisorItem);
              }),
        ),
      ),
    );
  }
}
