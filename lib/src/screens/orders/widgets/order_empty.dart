import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({Key? key}) : super(key: key);

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
                image: NetworkImage(
                    'https://image.flaticon.com/icons/png/128/3759/3759041.png'),
                fit: BoxFit.fill),
          ),
        ),
        Text(
          "Your Order Is Empty",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Looks Like You didn't \n has anything in your order yet",
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
            onPressed: () {
              Get.toNamed(Routes.FEEDSPAGE, arguments: ['']);
            },
            child: Text(
              "SHOP NOW",
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
