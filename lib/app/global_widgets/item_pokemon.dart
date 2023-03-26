import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/responsive_app.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pokemon_heb/app/config/theme_app.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/string_app.dart';
import '../config/utils.dart';
import '../models/pokemon.dart';
import 'button1.dart';

class ItemPokemon extends StatelessWidget {
  final int? index;
  final String? img;
  final String? name;
  final List<PokemonTypesList>? pokemonTypes;
  const ItemPokemon({
    this.index,
    this.img,
    this.name,
    this.pokemonTypes,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    bootstrapGridParameters(gutterSize: 0);
    const double kDefaultPadding = 20.0;

    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding - 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: themeApp.colorPrimary,
          borderRadius:
              BorderRadius.all(Radius.circular(responsiveApp.containerRadius)),
          boxShadow: [
            BoxShadow(
              color: themeApp.colorShadowContainer,
              blurRadius: 7,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: themeApp.colorWhite,
                          height: 100,
                          width: 100,
                          child: Image.network(img.toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: kDefaultPadding / 2,
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombreStr + name!,
                            style: themeApp.text18boldBlack600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            tipoStr,
                            style: themeApp.text14boldBlack400,
                          ),
                          Row(
                            children: <Widget>[
                              for (var _itemType in pokemonTypes!)
                                Padding(
                                    padding: EdgeInsets.only(right: 5, top: 10),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, bottom: 3, left: 5),
                                      color: Utils.pokemonColor(
                                          _itemType.name.toString()),
                                      child: Text(
                                        _itemType.name.toString(),
                                        style: themeApp.text12dWhite,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Button1(
                    label: agregarAmiEquipoStr,
                    style: themeApp.text12dWhite,
                    background: themeApp.colorPrimaryRed,
                    onPressed: () {},
                  ),
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
