import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:pokemon_heb/app/global_widgets/app/card_anaquelero.dart';
import 'package:pokemon_heb/app/global_widgets/app/card_store.dart';
import 'package:pokemon_heb/app/models/diary/route_sup.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../pokemon_controller.dart';

class ViewRouteInfo extends StatelessWidget {
  final RouteSup item;
  final int index;
  const ViewRouteInfo(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cardRoute(_, responsiveApp),
                item.selected == true
                    ? CardAnaquelero(
                        id_base: item.id_anaquelero_base_team,
                        name_base: item.name_anaquelero_base_team,
                        id_back: item.id_anaquelero_backup_team,
                        name_back: item.name_anaquelero_backup_team,
                        onPressed: null,
                      )
                    : Container(),
                for (var i = 0; i < item.diary_client_list!.length; i++)
                  item.selected == true &&
                          item.diary_client_list![i].visible == true
                      ? CardStore(
                          index: index,
                          idStatus: item.diary_client_list![i].id_status,
                          nameStatus: item.diary_client_list![i].name_status,
                          comment: '',
                          name: item.diary_client_list![i].name_client,
                          timeShow: item.diary_client_list![i].start_time
                                  .toString()
                                  .substring(0, 5) +
                              ' - ' +
                              item.diary_client_list![i].end_time
                                  .toString()
                                  .substring(0, 5) +
                              ' (' +
                              item.diary_client_list![i].hours.toString() +
                              ' hrs' +
                              ')',
                          onPressed: () {
                            _.ShowStoreDetailSup(
                                item.id_route.toString(),
                                item.diary_client_list![i],
                                _.refreshControllerAgendaDetail,
                                i,
                                index);
                          },
                        )
                      : Container(),
                SizedBox(
                  height: 13,
                )
              ],
            ));
  }

  Widget cardRoute(PokemonController _, ResponsiveApp responsive) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 55.0,
          decoration: BoxDecoration(
            color: themeApp.colorGenericBox,
            borderRadius:
                BorderRadius.all(Radius.circular(responsive.containerRadius)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(Constant.ICON_ROUTE),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      item.route_show.toString(),
                      style: themeApp.textSubheader,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    width: 40,
                    child: GestureDetector(
                      onTap: () {
                        _.setButtonRoute(index);
                      },
                      child: item.selected == true
                          ? SvgPicture.asset(Constant.ICON_CHEVRON_UP)
                          : SvgPicture.asset(Constant.ICON_CHEVRON_DOWN),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
