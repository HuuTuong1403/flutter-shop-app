import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';
import 'package:shopappfirebase/src/screens/feeds/widgets/feeds_dialog.dart';

class FeedsProduct extends StatefulWidget {
  final Product product;
  FeedsProduct({Key? key, required this.product}) : super(key: key);

  @override
  _FeedsProductState createState() => _FeedsProductState();
}

class _FeedsProductState extends State<FeedsProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.PRODUCTDETAIL, arguments: [widget.product.id]);
        },
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network('${widget.product.imageUrl}'),
                    ),
                  ),
                  Badge(
                      elevation: 2,
                      alignment: Alignment.center,
                      toAnimate: true,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pinkAccent,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8)),
                      badgeContent:
                          Text("New", style: TextStyle(color: Colors.white))),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 4),
                    Text(
                      '${widget.product.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$ ${widget.product.price}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Quantity: ${widget.product.quantity}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            icon: Icon(Icons.more_horiz, color: Colors.grey),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => FeedsDialog(
                                      productId: '${widget.product.id}'));
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
