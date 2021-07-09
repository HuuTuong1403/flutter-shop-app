import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/screens/orders/controllers/order_controller.dart';
import 'package:shopappfirebase/src/screens/orders/widgets/order_empty.dart';
import 'package:shopappfirebase/src/screens/orders/widgets/order_full.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderController _orderController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _orderController.getOrder(),
        builder: (context, snapshot) {
          return GetBuilder<OrderController>(
              init: OrderController(),
              initState: (_) {},
              builder: (_) {
                return _orderController.orders.isEmpty
                    ? Scaffold(body: OrderEmpty())
                    : Scaffold(
                        appBar: AppBar(
                          title: Text(
                              "Orders (${_orderController.orders.length})",
                              style: Theme.of(context)
                                  .appBarTheme
                                  .textTheme!
                                  .headline1),
                          actions: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(MyIcon.trash),
                            ),
                          ],
                        ),
                        body: Container(
                          margin: const EdgeInsets.only(bottom: 60),
                          child: ListView.builder(
                            itemCount: _orderController.orders.length,
                            itemBuilder: (context, index) {
                              return OrderFull(
                                order: _orderController.orders[index],
                              );
                            },
                          ),
                        ),
                      );
              });
        });
  }
}
