import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../models/order_model.dart';
import '../../../service/timeslot_service.dart';
import '../../../utils/styles/styles.dart';
import '../../widgets/empty_list.dart';
import '../controllers/appointment_controller.dart';

class AppointmentView extends GetView<AppointmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getListAppointment();
        },
        child: Container(
          height: Get.height,
          child: FutureBuilder<List<OrderModel>>(
              future: TimeSlotService().getListAppointment(controller.userService.currentUser!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<OrderModel>? order = snapshot.data;
                  order!.sort((a, b) {
                    return b.time
                        .compareTo(a.time);
                  });
                  if (order.isEmpty){
                    return Center(
                      child: EmptyList(msg: 'you don\'t have an appointment yet'.tr),
                    );
                  }
                  return ListView.builder(
                    itemCount: order.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.toNamed('/appointment-detail',
                                arguments: order[index]);
                          },
                          leading: controller.test(order[index].doctorId),
                          title: Text('Appointment with '.tr +
                              order[index].itemName),
                          subtitle: Text(
                            'at '.tr +order[index].time,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Container());
                }
              }),
        ),
      ),
    );
  }
}
