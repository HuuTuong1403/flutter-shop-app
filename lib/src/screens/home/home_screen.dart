import 'package:flutter/material.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/screens/cart/pages/cart.dart';
import 'package:shopappfirebase/src/screens/home/pages/feeds.dart';
import 'package:shopappfirebase/src/screens/home/pages/home.dart';
import 'package:shopappfirebase/src/screens/home/pages/search.dart';
import 'package:shopappfirebase/src/screens/home/pages/user.dart';
import 'package:shopappfirebase/src/screens/products/pages/upload_product_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _pages = [];
  int _currentIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': HomePage()},
      {'page': FeedsPage(category: '')},
      {'page': SearchPage()},
      {'page': CartPage()},
      {'page': UserPage()},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Scaffold(
          body: _pages[_currentIndex]['page'],
          bottomNavigationBar: BottomAppBar(
            notchMargin: 3,
            clipBehavior: Clip.antiAlias,
            shape: CircularNotchedRectangle(),
            child: Container(
              decoration:
                  BoxDecoration(border: Border(top: BorderSide(width: 0.5))),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _selectedPage,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.purple,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(MyIcon.rss),
                      label: "Feeds",
                      tooltip: "Feeds"),
                  BottomNavigationBarItem(
                      icon: Icon(null), label: "Search", tooltip: "Search"),
                  BottomNavigationBarItem(
                      icon: Icon(MyIcon.shopping_bag),
                      label: "Cart",
                      tooltip: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(MyIcon.user), label: "User", tooltip: "User"),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            hoverElevation: 10,
            splashColor: Colors.grey,
            tooltip: "Search",
            elevation: 4,
            child: Icon(MyIcon.search),
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
        ),
        UploadProductPage(),
      ],
    );
  }
}
