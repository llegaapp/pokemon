import 'package:pokemon_heb/app/modules/pokemon/stores/local_widgets/show_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/button1.dart';
import 'teams_controller.dart';
import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';

class TeamsDetailPage extends StatelessWidget {
  final ClientsListByRouteSupervisor item;
  final void Function(BuildContext, ClientsListByRouteSupervisor ) onPressed;
  const TeamsDetailPage(this.item, this.onPressed );

  @override
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
              onPressed(context, item );
            },
          ),
        ],
      ),
    );
    return GetBuilder<TeamsController>(
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
          body: ShowStore(item),
          bottomNavigationBar: buttonBar,
        ),
      ),
    );
  }
}
