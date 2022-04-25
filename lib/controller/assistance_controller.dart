import 'package:abctechapp/model/assistance.dart';
import 'package:abctechapp/services/assistance_service.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController with StateMixin<List<Assistance>> {

  late AssistanceServiceInterface _service;

  @override
  void onInit() {
    super.onInit();
    _service = Get.find<AssistanceServiceInterface>();
  }

  void getAssistanceList() {
    change([], status: RxStatus.loading());
    _service.getAssists().then((value) {
     // allAssists = value;
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }
} 