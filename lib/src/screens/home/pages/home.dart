import 'package:backdrop/backdrop.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/home/widgets/back_layer.dart';
import 'package:shopappfirebase/src/screens/home/widgets/category.dart';
import 'package:shopappfirebase/src/screens/home/widgets/popular_products.dart';
import 'package:shopappfirebase/src/screens/orders/controllers/order_controller.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.png'
  ];

  List<String> brands = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/Dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/Huawei.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg'
  ];

  ProductController _productController = Get.put(ProductController());
  var _listPopular = [];

  // ignore: unused_field
  WishlistController _wishlistController = Get.put(WishlistController());
  // ignore: unused_field
  CartController _cartListController = Get.put(CartController());

  OrderController _orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    _productController.getProduct();
    _orderController.getOrder();
    _listPopular = _productController.getPopularItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home", style: TextStyle(color: Colors.black)),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColor.starterColor, AppColor.endColor]))),
          actions: <Widget>[
            IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(10),
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                ),
              ),
            ),
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 190.0,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.fill,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5.0,
                  dotIncreasedColor: Colors.purple,
                  dotBgColor: Colors.black.withOpacity(0.2),
                  dotPosition: DotPosition.bottomCenter,
                  showIndicator: true,
                  indicatorBgPadding: 5.0,
                  images: [
                    ExactAssetImage(images[0]),
                    ExactAssetImage(images[1]),
                    ExactAssetImage(images[2]),
                  ],
                ),
              ),
              _categoriesTile(title: "Categories", showViewAll: false),
              Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryWidget(index: index);
                    }),
              ),
              _categoriesTile(title: "Popular Brands", showViewAll: true),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Swiper(
                  itemCount: brands.length,
                  autoplay: true,
                  onTap: (index) {},
                  scale: 0.8,
                  viewportFraction: 0.7,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blueGrey,
                        child: Image.asset(brands[index], fit: BoxFit.fill),
                      ),
                    );
                  },
                ),
              ),
              _categoriesTile(title: "Popular Products", showViewAll: true),
              FutureBuilder(
                  future: _productController.getProduct(),
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      height: 285,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: ListView.builder(
                          itemCount: _listPopular.length,
                          itemBuilder: (context, index) => PopularProducts(
                              index: index, product: _listPopular[index]),
                          scrollDirection: Axis.horizontal),
                    );
                  }),
              _categoriesTile(title: "Viewed recently", showViewAll: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoriesTile({required String title, required bool showViewAll}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          showViewAll
              ? TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.FEEDSPAGE, arguments: ['popular']);
                  },
                  child: Text(
                    "View all >>",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
