import 'package:get/get.dart';
import 'package:shopappfirebase/src/app.dart';
import 'package:shopappfirebase/src/screens/authentication/pages/login_page.dart';
import 'package:shopappfirebase/src/screens/authentication/pages/signup_page.dart';
import 'package:shopappfirebase/src/screens/authentication/widgets/landing_page.dart';
import 'package:shopappfirebase/src/screens/home/home_screen.dart';
import 'package:shopappfirebase/src/screens/home/pages/cart.dart';
import 'package:shopappfirebase/src/screens/home/pages/feeds.dart';
import 'package:shopappfirebase/src/screens/home/pages/home.dart';
import 'package:shopappfirebase/src/screens/home/pages/search.dart';
import 'package:shopappfirebase/src/screens/home/pages/user.dart';
import 'package:shopappfirebase/src/screens/products/pages/product_detail.dart';
import 'package:shopappfirebase/src/screens/products/pages/upload_product_page.dart';
import 'package:shopappfirebase/src/screens/user_info/pages/wishlist.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(name: Routes.ROOT, page: () => MyApp(), children: []),

    //HOME PAGE
    GetPage(name: Routes.HOMESCREEN, page: () => HomeScreen(), children: []),
    GetPage(name: Routes.HOMEPAGE, page: () => HomePage(), children: []),
    GetPage(name: Routes.FEEDSPAGE, page: () => FeedsPage(), children: []),
    GetPage(name: Routes.CARTPAGE, page: () => CartPage(), children: []),
    GetPage(name: Routes.USERPAGE, page: () => UserPage(), children: []),
    GetPage(name: Routes.SEARCHPAGE, page: () => SearchPage(), children: []),
    GetPage(name: Routes.WISHLIST, page: () => WishList(), children: []),
    GetPage(
        name: Routes.PRODUCTDETAIL, page: () => ProductDetail(), children: []),
    GetPage(
        name: Routes.UPLOADPRODUCT,
        page: () => UploadProductPage(),
        children: []),

    //AUTHENTICATION PAGE
    GetPage(name: Routes.LANDINGPAGE, page: () => LandingPage(), children: []),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), children: []),
    GetPage(name: Routes.SIGNUP, page: () => SignUpPage(), children: []),
  ];
}
