import 'package:pokemon_heb/app/config/string_app.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../main.dart';
import '../config/constant.dart';

class PullToRefresh extends StatelessWidget {
  final Widget child;
  final RefreshController controller;
  final VoidCallback onRefresh;

  const PullToRefresh(
      {required this.child, required this.controller, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      footer: null,
      controller: controller,
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(
        height: 130.0,
        refreshingText: textUpdateInfo,
        refreshStyle: RefreshStyle.Follow,
        completeText: textCompleteInfo,
        completeIcon: Image.asset(Constant.ICON_CHECK_PNG),
        failedIcon: Image.asset(Constant.ICON_ALERTS_PNG),
        failedText: textFailedInfo,
        iconPos: IconPosition.top,
        refreshingIcon: Image.asset(Constant.ICON_RELOAD_PNG),
        textStyle: themeApp.textParagraph,
        completeDuration: Duration(seconds: 2),
        releaseText: '',
        idleText: '',
        idleIcon: Container(),
        releaseIcon: Container(),
      ),
      onRefresh: onRefresh,
      child: child,
    );
  }
}
