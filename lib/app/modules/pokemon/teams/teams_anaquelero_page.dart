import 'package:pokemon_heb/app/modules/pokemon/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/responsive_app.dart';
import '../supervisor_controller.dart';
import 'local_widgets/card_route_teams_anaquelero.dart';
import 'local_widgets/header_teams_anaquelero.dart';
import 'local_widgets/show_detail_teams_anaquelero.dart';

class TeamsAnaqueleroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<SupervisorController>(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _.teamCurrent.details!.length > 0
                    ? Padding(
                        padding:
                            responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                        child: Align(
                          alignment: Alignment.center,
                          child: HeaderTeamsAnaquelero(),
                        ),
                      )
                    : Container(),
                _.teamCurrent.details!.length > 0
                    ? Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
                        child: Align(
                          alignment: Alignment.center,
                          child: CardRouteTeamsAnaquelero(),
                        ),
                      )
                    : Container(),
                _.teamCurrent.details!.length == 0
                    ? Flexible(child: Container())
                    : Flexible(
                        child: ShowDetailTeamsAnaquelero(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
