import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/doctor_model.dart';
import '../../../models/order_model.dart';
import '../../../service/doctor_service.dart';
import '../views/widgets/doctor_tile.dart';

class AppointmentDetailController extends GetxController
    with StateMixin<OrderModel> {
  OrderModel selectedTimeslot = Get.arguments;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {}

  test() {
    return FutureBuilder<Doctor>(
        future: DoctorService().getDoctorDetail(selectedTimeslot.doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Doctor? order = snapshot.data;
            return DoctorTile(
              imgUrl: order!.doctorPicture!,
              name: selectedTimeslot.itemName,
              orderTime: DateFormat("yyyy-MM-dd HH:mm").parse(selectedTimeslot.time),
            );
          } else {
            return DoctorTile(
              imgUrl: selectedTimeslot.doctorId,
              name: selectedTimeslot.itemName,
              orderTime: DateTime.now(),
            );
          }
        });
  }
}
