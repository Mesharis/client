// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../../utils/styles/styles.dart';
import '../../widgets/submit_button.dart';
import '../controllers/consultation_confirm_controller.dart';

class ConsultationConfirmView extends GetView<ConsultationConfirmController> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultation Confirmation'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Obx(() => Column(
                  children: [
                    Text(
                      'Has the consultation with the'.tr +
                          controller.timeSlot.doctor!.doctorName! +
                          'been completed?'.tr,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    submitButton(
                        onTap: () {
                          Get.defaultDialog(
                              title: 'Confirm'.tr,
                              middleText: 'Payment for Teacher'.tr +
                                  controller.timeSlot.doctor!.doctorName! +
                                  ' will be made if you confirm this transaction'
                                      .tr,
                              textCancel: 'Cancel'.tr,
                              textConfirm: 'Confirm'.tr,
                              onConfirm: () async {
                                await controller.confirmConsultation();
                              });
                        },
                        text: 'Yes & Give Review'.tr),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        controller.problemVisible.value =
                            !controller.problemVisible.value;
                      },
                      child: Text('No, there is a problem'.tr),
                    ),
                    Visibility(
                      visible: controller.problemVisible.value,
                      child: Container(
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormBuilderRadioGroup(
                                decoration:
                                    InputDecoration(labelText: 'Problem'.tr),
                                name: 'my_problem',
                                validator: FormBuilderValidators.required(),
                                options: [
                                  'Black screen, no consultation happened'.tr,
                                  'No sound'.tr,
                                  'Video call quality is very bad'.tr,
                                  'No consultation at all'.tr,
                                  'Other'.tr
                                ]
                                    .map((lang) =>
                                        FormBuilderFieldOption(value: lang))
                                    .toList(growable: false),
                              ),
                              FormBuilderTextField(
                                name: 'specify',
                                decoration: InputDecoration(
                                    labelText:
                                        'Please, explain the problem briefly'
                                            .tr),
                                validator: (val) {
                                  if (_formKey.currentState
                                              ?.fields['my_problem']?.value ==
                                          'Other'.tr &&
                                      (val == null || val.isEmpty)) {
                                    return 'Kindly explain your problem'.tr;
                                  }
                                  return null;
                                },
                                initialValue: '',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      controller.sendProblem('${'problem : ' +
                                          _formKey.currentState!
                                              .value['my_problem']} detail: ' +
                                          _formKey
                                              .currentState!.value['specify']);
                                    }
                                  },
                                  child: Text('Send'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
