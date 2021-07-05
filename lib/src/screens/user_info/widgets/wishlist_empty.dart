import 'package:flutter/material.dart';

class WishListEmpty extends StatelessWidget {
  const WishListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 80),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/empty-wishlist.png'),
                fit: BoxFit.fill),
          ),
        ),
        Text(
          "Your Wishlist Is Empty",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Explore more and shortlist some items",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: Text(
              "ADD A WISH",
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),
        ),
      ],
    );
  }
}
