import 'package:abctechapp/controller/order_controller.dart';
import 'package:abctechapp/model/assistance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  Widget renderAssists(List<Assistance> assists) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assists.length,
        itemBuilder: (context, index) =>
            ListTile(
              title: Text(assists[index].name),
              leading: const Icon(Icons.room_service),
              dense: true,
            )
    );
  }

  Widget renderFromScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Container(
          decoration: new BoxDecoration(
            color: controller.screenState.value != OrderState.creating ? const Color(0xFFEEEEEE).withOpacity(0.9) : const Color(0xFFEEEEEE).withOpacity(0.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: const [
                Expanded(
                    child: Text(
                  'Preencha o fomulário de ordem de serviço',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ))
              ]),
              Obx(() {
                var enabled = controller.screenState.value == OrderState.creating;
                return TextFormField(
                  controller: controller.operatorIdController,
                  enabled: enabled,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(
                        labelText: "Matrícula do prestador",
                        icon: Icon(Icons.person),
                      ),
                );
              }),
              Row(children: [
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 25),
                        child: Text(
                          'Selecione os serviços a serem prestados',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ))),
                Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.blueAccent),
                    child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () => controller.editServices()),
                    width: 40,
                    height: 40)
              ]),
              Obx(
                () => renderAssists(controller.selectedAssistances),
              ),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton.icon(
                      icon: controller.screenState.value == OrderState.creating ? Icon(
                        Icons.start,
                        color: Colors.white,
                        size: 24.0,
                      ) : Icon(
                        Icons.upload,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        primary: controller.screenState.value == OrderState.creating ? Colors.purple : Colors.red,
                        padding: const EdgeInsets.all(10.0),
                      ),
                      label: Obx((() {
                        if (controller.screenState.value == OrderState.creating) {
                          return const Text("Iniciar o serviço");
                        } else {
                          return const Text("Finalizar o serviço");
                        }
                      })),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.finishStartOrder();
                      },
                    )
                  )
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ordem de serviço"),
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(10.0),
            child: controller.obx((state) => renderFromScreen(context),
                onLoading: const Center(child: CircularProgressIndicator()),
                onError: (error) => Text(error.toString()))));
  }
}