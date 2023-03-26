import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/app/global_widgets/button2.dart';
import 'package:pokemon_heb/app/global_widgets/loading_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../config/constant.dart';
import '../../../config/responsive_app.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/app/status_store.dart';
import '../../../global_widgets/app/view_address_store.dart';
import '../../../global_widgets/header_store.dart';
import '../supervisor_controller.dart';
import 'box_activity_store.dart';

class ContentClientDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<SupervisorController>(
      builder: (_) => _.loading
          ? LoadingInfo()
          : ListView(children: [
              Padding(
                padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                child: Align(
                  alignment: Alignment.center,
                  child: HeaderStore(
                    title: _.itemClientDetailSup!.client_name.toString(),
                    subtitle: _.itemClientDetailSup!.client_show.toString() +
                        '\n' +
                        _.itemClientDetailSup!.cellar_show.toString(),
                  ),
                ),
              ),
              Padding(
                padding:
                    responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
                child: Align(
                  alignment: Alignment.center,
                  child: StatusStore(
                    idstatus: _.itemClientDetailSup!.status_id.toString(),
                    hours: _.itemClientDetailSup!.time_show.toString(),
                    activity: _.itemClientDetailSup!.diff_time_show.toString(),
                    notification: Utils.withoutSending,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              BoxActivityStore(),
              SizedBox(
                height: 15,
              ),
              ViewAddressStore(
                  address: _.itemClientDetailSup!.client_address.toString()),
              SizedBox(
                height: 10,
              ),
              ViewAddressStore(
                address: _.itemClientDetailSup!.route_show_anaq.toString(),
                detail: _.itemClientDetailSup!.anaquelero.toString(),
                subdetail: _.itemClientDetailSup!.id_team_type.toString() ==
                        Constant.ID_TEAM_TYPE_REEMPLAZO
                    ? _.itemClientDetailSup!.team_type.toString()
                    : '',
                icon: Constant.ICON_ROUTE,
              ),
              Padding(
                padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (_.itemsClientDetailOtherRoute.length > 0)
                          _.getClientOtherRoute(context);
                      },
                      child: Text(
                        textOtrasRutas,
                        style: _.itemsClientDetailOtherRoute.length > 0
                            ? themeApp.textCTAButtonlink
                            : themeApp.textDisabled,
                      ),
                    )),
              ),
              _.visibleButton
                  ? Container(
                      padding: responsiveApp
                          .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button2(
                            title: gestionarTiendaStr,
                            color: themeApp.colorPrimaryBlue,
                            onPressed: () {
                              _.activeSwitch = false;
                              _.anaqueleroUpdate = false;
                              _.updateValueSwitch();
                              _.openBottomSheetManageClient(context);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ]),
    );
  }
}
