import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/models/cart.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class CartFull extends StatefulWidget {
  final Cart cart;
  final String productId;
  final int index;
  CartFull(
      {Key? key,
      required this.cart,
      required this.productId,
      required this.index})
      : super(key: key);
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  bool isDark = ThemeService().isSavedDarkMode();
  double subtotal = 0.0;
  CartController _cartController = Get.put(CartController());
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  void initState() {
    super.initState();
    subtotal = widget.cart.price * widget.cart.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PRODUCTDETAIL, arguments: [widget.productId]);
      },
      child: Container(
        height: 150,
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
                  image: NetworkImage('${widget.cart.imageUrl}'),
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
                            "${widget.cart.title}",
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
                                  title: 'Remove item!',
                                  subtitle:
                                      'Product will removed from this cart. Do you want to remove this item?',
                                  fct: () {
                                    _cartController
                                        .removeItem(widget.productId);
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
                          "${widget.cart.price}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Sub total:",
                          style: TextStyle(),
                        ),
                        SizedBox(width: 5),
                        Obx(() {
                          double total = _cartController.cartItems.values
                                  .toList()[widget.index]
                                  .quantity *
                              _cartController.cartItems.values
                                  .toList()[widget.index]
                                  .price;
                          return Text(
                            "\$ ${total.toStringAsFixed(3)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.brown.shade900
                                  : Theme.of(context).accentColor,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Ships Free",
                          style: TextStyle(
                            color: isDark
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: Obx(() => InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: _cartController.cartItems.values
                                            .toList()[widget.index]
                                            .quantity ==
                                        1
                                    ? null
                                    : () {
                                        _cartController.reduceProductInCart(
                                            '${widget.productId}',
                                            widget.cart.price,
                                            '${widget.cart.title}',
                                            '${widget.cart.imageUrl}');
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(MyIcon.minus,
                                      color: _cartController.cartItems.values
                                                  .toList()[widget.index]
                                                  .quantity <
                                              2
                                          ? Colors.grey
                                          : Colors.red,
                                      size: 22),
                                ),
                              )),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              AppColor.gradientStart,
                              AppColor.gradientEnd
                            ], stops: [
                              0.0,
                              0.7
                            ])),
                            child: Obx(() => Text(
                                  '${_cartController.cartItems.values.toList()[widget.index].quantity}',
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              _cartController.addProductToCart(
                                  '${widget.productId}',
                                  widget.cart.price,
                                  '${widget.cart.title}',
                                  '${widget.cart.imageUrl}');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(MyIcon.plus,
                                  color: Colors.green, size: 22),
                            ),
                          ),
                        ),
                      ],
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
