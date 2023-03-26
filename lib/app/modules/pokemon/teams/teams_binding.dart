import 'package:get/get.dart';
import 'teams_controller.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TeamsController());
  }

}
