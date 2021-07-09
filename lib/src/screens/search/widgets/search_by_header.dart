import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class SearchByHeader extends SliverPersistentHeaderDelegate {
  final double flexibleSpace;
  final double backGroundHeight;
  final double stackPaddingTop;
  final double titlePaddingTop;
  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? action;
  final Widget stackChild;

  SearchByHeader(
      {this.flexibleSpace = 300,
      this.backGroundHeight = 200,
      required this.stackPaddingTop,
      this.titlePaddingTop = 15,
      required this.title,
      this.subTitle,
      this.leading,
      this.action,
      required this.stackChild});

  CartController _cartController = Get.find();
  WishlistController _wishlistController = Get.find();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var percent = shrinkOffset / (maxExtent - minExtent);
    double calculate = 1 - percent < 0 ? 0 : (1 - percent);
    return SizedBox(
      height: maxExtent,
      child: Stack(
        children: <Widget>[
          Container(
            height: minExtent + ((backGroundHeight - minExtent) * calculate),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                AppColor.starterColor,
                AppColor.endColor,
              ],
              begin: const FractionalOffset(0, 1),
              end: const FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            )),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Obx(
                  () => Badge(
                    badgeColor: AppColor.favBadgeColor,
                    position: BadgePosition.topEnd(top: -4, end: -4),
                    badgeContent: Text(
                      _wishlistController.favItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: AppColor.favBadgeColor),
                      onPressed: () {
                        Get.toNamed(Routes.WISHLIST);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Badge(
                    badgeColor: AppColor.cartBadgeColor,
                    position: BadgePosition.topEnd(top: -4, end: -4),
                    badgeContent: Text(
                      _cartController.cartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon:
                          Icon(MyIcon.md_cart, color: AppColor.cartBadgeColor),
                      onPressed: () {
                        Get.toNamed(Routes.CARTPAGE);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            left: 10,
            child: Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.USERPAGE);
                },
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.grey,
                child: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: titlePaddingTop * calculate + 27,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    leading ?? SizedBox(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Transform.scale(
                            alignment: Alignment.centerLeft,
                            scale: 1 + (calculate * .5),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 14 * (1 - calculate)),
                              child: title,
                            ),
                          ),
                          if (calculate > .5) ...[
                            SizedBox(height: 10),
                            Opacity(
                              opacity: calculate,
                              child: subTitle ?? SizedBox(),
                            ),
                          ],
                        ]),
                  ]),
            ),
          ),
          Positioned(
            top: minExtent + ((stackPaddingTop - minExtent) * calculate),
            child: Opacity(
              opacity: calculate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: stackChild,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => flexibleSpace;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
