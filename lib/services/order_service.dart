import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:abctechapp/model/order.dart';
import 'package:abctechapp/model/order_created.dart';
import 'package:abctechapp/provider/order_provider.dart';

abstract class OrderServiceInterface {
  Future<OrderCreated> createOrder(Order order);
}

class OrderService extends GetxService implements OrderServiceInterface {
  final OrderProviderInterface _orderProvider;

  OrderService(this._orderProvider);

  @override
  Future<OrderCreated> createOrder(Order order) async {
    Response response = await _orderProvider.postOrder(order);
    try {
      if (response.hasError) {
        var messageError = "Erro na API";
        switch (response.statusCode) {
          case 400: 
            messageError = "Servidor não conseguiu processar sua solicitação";
            break;
          case 403: 
            messageError = "Você não tem acesso para criar uma ordem";
            break;
          case 408: 
            messageError = "Servidor demorou mais do que o esperado, tente novamente mais tarde";
            break;
          case 500:
            messageError = "Sistema indisponível, tente novamente mais tarde";
            break;
          case 503:
            messageError = "Servidor não pode processar essa solicitação no momento";
            break;
          default:
        }
        return Future.error(ErrorDescription(messageError));
      }
      return Future.sync(() => OrderCreated(success: true, message: ""));
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription("Erro não esperado, tente mais tarde"));
    }
  }
}