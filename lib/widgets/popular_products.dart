import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';
import '../provider/cart_provider.dart';
import '../provider/products.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    // print('Printing popular product widget - State Initialization');
    final productAttribute = Provider.of<Products>(context);
    final productpopular = productAttribute.products;

    return SizedBox(
      height: 350, // Adjust height as needed
      // color: Colors.amber,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(productpopular.length, (index) {
            // print('Building item index $index');
            final product = productpopular[index];
            return buildProductItem(product);
          }),
        ),
      ),
    );
  }

  Widget buildProductItem(Product product) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Add onTap functionality here
        },
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          width: 200, // Define a fixed width for each item
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProductImage(product.imageUrl),
              buildProductDetails(product),
              // ShoppingIcon(product: product), // Pass the product here
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductImage(String imageUrl) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Positioned(
          right: 10,
          top: 10,
          child: RatingBox(),
        ),
      ],
    );
  }

  Widget buildProductDetails(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            maxLines: 1,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800]),
          ),
          const SizedBox(height: 5),
          buildPriceAndIcon(product),
        ],
      ),
    );
  }

  Widget buildPriceAndIcon(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.price,
          style: const TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        ShoppingIcon(product: product), // Pass the entire product object
      ],
    );
  }
}

class RatingBox extends StatelessWidget {
  const RatingBox({super.key});

  @override
  Widget build(BuildContext context) {
        //  final favsprovider = Provider.of<FavsProvider>(context);
        //  final productAttribute = Provider.of<Products>(context);
        //  final productpopular = productAttribute.products;
        //   final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const  Row(
        children: [
          Icon(Icons.star,
          //  color: favsprovider.getFavsItems.containsKey(productAttribute.id)?Colors.red: //error here in getting the produict id 
          //   const Color.fromARGB(255, 213, 211, 211), size: 20
            ),
           SizedBox(width: 5),
           Text('4.5',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ShoppingIcon extends StatelessWidget {
  final Product product;
  const ShoppingIcon({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final productAttribute = Provider.of<Products>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: cartProvider.getCartItems.containsKey(product.id)
            ? () {}
            : () {
                cartProvider.addProductToCart(
                    product.id,
                    double.parse(product.price),
                    product.title,
                    product.imageUrl);
              },
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: cartProvider.getCartItems.containsKey(product.id)
              ? const Icon(Icons.check_circle, size: 25, color: Colors.black)
              : const Icon(Icons.add_to_queue, size: 25, color: Colors.black),
        ),
      ),
    );
  }
}
