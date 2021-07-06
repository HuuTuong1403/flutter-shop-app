import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalMethods {
Future<void> showDialog(
      {required String title,
      required String subtitle,
      required Function fct, 
      required BuildContext context}) async {
    Get.defaultDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: title.toUpperCase(),
      titleStyle: TextStyle(color: Colors.redAccent),
      content: Text(subtitle, textAlign: TextAlign.center),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w600)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  fct();
                  Get.back();
                },
                child: Text('Cofirm',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}