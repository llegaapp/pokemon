import 'package:pokemon_heb/app/config/constant.dart';
import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:pokemon_heb/app/config/utils.dart';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_controller.dart';
import 'package:pokemon_heb/app/modules/pokemon/supervisor_controller.dart';
import 'package:pokemon_heb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String group;
  int? pageIndex;
  GetxController? controller;

  CustomAppBar({required this.group, this.pageIndex = -1, this.controller});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) => AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.account_circle_outlined),
                onPressed: () {
                  _.showProfile();
                },
              ),
            ),
            SizedBox(width: 10),
            Utils.withoutSending
                ? Expanded(child: SvgPicture.asset(Constant.ICON_TRANSFER))
                : Container(),
          ],
        ),
        title: Text(
          textSchedule,
          style: themeApp.textButtonlink,
        ),
        actions: [
          group == Constant.PROFILE_SUP && pageIndex == 1
              ? PopupMenuButton(
                  padding: EdgeInsets.all(10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    child: Icon(
                      Icons.more_vert_rounded,
                    ),
                  ),
                  onSelected: (value) {
                    (controller as SupervisorController)
                        .setFilterStatus(value.toString());
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: Constant.ID_STATUS_ALL,
                        child:
                            itemPopUp(Constant.ICON_ITEM, Constant.NAME__ALL),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_TERMINADA,
                        child: itemPopUp(Constant.ICON_CHECK,
                            Constant.NAME_STATUS_TERMINADA),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_ENCURSO,
                        child: itemPopUp(Constant.ICON_PROGRESS,
                            Constant.NAME_STATUS_ENCURSO),
                      ),
                      PopupMenuItem(
                        value: Constant.ID_STATUS_PENDIENTE,
                        child: itemPopUp(Constant.ICON_BLOCK,
                            Constant.NAME_STATUS_PENDIENTE),
                      ),
                    ];
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Widget itemPopUp(String txtIcon, txtTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              child: SvgPicture.asset(txtIcon),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              txtTitle,
              style: TextStyle(
                  color: themeApp.colorPrimaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
