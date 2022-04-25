import 'package:abctechapp/controller/assistance_controller.dart';
import 'package:abctechapp/model/assistance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AssistanceController> {
  const HomePage({Key? key}) : super(key: key);

  Widget renderAssists(List<Assistance> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(list[index].name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assistências & Serviços")),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Expanded(
                      child: Text("Os serviços disponíveis são:",
                          textAlign: TextAlign.left))
                ],
              ),
              controller.obx((state) => renderAssists(state ?? []),
                  onLoading: const Text("Carregando"),
                  onEmpty: const Text("Nenhum"),
                  onError: (error) => Text(error.toString()))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => controller.getAssistanceList(),
      child: const Icon(Icons.refresh)));
  }
}