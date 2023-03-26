import 'package:pokemon_heb/app/global_widgets/item_store.dart';
import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';
import 'package:pokemon_heb/app/modules/pokemon/supervisor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/string_app.dart';
import '../../../../models/diary/route_sup.dart';

class ViewStoresInfo extends StatelessWidget {
  final ClientsListByRouteSupervisor item;
  final int index;
  final String currentStoreList;
  const ViewStoresInfo(this.item, this.index, this.currentStoreList);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemStore(
                  index: index,
                  idStatus: item.idStatus,
                  idRoute: item.idRoute,
                  nameClient: item.nameClient,
                  infoStore: item.idCellar.toString() +
                      text_ +
                      item.nameCellar.toString(),
                  onPressed: () {
                    DiaryClient diaryClient = DiaryClient(
                        id_client: item.idClient,
                        name_client: item.nameClient,
                        id_cellar: item.idCellar,
                        name_cellar: item.nameCellar,
                        start_time: item.startTime,
                        end_time: item.endTime,
                        hours: item.textTime,
                        id_status: item.idStatus,
                        name_status: item.nameStatus,
                        color_status: item.colorStatus,
                        id_client_route: item.idClientRoute);
                    if (item.idStatus == '')
                      _.showStore(item, index, currentStoreList);
                    else
                      _.ShowStoreDetailSup(item.idRoute.toString(), diaryClient,
                          _.refreshControllerSupervisorItemDetail, index, -1);
                  },
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
