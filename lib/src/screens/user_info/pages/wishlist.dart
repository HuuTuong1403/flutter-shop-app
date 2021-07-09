import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/myicon.dart'; 
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';
import 'package:shopappfirebase/src/screens/user_info/widgets/wishlist_empty.dart';
import 'package:shopappfirebase/src/screens/user_info/widgets/wishlist_full.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishlistController _wishlistController = Get.find();
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _wishlistController.favItems.isEmpty
        ? Scaffold(body: WishListEmpty())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Wishlist (${_wishlistController.favItems.length})",
                  style: Theme.of(context).appBarTheme.textTheme!.headline1),
              actions: [
                IconButton(
                  onPressed: () {
                    _globalMethods.showDialog(
                        title: 'CLEAR ITEMS',
                        subtitle:
                            'Product will be clear in Wish List. Do you want to do?',
                        fct: () {
                          _wishlistController.clearFav();
                        },
                        context: context);
                  },
                  icon: Icon(MyIcon.trash),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: _wishlistController.favItems.length,
              itemBuilder: (context, index) {
                return WishListFull(
                    index: index,
                    favId: _wishlistController.favItems.keys.toList()[index],
                    fav: _wishlistController.favItems.values.toList()[index]);
              },
            ),
          ));
  }
}
