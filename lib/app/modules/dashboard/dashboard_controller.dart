import 'dart:async';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_binding.dart';
import 'package:pokemon_heb/app/modules/dashboard/dashboard_profile_page.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../config/utils.dart';

class DashboardController extends GetxController {
  bool loading = false;
  late Map<String, dynamic> result;
  int indexInfo = 0;
  String dateCurrentStr = '';
  late Timer _timer;
  String _code = '';
  int indexPageBottomNavBar = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    solicitarPermisosPerifericos();
    startTimer();
  }

  solicitarPermisosPerifericos() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.camera,
    ].request();
  }

  showProfile() {
    Get.to(
      () => DashboardProfilePage(),
      binding: DashboardBinding(),
    );
  }



  void startTimer() {
    if (Utils.prefs.userGuest) return;
    const oneSec = const Duration(seconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (Utils.expiredSesssion()) {
          timer.cancel();
          Utils.setClearToken();
          Get.back();
          update();
        } else {
          update();
        }
      },
    );
  }

  setIndexPage(index) {
    indexPageBottomNavBar = index;
    update();
  }
}
