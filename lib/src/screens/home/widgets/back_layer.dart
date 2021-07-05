import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class BackLayerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColor.starterColor, AppColor.endColor],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp),
          ),
        ),
        Positioned(
          top: -100,
          left: 140,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                width: 150,
                height: 250),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 100,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                width: 150,
                height: 300),
          ),
        ),
        Positioned(
          top: -50,
          left: 60,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                width: 150,
                height: 200),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                width: 150,
                height: 200),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                content(context, () {
                  navigateTo(context, Routes.FEEDSPAGE);
                }, 'Feeds', 0),
                const SizedBox(height: 10),
                content(context, () {
                  navigateTo(context, Routes.CARTPAGE);
                }, 'Cart', 1),
                const SizedBox(height: 10),
                content(context, () {
                  navigateTo(context, Routes.FEEDSPAGE);
                }, 'WishList', 2),
                const SizedBox(height: 10),
                content(context, () {
                  navigateTo(context, Routes.FEEDSPAGE);
                }, 'Upload a new product', 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<IconData> _contentIcons = [
    Icons.rss_feed_rounded,
    Feather.shopping_bag,
    Feather.heart,
    Feather.upload
  ];

  void navigateTo(BuildContext context, String routes) {
    Get.toNamed(routes, arguments: ['']);
  }

  Widget content(BuildContext context, Function fct, String text, int index) {
    return InkWell(
      onTap: () {
        fct();
      },
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Icon(_contentIcons[index])
      ]),
    );
  }
}
