import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../config/constant.dart';
import '../../../config/responsive_app.dart';
import '../../../config/utils.dart';
import '../dashboard_controller.dart';

class ViewHeaderProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<DashboardController>(
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: themeApp.colorWhite,
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: SvgPicture.asset(Constant.ICON_PROFILE),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Utils.prefs.user_name,
                        style: themeApp.textSubheader,
                      ),
                      Text(
                        Utils.prefs.profile,
                        style: themeApp.textParagraph,
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
