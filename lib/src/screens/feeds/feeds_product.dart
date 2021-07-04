import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class FeedsProduct extends StatefulWidget {
  FeedsProduct({Key? key}) : super(key: key);

  @override
  _FeedsProductState createState() => _FeedsProductState();
}

class _FeedsProductState extends State<FeedsProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: Image.network(
                      'https://i.ytimg.com/vi/ETsekJKsr3M/maxresdefault.jpg',
                      fit: BoxFit.fitWidth),
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
                    "Samsung Galaxy 9",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\$ 50.99",
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
                          "Quantity: 65",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            icon: Icon(Icons.more_horiz, color: Colors.grey),
                            onPressed: () {}),
                      ]),
                ]),
          ),
        ],
      ),
    );
  }
}
