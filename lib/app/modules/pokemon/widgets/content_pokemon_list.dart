import 'package:pokemon_heb/app/global_widgets/item_pokemon.dart';
import 'package:pokemon_heb/app/modules/pokemon/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/pokemon.dart';

class ContentPokemonList extends StatelessWidget {
  final PokemonListModel item;
  final int index;
  final String currentStoreList;
  const ContentPokemonList(this.item, this.index, this.currentStoreList);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemPokemon(
                    index: index,
                    img: item.img,
                    name: item.name,
                    onPressed: item.selected == false ? _.addPokemon(item) : null,
                    selected: item.selected,
                    pokemonTypes: item.detail?.pokemonTypes),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
