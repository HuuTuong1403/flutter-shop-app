import 'package:get/get.dart';
import 'package:shopappfirebase/src/app.dart';
import 'package:shopappfirebase/src/screens/home/home_screen.dart';
import 'package:shopappfirebase/src/screens/home/pages/cart.dart';
import 'package:shopappfirebase/src/screens/home/pages/feeds.dart';
import 'package:shopappfirebase/src/screens/home/pages/home.dart';
import 'package:shopappfirebase/src/screens/home/pages/search.dart';
import 'package:shopappfirebase/src/screens/home/pages/user.dart';

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
  ];
}
