import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/constant.dart';
import '../../../config/string_app.dart';
import '../../../global_widgets/button1.dart';
import '../../../global_widgets/no_results.dart';
import '../../../global_widgets/no_tenderos.dart';
import 'local_widgets/show_list_teams.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import '../../../config/responsive_app.dart';
import 'package:pokemon_heb/app/global_widgets/input2.dart';
import 'package:pokemon_heb/app/global_widgets/dropdown2.dart';
import '../pokemon_controller.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bootstrapGridParameters(gutterSize: 10);
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<PokemonController>(
      builder: (_) => Container(
        child: _.loading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _.totalItemsTeams > 0 &&
                          _.currentTeamList == Constant.TEAMS_TODAY_VALUE
                      ? Container(
                          color: themeApp.colorGenericBox,
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 5, bottom: 5),
                          child: BootstrapContainer(fluid: true, children: [
                            BootstrapRow(
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-6',
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: -1,
                                        groupValue: _.teamRadioVal,
                                        onChanged: (value) async {
                                          _.changeTeamRadioVal(value);
                                        },
                                        activeColor: themeApp.colorPrimaryBlue,
                                      ),
                                      Text(
                                        asistenciaStr,
                                        style: themeApp.text16400Black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _.itemsTeams.attendance_count
                                              .toString(),
                                          style: themeApp.text16400Blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BootstrapCol(
                                    sizes: 'col-6',
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: 1,
                                          groupValue: _.teamRadioVal,
                                          onChanged: (value) async {
                                            _.changeTeamRadioVal(value);
                                          },
                                          activeColor:
                                              themeApp.colorPrimaryBlue,
                                        ),
                                        Text(
                                          inasistenciaStr,
                                          overflow: TextOverflow.ellipsis,
                                          style: themeApp.text16400Black,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text( overflow: TextOverflow.ellipsis,
                                            _.itemsTeams.absence_count
                                                .toString(),
                                            style: themeApp.text16400Blue,
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ]),
                        )
                      : Container(),
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
                                controller: _.searchTeamController,
                                label: buscarStr,
                                onChange: (v) {
                                  _.filteritemsTeams();
                                },
                              ),
                            ),
                            BootstrapCol(
                                sizes: 'col-4',
                                child: Select(
                                  value: _.routeTeamsSelected,
                                  label: rutaStr,
                                  dataList: _.routesTeams,
                                  onChange: (v) async {
                                    _.routeTeamsSelected = v;
                                    _.filteritemsTeams();
                                  },
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Flexible(
                    child: _.totalItemsTeams == 0
                        ? NoTenderos()
                        : _.totalItemsFiltredTeams == 0
                            ? NoResults()
                            : ShowListTeams(),
                    // child: NoTenderos(),
                  ),
                  _.totalItemsTeams > 0 &&
                          _.currentTeamList == Constant.TEAMS_TODAY_VALUE &&
                          _.itemsTeams.is_day_closed == false
                      ? Button1(
                          label: confirmarAsistenciaStr,
                          style: themeApp.text18boldWhite,
                          background: themeApp.colorPrimaryBlue,
                          onPressed: () {
                            _.stores_openBottomSheetConfirmAttendanceTeams(
                                context);
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
      ),
    );
  }
}
