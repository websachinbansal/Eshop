import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../inner_screens/product_details.dart';
import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';
import '../provider/fav_provider.dart';
import '../provider/products.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavsProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<Products>(context, listen: false);
    final prodAttr = productsData.findById(productId);
    final productsList = productsData.products;
    double price = double.parse(prodAttr.price);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Image.network(
              prodAttr.imageUrl,
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(context, 0, () {
                      favsProvider.addAndRemoveFromFav(prodAttr.id, price,
                          prodAttr.title, prodAttr.imageUrl);
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    }),
                  ),
                  Flexible(
                    child: dialogContent(context, 1, ()=> {
                      Navigator.pushNamed(context, ProductDetails.routeName,
                          arguments: prodAttr.id).then((value)=>
                            Navigator.canPop(context) ? Navigator.pop(context) : null)
                    }),
                  ),
                  Flexible(
                    child: dialogContent(context, 2, () {
                      cartProvider.getCartItems.containsKey(productId)
                          ? () {}
                          : () {
                              cartProvider.addProductToCart(productId, price,
                                  prodAttr.title, prodAttr.imageUrl);
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            };
                    }),
                  ),
                ]),
          ),

          /************close****************/
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                shape: BoxShape.circle),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function fct) {
    final cart = Provider.of<CartProvider>(context);
    final favs = Provider.of<FavsProvider>(context);
    List<IconData> dialogIcons = [
      favs.getFavsItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Icons.remove_red_eye_rounded,
      Icons.shopping_bag,
      Icons.train_sharp
    ];

    List<String> texts = [
      favs.getFavsItems.containsKey(productId)
          ? 'In wishlist'
          : 'Add to wishlist',
      'View product',
      cart.getCartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color> colors = [
      favs.getFavsItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).primaryColorLight,
      Theme.of(context).hintColor,
      Theme.of(context).primaryColorLight,
    ];
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          dialogIcons[index],
                          color: colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //  fontSize: 15,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : ColorsConsts.subTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
