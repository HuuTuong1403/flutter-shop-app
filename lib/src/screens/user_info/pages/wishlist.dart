import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shopappfirebase/src/screens/user_info/widgets/wishlist_empty.dart';
import 'package:shopappfirebase/src/screens/user_info/widgets/wishlist_full.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishLists = [];
    return !wishLists.isEmpty
        ? Scaffold(body: WishListEmpty())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Wishlist (${wishLists.length})",
                  style: Theme.of(context).appBarTheme.textTheme!.headline1),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Feather.trash),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return WishListFull();
              },
            ),
          );
  }
}
