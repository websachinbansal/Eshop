import 'package:flutter/material.dart';
import 'package:flutter_shop_app/inner_screens/product_details.dart';
import 'package:flutter_shop_app/models/cart_attribute.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';

import 'package:flutter_shop_app/provider/dark_theme_provider.dart';
import 'package:flutter_shop_app/services/global_methods.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({super.key, required this.productId});

  @override
  State<StatefulWidget> createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final cartAttr = Provider.of<CartAttribute>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    double subtotal = cartAttr.price * cartAttr.quantity;
    // CartProvider cartProvider = CartProvider();
    final cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.productId),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cartAttr.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cartAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: themeChange.darkTheme
                                  ? Colors.brown.shade900
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {
                              globalMethods.showDialogg(
                                  'Remove Item!',
                                  'product will be removed from the cart',
                                  () =>
                                      cartProvider.reoveItem(widget.productId,), context);
                              // cartProvider.reoveItem(widget.productId);
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Price: '),
                        Text(
                          '${cartAttr.price}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Sub Total: '),
                        Text(
                          "$subtotal",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ships Free',
                          style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: cartAttr.quantity < 2
                                ? null
                                : () {
                                    cartProvider.subtractProductToCart(
                                      widget.productId,
                                      // cartAttr.price,
                                      // cartAttr.title,
                                      // cartAttr.imageUrl
                                    );
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.minimize_rounded,
                                  color: cartAttr.quantity < 2
                                      ? Colors.grey
                                      : Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.blue,
                                ],
                                stops: [0.0, 0.7],
                              ),
                            ),
                            child: Text(
                              cartAttr.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {
                              cartProvider.addProductToCart(
                                widget.productId,
                                cartAttr.price,
                                cartAttr.title,
                                cartAttr.imageUrl,
                              );
                              // print('Pressed on add quantity');
                              // print(cartAttr.quantity);
                            },
                            child: Container(
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
