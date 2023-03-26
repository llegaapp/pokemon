import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/responsive_app.dart';
import '../stores/stores_page.dart';
import '../teams/teams_page.dart';
import '../diary/list_route_page.dart';
import '../group/group_page.dart';
import '../pokemon_controller.dart';

class ShowHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => Container(
        child: ListRoutePage(),
      ),
    );
  }
}
