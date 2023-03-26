import 'package:pokemon_heb/app/modules/pokemon/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view_teams_info.dart';

class ShowListTeams extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
        builder: (_) => Scrollbar(
              thickness: 8,
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _.teamRadioVal == -1
                      ? _.itemsTeams.attendance_list!.length == null
                          ? 0
                          : _.itemsTeams.attendance_list!.length
                      : _.itemsTeams.absence_list == null
                          ? 0
                          : _.itemsTeams.absence_list!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return _.teamRadioVal == -1
                        ? ViewTeamsInfo(_.itemsTeams.attendance_list![index],
                            index, _.teamRadioVal)
                        : ViewTeamsInfo(_.itemsTeams.absence_list![index],
                            index, _.teamRadioVal);
                  }),
            ));
  }
}
