import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';

class CartFull extends StatefulWidget {
  CartFull({Key? key}) : super(key: key);

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  bool isDark = ThemeService().isSavedDarkMode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            color: Theme.of(context).backgroundColor),
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.ytimg.com/vi/ETsekJKsr3M/maxresdefault.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Samsung Galaxy S9",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(Entypo.cross,
                                  color: Colors.red, size: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Price:",
                          style: TextStyle(),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "450.0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Sub total:",
                          style: TextStyle(),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "\$450.000",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Ships Free",
                          style: TextStyle(
                            color: isDark
                                ? Colors.brown.shade900
                                : Theme.of(context).accentColor,
                          ),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(Entypo.minus,
                                  color: Colors.red, size: 22),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              AppColor.gradientStart,
                              AppColor.gradientEnd
                            ], stops: [
                              0.0,
                              0.7
                            ])),
                            child: Text(
                              '1',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(Entypo.plus,
                                  color: Colors.green, size: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
