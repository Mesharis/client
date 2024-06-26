import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/styles/styles.dart';

Widget submitButton({required VoidCallback onTap, required String text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Styles.primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            color: Styles.secondaryColor,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}
