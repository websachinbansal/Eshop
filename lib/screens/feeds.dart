import 'package:flutter/material.dart';
import 'package:flutter_shop_app/consts/colors.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:flutter_shop_app/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../models/products.dart';
import '../provider/cart_provider.dart';
import '../provider/fav_provider.dart';
import '../widgets/feeds_products.dart';

class Feeds extends StatelessWidget {
  static const routeName = '/Feeds';
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)?.settings.arguments as String? ?? 'Default value';
    final productProvider = Provider.of<Products>(context);
    List<Product> productList = productProvider.products;
    if (popular == 'isPopular') {
      productList = productProvider.PopularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text('Feeds'),  
        actions: [
           Consumer<FavsProvider>(
                  builder: (_, favs, ch)=>
                   badges.Badge(
                    badgeAnimation: const badges.BadgeAnimation.slide(),
                    
                    badgeContent: Text(
                      favs.getFavsItems.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: ColorsConsts.cartBadgeColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: ColorsConsts.favColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(WishListScreen.routeName);
                      },
                    ),
                                   ),
                 ),
              
          
                 
               Consumer<CartProvider>(
                  builder: (_, cart, ch)=>
                   badges.Badge(
                    badgeAnimation: const badges.BadgeAnimation.slide(),
                    
                    badgeContent: Text(
                      cart.getCartItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 14.0,),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: ColorsConsts.cartBadgeColor,
                       padding: const EdgeInsets.all(4.0), // Adjust the padding
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      
                    ),
                  position:  badges.BadgePosition.topEnd(top: 5, end: 5),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_bag,
                        color: ColorsConsts.favColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(WishListScreen.routeName);
                      },
                    ),
                                   ),
                 ),
        ],
      ),
        body:
        
        
        
         GridView.count(
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
