import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../config/constant.dart';
import '../../config/responsive_app.dart';
import '../../config/string_app.dart';
import '../../modules/dashboard/dashboard_controller.dart';

class ViewAddressStore extends StatelessWidget {
  final String address;
  final String detail;
  final String icon;
  final String subdetail;

  const ViewAddressStore(
      {required this.address,
      this.detail = '',
      this.icon = '',
      this.subdetail = ''});
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return GetBuilder<DashboardController>(
      builder: (_) => Padding(
        padding: responsiveApp.edgeInsetsApp!.onlyMediumLeftRightEdgeInsets,
        child: Container(
          decoration: BoxDecoration(
              color: themeApp.colorWhite,
              borderRadius: BorderRadius.all(
                  Radius.circular(responsiveApp.containerRadius)),
              border: Border.all(
                color: themeApp.colorGenericIcon,
              )),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: responsiveApp.setHeight(50),
                          width: responsiveApp.setWidth(50),
                          child: SvgPicture.asset(
                              icon == '' ? Constant.ICON_MAP : icon)),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: responsiveApp
                            .edgeInsetsApp!.onlySmallLeftEdgeInsets,
                        child: Text(
                          address,
                          style: themeApp.textParagraph,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      detail != '' && subdetail == ''
                          ? Padding(
                              padding: responsiveApp
                                  .edgeInsetsApp!.onlySmallLeftEdgeInsets,
                              child: Text(
                                detail,
                                style: detail != textVacant
                                    ? themeApp.textNote
                                    : themeApp.textParagraphSecondaryOrange,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : detail != '' && subdetail != ''
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: responsiveApp.edgeInsetsApp!
                                            .onlySmallLeftEdgeInsets,
                                        child: Text(
                                          detail,
                                          style: detail != textVacant
                                              ? themeApp.textNote
                                              : themeApp
                                                  .textParagraphSecondaryOrange,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: responsiveApp.edgeInsetsApp!
                                          .onlySmallLeftEdgeInsets,
                                      child: Text(
                                        subdetail,
                                        style: themeApp.textNoteSecondaryBlue,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
