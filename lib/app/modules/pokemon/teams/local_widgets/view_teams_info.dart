import 'package:pokemon_heb/app/global_widgets/item_team.dart';
import 'package:pokemon_heb/app/models/teams/team_list_by_supervisor.dart';
import 'package:pokemon_heb/app/modules/pokemon/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/string_app.dart';

class ViewTeamsInfo extends StatelessWidget {
  final Team item;
  final int index;
  final int teamRadioVal;
  const ViewTeamsInfo(this.item, this.index, this.teamRadioVal);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemTeam(
                  index: index,
                  teamRadioVal: teamRadioVal,
                  idAnaquelero: item.id_anaquelero,
                  nameAnaquelero: item.name_anaquelero,
                  routeSow: item.route_show,
                  onPressed: () {
                    _.showAnaqueleroPage(item, index);
                  },
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
