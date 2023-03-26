import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../config/string_app.dart';
import '../../../config/utils.dart';
import '../../../global_widgets/tooltipShape.dart';
import '../pokemon_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  DashboardController dash = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => AppBar(
        backgroundColor: themeApp.colorPrimary,
        elevation: 0,
        title: Text(
          intercambioPokemonStr,
          style: themeApp.textHeader,
        ),
        actions: [
          IconButton(
            icon: Image.asset(Constant.ICON_POKE_BALL),
            onPressed: () {
              _.openPokemonList(context);
            },
          ),
        ],
      ),
    );
  }
}
