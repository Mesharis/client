import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/doctor_model.dart';
import '../../../models/order_model.dart';
import '../../../service/doctor_service.dart';
import '../../../service/timeslot_service.dart';
import '../../../service/user_service.dart';

class AppointmentController extends GetxController
    with StateMixin<List<OrderModel>> {
  final count = 0.obs;
  final TimeSlotService _appointmentService = Get.find();
  UserService userService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    getListAppointment();
  }

  @override
  void onClose() {}

  Future<void> getListAppointment() async {
    try {
      var listOrderedTimeslot = await _appointmentService
          .getListAppointment(userService.currentUser!);
      if (await listOrderedTimeslot.isEmpty) {
        return change([], status: RxStatus.empty());
      }
      change(listOrderedTimeslot, status: RxStatus.success());
    } catch (err) {
      change([], status: RxStatus.error(err.toString()));
    }
  }

  test(String doctorId) {
    return FutureBuilder<Doctor>(
        future: DoctorService().getDoctorDetail(doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Doctor? order = snapshot.data;
            return CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(order!.doctorPicture!
              ),
            );
          } else {
            return CircleAvatar(
              backgroundImage: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/talaamapp-4a4e9.appspot.com/o/uploads%2Farabic-language.png?alt=media&token=671ef7f8-70df-43f0-8a32-ad6888e57b25"
              ),
            );
          }
        });
  }
}
