import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/models/favorite.dart';
import 'package:shopappfirebase/src/screens/user_info/controllers/wishlist_controller.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';

class WishListFull extends StatefulWidget {
  final Favorite fav;
  final String favId;
  final int index;
  WishListFull(
      {Key? key, required this.fav, required this.favId, required this.index})
      : super(key: key);

  @override
  _WishListFullState createState() => _WishListFullState();
}

class _WishListFullState extends State<WishListFull> {
  GlobalMethods _globalMethods = GlobalMethods();
  WishlistController _wishlistController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 30, bottom: 10, top: 10),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            elevation: 3,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network('${widget.fav.imageUrl}'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.fav.title}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '\$ ${widget.fav.price}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionRemove(),
      ],
    );
  }

  Widget positionRemove() {
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(0),
          color: AppColor.favColor,
          child: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            _globalMethods.showDialog(
                title: 'Remove item!',
                subtitle:
                    'Product will removed from this cart. Do you want to remove this item?',
                fct: () {
                  _wishlistController.removeItem(widget.favId);
                },
                context: context);
          },
        ),
      ),
    );
  }
}
