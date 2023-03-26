import 'package:pokemon_heb/app/global_widgets/item_pokemon.dart';
import 'package:pokemon_heb/app/models/stores/clients_list_by_route_supervisor.dart';
import 'package:pokemon_heb/app/modules/pokemon/pokemon_controller.dart';
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
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemPokemon(
                  index: index,
                  img: item.idRoute,
                  name: item.nameClient,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
