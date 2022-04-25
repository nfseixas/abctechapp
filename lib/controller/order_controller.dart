import 'dart:developer';

import 'package:abctechapp/model/assistance.dart';
import 'package:abctechapp/services/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final GeolocationServiceInterface _geolocationService;
  final selectedAssistances = <Assistance>[].obs;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();

  OrderController(this._geolocationService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  getLocation() {
    _geolocationService
        .getPosition()
        .then((value) => log(value.toJson().toString()));
  }

  finishStartOrder() {
    getLocation();
  }

  editServices() {
    Get.toNamed("/services", arguments: selectedAssistances);
  }
}