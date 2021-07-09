import 'package:get/get.dart';
import 'package:shopappfirebase/src/services/order_service.dart';

class OrderController extends GetxController {
  OrderService _orderService = OrderService();
  List<dynamic> orders = [].obs;

  Future<List<dynamic>> getOrder() async {
    orders = await _orderService.fetchOrders();
    return orders;
  }

  void removeItem(String orderId) {
    _orderService.deleteOrders(orderId: orderId);
    orders.removeWhere((item) => item.orderId == orderId);
    update();
  }
}
