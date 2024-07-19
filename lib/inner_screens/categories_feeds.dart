import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:provider/provider.dart';

import '../widgets/feeds_products.dart';

class CategoriesFeedScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedScreen';
  const CategoriesFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final categoryName = ModalRoute.of(context)?.settings.arguments as String;
    // print(categoryName);
        final productList = productProvider.findByCategory(categoryName);
        

    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 240 / 400,
      crossAxisSpacing: 2,
      children: List.generate(productList.length, (index) {
        return ChangeNotifierProvider.value(
            value: productList[index], child: const Feedproducts());
      }),
    ));
  }
}
