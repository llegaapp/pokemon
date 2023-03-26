import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double kDefaultPadding = 20.0;
    Color select = themeApp.colorNeutralBlack ;
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.STORES);
              },
              child: SvgPicture.asset(Constant.ICON_STORE_NAVBAR, color: select,)),
          GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.DASHBOARD);
              },
              child: SvgPicture.asset(Constant.ICON_TASKTS , color: select)),
          GestureDetector(
              onTap: () {}, child: SvgPicture.asset(Constant.ICON_USER_GROUP, color: select)),
        ],
      ),
    );
  }
}
