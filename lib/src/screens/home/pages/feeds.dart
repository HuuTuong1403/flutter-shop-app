import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopappfirebase/src/screens/feeds/feeds_product.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';

class FeedsPage extends StatefulWidget {
  FeedsPage({Key? key}) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  bool isDark = ThemeService().isSavedDarkMode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds",
            style: Theme.of(context).appBarTheme.textTheme!.headline1),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text("3", style: TextStyle(color: Colors.white)),
              badgeColor: Colors.purple,
              child: Icon(Icons.favorite_border_outlined, color: Colors.red),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text("3", style: TextStyle(color: Colors.white)),
              badgeColor: Colors.purple,
              child: Icon(Ionicons.md_cart, color: Colors.purple),
            ),
          ),
        ],
      ),
      body: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 6,
        itemCount: 8,
        itemBuilder: (context, index) => FeedsProduct(),
        staggeredTileBuilder: (index) =>
            new StaggeredTile.count(3, index.isEven ? 4 : 5),
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
      ),
      // child: GridView.count(
      //     crossAxisCount: 2,
      //     childAspectRatio: 240 / 290,
      //     crossAxisSpacing: 8,
      //     mainAxisSpacing: 8,
      //     children: List.generate(100, (index) => FeedsProduct())),
    );
  }
}
