import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';

class PopularProducts extends StatefulWidget {
  final int index;
  final Product product;
  PopularProducts({Key? key, required this.index, required this.product})
      : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  CartController _cartController = Get.put(CartController());
  WishlistController _wishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            onTap: () {
              Get.toNamed(Routes.PRODUCTDETAIL, arguments: [widget.product.id]);
            },
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${widget.product.imageUrl}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Obx(() => Icon(
                            Entypo.star,
                            color: _wishlistController.favItems
                                    .containsKey(widget.product.id)
                                ? Colors.red
                                : Colors.grey.shade800,
                          )),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Theme.of(context).backgroundColor,
                        child: Text("\$ ${widget.product.price}",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${widget.product.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              '${widget.product.description}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() => IconButton(
                                  icon: _cartController.cartItems
                                          .containsKey(widget.product.id)
                                      ? Icon(Icons.check,
                                          size: 25, color: Colors.black)
                                      : Icon(MaterialCommunityIcons.cart_plus,
                                          size: 25, color: Colors.black),
                                  onPressed: _cartController.cartItems
                                          .containsKey(widget.product.id)
                                      ? () {
                                          Get.snackbar('Thông báo',
                                              'Món hàng đã có trong giỏ hàng',
                                              margin: const EdgeInsets.all(10),
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor);
                                        }
                                      : () {
                                          _cartController.addProductToCart(
                                              '${widget.product.id}',
                                              widget.product.price!,
                                              '${widget.product.title}',
                                              '${widget.product.imageUrl}');
                                        },
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
