import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../global_widgets/tooltipShape.dart';
import '../supervisor_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  DashboardController dash = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      builder: (_) => AppBar(
        backgroundColor: themeApp.colorPrimary,
        elevation: 0,
        title: Text(
          intercambioPokemonStg,
          style: themeApp.textHeader,
        ),
        actions: [
          _.indexPage == 1 && _.subIndexPage == 0
              ? PopupMenuButton(
                  padding: EdgeInsets.all(10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    child: Icon(
                      Icons.more_vert_rounded,
                    ),
                  ),
                  onSelected: (value) {
                    _.setFilterStatus(value.toString());
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: Constant.ID_STATUS_ALL,
                        child: itemPopUp(Constant.ICON_ITEM, Constant.NAME__ALL,
                            Utils.prefs.count_states_all),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_TERMINADA,
                        child: itemPopUp(
                            Constant.ICON_CHECK,
                            Constant.NAME_STATUS_TERMINADA,
                            Utils.prefs.count_states_finished),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_ENCURSO,
                        child: itemPopUp(
                            Constant.ICON_PROGRESS,
                            Constant.NAME_STATUS_ENCURSO,
                            Utils.prefs.count_states_in_progress),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_PENDIENTE,
                        child: itemPopUp(
                            Constant.ICON_BLOCK,
                            Constant.NAME_STATUS_PENDIENTE,
                            Utils.prefs.count_states_pending),
                      ),
                    ];
                  },
                )
              : _.indexPage == 0 && _.subIndexPage == 0
                  ? PopupMenuButton(
                      offset: Offset(0, 45),
                      shape: const TooltipShape(),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(20),
                        child: Icon(
                          Icons.more_vert_rounded,
                        ),
                      ),
                      onSelected: (value) {
                        _.setFilterSores(value.toString());
                      },
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: Constant.ALL_STORES_VALUE,
                          child: itemPopUp2(
                              Constant.ICON_ITEM2, Constant.ALL_STORES,
                              countItems: _.itemsStoresAll.length),
                        ),
                        PopupMenuItem<String>(
                          value: Constant.AGENDS_TODAY_VALUE,
                          child: itemPopUp2(
                              Constant.ICON_ITEM2, Constant.AGENDS_TODAY,
                              countItems: _.itemsStoresToday.length),
                        ),
                      ],
                    )
                  : _.indexPage == 2 && _.subIndexPage == 0
                      ? PopupMenuButton(
                          offset: Offset(0, 45),
                          shape: const TooltipShape(),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(20),
                            child: Icon(
                              Icons.more_vert_rounded,
                            ),
                          ),
                          onSelected: (value) {
                            _.setFilterTeams(value.toString());
                          },
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: Constant.ALL_TEAMS_VALUE,
                              child: itemPopUp2(
                                  Constant.ICON_ITEM2, Constant.ALL_TEAMS,
                                  countItems: _.itemsTeamsAll.all == null
                                      ? 0
                                      : _.itemsTeamsAll.all!.length),
                            ),
                            PopupMenuItem<String>(
                              value: Constant.TEAMS_TODAY_VALUE,
                              child: itemPopUp2(
                                  Constant.ICON_ITEM2, Constant.TEAMS_TODAY,
                                  countItems: _.totalItemsTeams),
                            ),
                          ],
                        )
                      : Container(),
        ],
      ),
    );
  }

  Widget itemPopUp(String txtIcon, txtTitle, String txtCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(txtIcon),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                txtTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: themeApp.colorPrimaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              txtCount,
              style: themeApp.textParagraph,
            ),
          ],
        ),
        Divider()
      ],
    );
  }

  Widget itemPopUp2(String txtIcon, txtTitle, {int countItems = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(txtIcon),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                txtTitle,
                style: TextStyle(
                    color: themeApp.colorPrimaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              countItems.toString(),
              style: themeApp.textParagraph,
            ),
          ],
        ),
        Divider()
      ],
    );
  }


}
