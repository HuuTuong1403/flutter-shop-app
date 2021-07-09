import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/models/order.dart';
import 'package:shopappfirebase/src/screens/orders/controllers/order_controller.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';

class OrderFull extends StatefulWidget {
  final Order order;
  OrderFull({Key? key, required this.order}) : super(key: key);
  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  bool isDark = ThemeService().isSavedDarkMode();

  OrderController _orderController = Get.find();
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 180,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            color: Theme.of(context).backgroundColor),
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${widget.order.imageUrl}'),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '${widget.order.title}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              _globalMethods.showDialog(
                                  title: 'REMOVE ORDER!',
                                  subtitle: 'Do you want to delete order?',
                                  fct: () {
                                    _orderController
                                        .removeItem('${widget.order.orderId}');
                                  },
                                  context: context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(MyIcon.cross,
                                  color: Colors.red, size: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Price:",
                          style: TextStyle(),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "\$ ${widget.order.price}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: <Widget>[
                          Text("Quantity:"),
                          SizedBox(width: 5),
                          Text(
                            "x ${widget.order.quantity}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Flexible(child: Text("OrderId:")),
                          SizedBox(width: 5),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "${widget.order.orderId}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
