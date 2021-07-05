import 'package:flutter/material.dart';
import 'package:shopappfirebase/src/common/color.dart';

class WishListFull extends StatefulWidget {
  WishListFull({Key? key}) : super(key: key);

  @override
  _WishListFullState createState() => _WishListFullState();
}

class _WishListFullState extends State<WishListFull> {
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
                      child: Image.network(
                          'https://images.unsplash.com/photo-1606308338792-186193fcb2ba?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aXBob25lMTJ8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Iphone 12 Pro',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '\$ 50.99',
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
          onPressed: () {},
        ),
      ),
    );
  }
}
