import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final int index;
  CategoryWidget({Key? key, required this.index}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, String>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1594720981602-dd3457bb1c84?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGhvbmUlMjBjYXRlZ29yeXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'Clothes',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1603400521630-9f2de124b33b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xvdGhlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'Shoes',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1543508282-6319a3e2621f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8c2hvZXN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'BeautyHealth',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1564277287253-934c868e54ea?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGJlYXV0eSUyMGhlYWx0aHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'Laptops',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFwdG9wfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'Furniture',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1554295405-abb8fd54f153?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZnVybml0dXJlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'categoryName': 'Watches',
      'categoryImagePath':
          'https://images.unsplash.com/photo-1594576722512-582bcd46fba3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2F0Y2hlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                  categories[widget.index]['categoryImagePath']!,
                ),
                fit: BoxFit.cover),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150,
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName']!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
