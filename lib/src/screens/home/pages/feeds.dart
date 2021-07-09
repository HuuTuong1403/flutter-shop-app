import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/feeds/feeds_product.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';

class FeedsPage extends StatefulWidget {
  final String? category;
  FeedsPage({Key? key, this.category}) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  bool isDark = ThemeService().isSavedDarkMode();
  ProductController _productController = Get.put(ProductController());
  CartController _cartController = Get.find();
  WishlistController _wishlistController = Get.find();
  String categoryName = '';
  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();
    _productController.getProduct();
    if (widget.category == '') {
      _list = _productController.products;
    } else {
      categoryName = Get.arguments[0];
      if (categoryName == '')
        _list = _productController.products;
      else if (categoryName == 'popular')
        _list = _productController.getPopularItems();
      else
        _list = _productController.categoryItems(categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Feeds",
            style: Theme.of(context).appBarTheme.textTheme!.headline1),
        actions: [
          Obx(() => IconButton(
                onPressed: () {},
                icon: Badge(
                  badgeColor: AppColor.favBadgeColor,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  badgeContent: Text(
                      _wishlistController.favItems.length.toString(),
                      style: TextStyle(color: Colors.white)),
                  child:
                      Icon(Icons.favorite_border_outlined, color: Colors.red),
                ),
              )),
          Obx(() => IconButton(
                onPressed: () {},
                icon: Badge(
                  badgeColor: AppColor.cartBadgeColor,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(end: -7),
                  badgeContent: Text(
                      _cartController.cartItems.length.toString(),
                      style: TextStyle(color: Colors.white)),
                  child: Icon(MyIcon.md_cart, color: Colors.purple),
                ),
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 480,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(
                _list.length, (index) => FeedsProduct(product: _list[index]))),
      ),
    );
  }
}
