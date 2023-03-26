import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/responsive_app.dart';
import '../../../../config/string_app.dart';
import '../../../../global_widgets/header_store.dart';
import '../../../../global_widgets/info_address.dart';
import '../../../../global_widgets/route_name.dart';
import '../stores_controller.dart';

class ShowStore extends StatelessWidget {
  final ClientsListByRouteSupervisor item;
  const ShowStore(this.item);
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 10);
    return GetBuilder<StoresController>(
      builder: (_) => Container(
        color: themeApp.colorBackGround,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  responsiveApp.edgeInsetsApp!.onlyMediumLeftRightTopEdgeInsets,
              child: Align(
                alignment: Alignment.center,
                child: BootstrapContainer(
                  fluid: true,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: HeaderStore(
                                title: item.nameClient.toString(),
                                subtitle: item.cellarShow.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: RouteName(
                                text: item.idRoute.toString() +
                                    text_ +
                                    item.nameRoute.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: InfoAddress(
                                text: item.clientAddress.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
