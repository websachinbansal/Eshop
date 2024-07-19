import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/fav_provider.dart';
import 'package:flutter_shop_app/widgets/wishList_full.dart';
import 'package:provider/provider.dart';
import '../services/global_methods.dart';
import '../widgets/wishlist_empty.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  static const routeName = '/WishListScreen';

  @override
  Widget build(BuildContext context) {
      GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? const Scaffold(body: WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title:  Text('WishList(${favsProvider.getFavsItems.length})'),
                   actions: [
                IconButton(
                    onPressed: () {
                           globalMethods.showDialogg(
                                  'Clear Cart!',
                                  'Your Cart will be cleared',
                                  () =>
                                      favsProvider.clearFavs(), context);
                      // cartProvider.clearCart();
                    },
                    icon: const Icon(Icons.delete))
              ],
              // actions: [
              //   IconButton(onPressed: () {}, icon: const Icon(Icons.tram_sharp))
              // ],
            ),
            body: ListView.builder(
                itemCount: favsProvider.getFavsItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    value: favsProvider.getFavsItems.values.toList()[index],
                    child:  WishlistFull(
                      productid: favsProvider.getFavsItems.keys.toList()[index],
                    ));
                }));
  }
}
