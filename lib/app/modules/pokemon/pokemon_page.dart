import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_heb/app/modules/pokemon/widgets/show_home.dart';
import '../../global_widgets/loading_info.dart';
import 'pokemon_controller.dart';
import 'widgets/custom_appbar.dart';

class PokemonPage extends StatelessWidget {
  DashboardController dashController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonController>(
      builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: CustomAppBar(),
            body: Container(child: _.loading ? LoadingInfo() : ShowHome()),
          )),
    );
  }
}
