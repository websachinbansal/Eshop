import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_shop_app/models/products.dart';
import 'package:flutter_shop_app/widgets/feeds_dialog.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';

class Feedproducts extends StatefulWidget {
  const Feedproducts({super.key});

  @override
  State<StatefulWidget> createState() => FeedproductsState();
}

class FeedproductsState extends State<Feedproducts> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    // print(
    //   productsAttributes.imageUrl,
    // );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productsAttributes.id),
        child: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                        width: double.infinity,
                        height: 130,
                        constraints: BoxConstraints(
                            minHeight: 100,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.3),
                        child: Image.network(productsAttributes.imageUrl,
                            fit: BoxFit.contain, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                          return const Text('Failed to load image');
                        })),
                  ),
                  const badges.Badge(
                    badgeContent: Text(
                      'New',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(Icons.settings),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productsAttributes.id,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        productsAttributes.price,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${productsAttributes.quantity}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => FeedDialog(
                                      productId: productsAttributes.id));
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const Icon(
                              Icons.more,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
