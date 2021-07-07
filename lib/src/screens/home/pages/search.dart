import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:shopappfirebase/src/screens/feeds/feeds_product.dart';
import 'package:shopappfirebase/src/screens/products/controllers/product_controller.dart';
import 'package:shopappfirebase/src/screens/search/widgets/search_by_header.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchTextController = TextEditingController();
  final FocusNode _node = FocusNode();
  ProductController _productController = Get.find();
  List<Product> _list = [];

  @override
  void initState() {
    super.initState();
    _list = _productController.products;
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchByHeader(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: RichText(
                text: TextSpan(
                  text: 'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.title,
                    fontSize: 24,
                  ),
                ),
              ),
              stackChild: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ]),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                        onPressed: _searchTextController.text.isEmpty
                            ? null
                            : () {
                                _node.unfocus();
                                _searchTextController.clear();
                                _list = _productController.products;
                              },
                        icon: Icon(Feather.x,
                            color: _searchTextController.text.isNotEmpty
                                ? Colors.red
                                : Colors.grey)),
                  ),
                  onChanged: (value) {
                    _searchTextController.text.toLowerCase();
                    setState(() {
                      _list = _productController.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _searchTextController.text.isNotEmpty && _list.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Icon(Icons.search, size: 70),
                      const SizedBox(height: 20),
                      Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 240 / 290,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(_list.length,
                        (index) => FeedsProduct(product: _list[index]))),
          )
        ],
      ),
    );
  }
}
