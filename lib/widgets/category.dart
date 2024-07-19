import 'package:flutter/material.dart';

import '../inner_screens/categories_feeds.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.index});

  final int index;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final List<Map<String, Object>> category = const [
    {'CategoryName': 'phones', 'categoryImagePath': 'assets/phone.webp'},
    {'CategoryName': 'clothes', 'categoryImagePath': 'assets/clothes.webp'},
    {'CategoryName': 'shoes', 'categoryImagePath': 'assets/shoes.webp'},
    {
      'CategoryName': 'Beauty&Health',
      'categoryImagePath': 'assets/beauty.webp'
    },
    {'CategoryName': 'Laptops', 'categoryImagePath': 'assets/laptop.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    // print('priting category widget3');
    final categoryName = category[widget.index]['CategoryName'] as String?;
    final categoryImagePath =
        category[widget.index]['categoryImagePath'] as String?;

    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeedScreen.routeName,
                arguments: '${category[widget.index]['CategoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: categoryImagePath != null
                  ? DecorationImage(
                      image: AssetImage(categoryImagePath),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            width: 150, // Ensure the container width matches the image width
            color: Theme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.7), // Adjust opacity for better readability
            child: categoryName != null
                ? Text(
                    categoryName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    textAlign: TextAlign.center, // Center the text
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
