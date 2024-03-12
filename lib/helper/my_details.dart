import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs{

  static success({required String msg}) {
     Get.snackbar('success', msg, colorText: Colors.white,
     backgroundColor: Colors.green.withOpacity(.9));
  }

  static error({required String msg}) {
     Get.snackbar('error', msg, colorText: Colors.white,
     backgroundColor: Colors.redAccent.withOpacity(.9));
  }
  
  static info({required String msg}) {
    Get.snackbar('info', msg, colorText: Colors.white);
  }
  }