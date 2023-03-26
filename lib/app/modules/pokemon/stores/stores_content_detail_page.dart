import 'package:pokemon_heb/app/modules/pokemon/stores/local_widgets/show_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/button1.dart';
import 'stores_controller.dart';
import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';

class StoreConentDetailPage extends StatelessWidget {
  final ClientsListByRouteSupervisor item;
  final int index;
  final String currentStoreList;
  final void Function(BuildContext, ClientsListByRouteSupervisor, int, String)
      onPressed;
  const StoreConentDetailPage(
      this.item, this.onPressed, this.index, this.currentStoreList);

  @override
  Widget build(BuildContext context) {
    var buttonBar = Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          Button1(
            label: gestionarTiendaStr,
            style: themeApp.text18boldWhite,
            background: themeApp.colorPrimaryBlue,
            onPressed: () {
              ClientsListByRouteSupervisor _item =
                  ClientsListByRouteSupervisor.copy(item);
              onPressed(context, _item, index, currentStoreList);
            },
          ),
        ],
      ),
    );
    return GetBuilder<StoresController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: ShowStore(item),
          bottomNavigationBar: buttonBar,
        ),
      ),
    );
  }
}
