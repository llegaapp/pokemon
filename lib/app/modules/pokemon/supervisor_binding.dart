import 'package:get/get.dart';
import 'supervisor_controller.dart';

class SupervisorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SupervisorController());
  }
}
