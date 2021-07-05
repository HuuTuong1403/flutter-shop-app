import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/feeds/feeds_product.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

import '../../../fake_data.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isDark = ThemeService().isSavedDarkMode();
  String productId = Get.arguments[0];
  CartController _cartController = Get.put(CartController());
  ProductController _productController = Get.put(ProductController());
  Product _detail = Product();

  @override
  void initState() {
    super.initState();
    _detail = _productController.findByID(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network('${_detail.imageUrl}'),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                '${_detail.title}',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'US \$ ${_detail.price}',
                              style: TextStyle(
                                  color: isDark
                                      ? Theme.of(context).disabledColor
                                      : AppColor.subTitle,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('${_detail.description}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 21,
                              color: isDark
                                  ? Theme.of(context).disabledColor
                                  : AppColor.subTitle,
                            )),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      _detailsProduct(
                          title: 'Brand: ', info: '${_detail.brand}'),
                      _detailsProduct(
                          title: 'Quantity: ',
                          info: '${_detail.quantity} Left'),
                      _detailsProduct(
                          title: 'Category: ',
                          info: '${_detail.productCategoryName}'),
                      _detailsProduct(
                          title: 'Popularity: ',
                          info:
                              _detail.isPopular! ? 'Popular' : 'Barely known'),
                      SizedBox(height: 15),
                      Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: isDark
                                        ? Theme.of(context).disabledColor
                                        : AppColor.subTitle),
                              ),
                            ),
                            const SizedBox(height: 70),
                            Divider(
                              thickness: 1,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  height: 330,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FeedsProduct(
                        product: products[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "${_detail.title}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: AppColor.favColor),
                  onPressed: () {
                    Get.toNamed(Routes.WISHLIST);
                  },
                ),
                IconButton(
                  icon: Icon(Ionicons.md_cart, color: Colors.purple),
                  onPressed: () {
                    Get.toNamed(Routes.CARTPAGE);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent.shade400,
                          shape: RoundedRectangleBorder(side: BorderSide.none)),
                      onPressed:
                          _cartController.cartItems.containsKey(_detail.id)
                              ? () {}
                              : () {
                                  _cartController.addProductToCart(
                                      '${_detail.id}',
                                      _detail.price!,
                                      '${_detail.title}',
                                      '${_detail.imageUrl}');
                                },
                      child: Obx(() => Text(
                            _cartController.cartItems.containsKey(_detail.id)
                                ? 'IN CART'
                                : "ADD TO CART",
                            style: TextStyle(
                                fontSize: 16,
                                color: isDark ? Colors.black : Colors.white),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary:
                              isDark ? Colors.white : Colors.grey.shade700,
                          primary: Theme.of(context).backgroundColor,
                          shape: RoundedRectangleBorder(side: BorderSide.none)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "BUY NOW",
                            style: TextStyle(
                                fontSize: 16,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.payment,
                              color: Colors.green.shade700, size: 19)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: isDark
                        ? Theme.of(context).disabledColor
                        : AppColor.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: AppColor.favColor,
                      onTap: () {},
                      child: Center(
                        child: Icon(
                          Ionicons.ios_heart_empty,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsProduct({required String title, required String info}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          Text(
            info,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? Theme.of(context).disabledColor
                    : AppColor.subTitle),
          ),
        ],
      ),
    );
  }
}
