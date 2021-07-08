import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/screens/cart/cart_empty.dart';
import 'package:shopappfirebase/src/screens/cart/cart_full.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController _cartController = Get.find();
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _cartController.cartItems.isEmpty
          ? Scaffold(body: CartEmpty())
          : Scaffold(
              appBar: AppBar(
                title: Text("Cart (${_cartController.cartItems.length})",
                    style: Theme.of(context).appBarTheme.textTheme!.headline1),
                actions: [
                  IconButton(
                    onPressed: () {
                      _globalMethods.showDialog(
                          title: 'Clear item!',
                          subtitle:
                              'Product will be clear all in this cart. Do you want to do?',
                          fct: () {
                            _cartController.clearCart();
                          },
                          context: context);
                    },
                    icon: Icon(Feather.trash),
                  ),
                ],
              ),
              body: Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                  itemCount: _cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartFull(
                      cart: _cartController.cartItems.values.toList()[index],
                      productId: _cartController.cartItems.keys.toList()[index],
                      index: index,
                    );
                  },
                ),
              ),
              bottomSheet: checkoutSection(),
            ),
    );
  }

  Widget checkoutSection() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [AppColor.gradientStart, AppColor.gradientEnd],
                  stops: [0.0, 0.7],
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                onPressed: () {},
                child: Text(
                  "Checkout",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            "Total: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Obx(() => Text(
                "US \$${_cartController.totalAmount.toStringAsFixed(3)}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
