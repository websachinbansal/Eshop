import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import 'product_details.dart';

class BrandsNavigationRail extends StatelessWidget {
  final String selectedBrand;

  const BrandsNavigationRail({super.key, required this.selectedBrand});

  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Products>(context);
    final products = productsAttributes.findByBrand(selectedBrand);

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetails.routeName,
              arguments: product.id, // Pass the product ID as an argument
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          product.productCategoryName,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
