import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class FeedsDialog extends StatefulWidget {
  final String productId;
  FeedsDialog({Key? key, required this.productId}) : super(key: key);

  @override
  _FeedsDialogState createState() => _FeedsDialogState();
}

class _FeedsDialogState extends State<FeedsDialog> {
  ProductController _productController = Get.find();
  CartController _cartController = Get.find();
  WishlistController _wishlistController = Get.find();
  Product _product = Product();
  bool isDark = ThemeService().isSavedDarkMode();

  @override
  void initState() {
    super.initState();
    _product = _productController.findByID(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Image.network('${_product.imageUrl}')),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Obx(() => Flexible(
                      child: _dialogContent(
                          index: 0,
                          fct: () {
                            _wishlistController.addFavoriteItems(
                                '${_product.id}',
                                _product.price!,
                                '${_product.title}',
                                '${_product.imageUrl}');
                          }))),
                  Obx(() => Flexible(
                      child: _dialogContent(
                          index: 1,
                          fct: () {
                            Get.back();
                            Get.toNamed(Routes.PRODUCTDETAIL,
                                arguments: [widget.productId]);
                          }))),
                  Obx(() => Flexible(
                      child: _dialogContent(
                          index: 2,
                          fct: _cartController.cartItems
                                  .containsKey(widget.productId)
                              ? () {
                                  Get.snackbar('Thông báo',
                                      'Món hàng đã có trong giỏ hàng',
                                      margin: const EdgeInsets.all(10),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor);
                                }
                              : () {
                                  _cartController.addProductToCart(
                                      '${_product.id}',
                                      _product.price!,
                                      '${_product.title}',
                                      '${_product.imageUrl}');
                                }))),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  splashColor: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.close, size: 28, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogContent({required int index, required Function fct}) {
    List<IconData> _dialogIcons = [
      _wishlistController.favItems.containsKey(widget.productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Feather.eye,
      Ionicons.md_cart,
    ];

    List<String> _dialogTexts = [
      _wishlistController.favItems.containsKey(widget.productId)
          ? 'In Wishlist'
          : 'Add to Wishlist',
      'View product',
      _cartController.cartItems.containsKey(widget.productId)
          ? 'In cart'
          : 'Add to cart'
    ];

    List<Color> _dialogColor = [
      _wishlistController.favItems.containsKey(widget.productId)
          ? Colors.red
          : (isDark ? Colors.white : Colors.black),
      isDark ? Colors.white : Colors.black,
      _cartController.cartItems.containsKey(widget.productId)
          ? AppColor.cartBadgeColor
          : (isDark ? Colors.white : Colors.black)
    ];
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            fct();
          },
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 10))
                        ]),
                    child: ClipOval(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(_dialogIcons[index],
                            color: _dialogColor[index], size: 25),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      _dialogTexts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? Theme.of(context).disabledColor
                            : AppColor.subTitle,
                      ),
                    ),
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
