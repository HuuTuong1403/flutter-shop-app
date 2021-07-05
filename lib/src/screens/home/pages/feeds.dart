import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/screens/feeds/feeds_product.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
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
  String categoryName = '';
  List<Product> _list = [];

  @override
  void initState() {
    super.initState();
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
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text("3", style: TextStyle(color: Colors.white)),
              badgeColor: Colors.purple,
              child: Icon(Icons.favorite_border_outlined, color: Colors.red),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text("3", style: TextStyle(color: Colors.white)),
              badgeColor: Colors.purple,
              child: Icon(Ionicons.md_cart, color: Colors.purple),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 290,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(
                _list.length, (index) => FeedsProduct(product: _list[index]))),
      ),
    );
  }
}
