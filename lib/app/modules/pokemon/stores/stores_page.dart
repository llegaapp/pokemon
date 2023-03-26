import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/constant.dart';
import '../../../config/responsive_app.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../global_widgets/no_results.dart';
import 'local_widgets/show_list_stores.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/app/global_widgets/input2.dart';
import 'package:pokemon_heb/app/global_widgets/dropdown2.dart';

import '../supervisor_controller.dart';

class StoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 10);
    return GetBuilder<SupervisorController>(
      builder: (_) => Container(
        child: _.loading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                    child: Align(
                      alignment: Alignment.center,
                      child: BootstrapContainer(fluid: true, children: [
                        BootstrapRow(
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-8',
                              child: Input2(
                                value: '',
                                controller: _.searchController,
                                label: buscarStr,
                                onChange: (v) {
                                  _.isSearchStore = true;
                                  _.filteritemsStores();
                                },
                              ),
                            ),
                            BootstrapCol(
                                sizes: 'col-4',
                                child: Select(
                                  value: _.routeStoresSelected,
                                  label: rutaStr,
                                  dataList: _.routesStores,
                                  onChange: (v) async {
                                    _.routeStoresSelected = v;
                                    _.searchController.text = '';
                                    _.isSearchStore = false;
                                    _.filteritemsStores();
                                  },
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  (_.currentStoreList == Constant.AGENDS_TODAY_VALUE)
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: BootstrapContainer(fluid: true, children: [
                              BootstrapRow(
                                children: <BootstrapCol>[
                                  BootstrapCol(
                                    sizes: 'col-3',
                                    child: _.itemCountStores(
                                        Constant.ICON_STORE,
                                        Constant.NAME__ALL,
                                        Utils.prefs.count_states_all),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-3',
                                    child: _.itemCountStores(
                                        Constant.ICON_CHECK,
                                        Constant.NAME_STATUS_TERMINADAS,
                                        Utils.prefs.count_states_finished),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-3',
                                    child: _.itemCountStores(
                                        Constant.ICON_PROGRESS,
                                        Constant.NAME_STATUS_ENCURSO,
                                        Utils.prefs.count_states_in_progress),
                                  ),
                                  BootstrapCol(
                                    sizes: 'col-3',
                                    child: _.itemCountStores(
                                        Constant.ICON_BLOCK,
                                        Constant.NAME_STATUS_PENDIENTES,
                                        Utils.prefs.count_states_pending),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        )
                      : Container(),
                  Flexible(
                    child: _.itemsStores.length == 0
                        ? NoResults()
                        : ShowListStores(),
                  )
                ],
              ),
      ),
    );
  }
}
