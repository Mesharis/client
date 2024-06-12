import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/styles/styles.dart';
import '../controllers/appointment_detail_controller.dart';

class AppointmentDetailView extends GetView<AppointmentDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Consultation Detail'.tr,
            style: Styles.appBarTextStyle,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            Visibility(
              visible: false,
              child: PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "Reschedule Appointment".tr,
                    ),
                  ),
                ],
                onSelected: (int item) => {
                  if (item == 0)
                    {
                      //cancel appointment click
                      Get.defaultDialog(
                          title: 'Reschedule Appointment'.tr,
                          content: Text(
                            'You can only reschedule this appointment once, Are you sure want to reschedule this appointment'
                                .tr,
                            textAlign: TextAlign.center,
                          ),
                          onCancel: () {},
                          onConfirm: () {
                            Get.back();
                            //                    controller.rescheduleAppointment();
                          })
                    }
                },
              ),
            )
            //list if widget in appbar actions
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment With'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              controller.test(),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Schedule Detail'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x04000000),
                        blurRadius: 10,
                        spreadRadius: 10,
                        offset: Offset(0.0, 8.0),
                      )
                    ],
                    color: Colors.white),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          SizedBox(
                              height: 50, child: Text('Appointment Time'.tr)),
                          SizedBox(
                              height: 50,
                              child: Text(controller.selectedTimeslot.time)),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Duration'.tr)),
                          SizedBox(
                              height: 50,
                              child: Text(
                                  ': ${controller.selectedTimeslot.duration}${' Minute'.tr}')),
                        ]),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Text('Price'.tr),
                            ),
                            SizedBox(
                              height: 50,
                              child: Text(
                                currencySign + ': \$${controller.selectedTimeslot.price}${' (Paid)'.tr}',
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Text('Meet link'.tr),
                            ),
                            Column(
                              children:
                              controller.selectedTimeslot.link.map((e) {
                                return InkWell(
                                  onTap: () {
                                    if (e.isNotEmpty) {
                                      final Uri uri = Uri.parse(e);
                                      launchUrl(uri);
                                      Clipboard.setData(ClipboardData(text: e));
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: 'error '.tr,
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                    }
                                  },
                                  child: Text('Click here'.tr),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
