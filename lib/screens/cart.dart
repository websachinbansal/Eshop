import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/widgets/cart_empty.dart';
import 'package:provider/provider.dart';

import '../services/global_methods.dart';
import '../widgets/cart_full.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
        GlobalMethods globalMethods = GlobalMethods();

    
    final cartProvider = Provider.of<CartProvider>(context);
    List products = [];

    return cartProvider.getCartItems.isEmpty
        ? const Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkOutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart ${cartProvider.getCartItems.length}'),
              actions: [
                IconButton(
                    onPressed: () {
                           globalMethods.showDialogg(
                                  'Clear Cart!',
                                  'Your Cart will be cleared',
                                  () =>
                                      cartProvider.clearCart(), context);
                      // cartProvider.clearCart();
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Container(
              margin: const EdgeInsets.all(5),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList()[index],
                        child: CartFull(
                          productId:
                              cartProvider.getCartItems.keys.toList()[index],
                        ),
                      ),
                    );
                  }),
            ));
  }

  Widget checkOutSection(BuildContext ctx, double subtotal) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Material(
                color: Colors.blue,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'CheckOut',
                      style: TextStyle(
                          color:
                              Theme.of(ctx).textSelectionTheme.selectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Total:',
              style: TextStyle(
                  color: Theme.of(ctx).textSelectionTheme.selectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
             Text(
              ' $subtotal',
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
