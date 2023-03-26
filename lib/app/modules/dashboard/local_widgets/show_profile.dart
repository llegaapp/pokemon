import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../config/responsive_app.dart';
import '../dashboard_controller.dart';
import 'view_header_profile.dart';

class ShowProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<DashboardController>(
      builder: (_) => Container(
        child: _.loading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Padding(
                      padding: responsiveApp.edgeInsetsApp!.allMediumEdgeInsets,
                      child: Align(
                        alignment: Alignment.center,
                        child: ViewHeaderProfile(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: responsiveApp
                                .edgeInsetsApp!.allMediumEdgeInsets,
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      Utils.prefs.manager_type,
                                      style: themeApp.textParagraph,
                                    ),
                                    Text(
                                      Utils.prefs.manager_name,
                                      style: themeApp.textSubheader,
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: responsiveApp
                                .edgeInsetsApp!.allMediumEdgeInsets,
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      activeSinceStr,
                                      style: themeApp.textParagraph,
                                    ),
                                    Text(
                                      Utils.prefs.active_since,
                                      style: themeApp.textSubheader,
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 40.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: responsiveApp
                          .edgeInsetsApp!.onlyLargeLeftRightEdgeInsets,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(child: Text('ddd'),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  )
                ],
              ),
      ),
    );
  }
}
