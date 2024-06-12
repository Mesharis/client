import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/time_slot_model.dart';
import '../../appointment/controllers/appointment_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class PaymentSuccessController extends GetxController with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late AnimationController animController;
  TimeSlot timeSlot = Get.arguments;
  var price = 0.obs;
  RxString link = ''.obs;
  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    price.value = timeSlot.price!;
    link.value = timeSlot.link!;
  }

  @override
  void onClose() {
    animController.dispose();
  }

  void increment() => count.value++;

  void goHome() {
    Get.offAllNamed('dashboard');
    Get.find<AppointmentController>().getListAppointment();
  }
  void appointment() {
    Get.toNamed('/dashboard');
    Get.find<DashboardController>().selectedIndex.value = 2;
    Get.find<AppointmentController>().getListAppointment();
  }
}
