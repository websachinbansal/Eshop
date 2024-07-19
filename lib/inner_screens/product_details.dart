import 'package:flutter/material.dart';
import 'package:flutter_shop_app/consts/colors.dart';
import 'package:flutter_shop_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../provider/cart_provider.dart';
import '../provider/fav_provider.dart';
import '../provider/products.dart';
import '../screens/wishlist.dart';
import '../widgets/feeds_products.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({super.key});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey previewContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavsProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<Products>(context, listen: false);
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    print('productId $productId');
    final prodAttr = productsData.findById(productId);
    final productsList = productsData.products;
    double price = double.parse(prodAttr.price);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: const BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              prodAttr.imageUrl,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                prodAttr.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'US \$ ${prodAttr.price}',
                              style: TextStyle(
                                color: themeState.darkTheme
                                    ? Theme.of(context).disabledColor
                                    : ColorsConsts.subTitle,
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          prodAttr.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 21.0,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _details(themeState.darkTheme, 'Brand: ', prodAttr.brand),
                      _details(themeState.darkTheme, 'Quantity: ',
                          '${prodAttr.quantity}'),
                      _details(themeState.darkTheme, 'Category: ',
                          prodAttr.productCategoryName),
                      _details(themeState.darkTheme, 'Popularity: ',
                          prodAttr.isPopular ? 'Popular' : 'Barely known'),
                      const SizedBox(height: 15),
                      const Divider(
                          thickness: 1, color: Colors.grey, height: 1),
                      Container(
                        color: Theme.of(context).colorScheme.surface,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 70),
                            const Divider(
                                thickness: 1, color: Colors.grey, height: 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 340,
                  child: ListView.builder(
                    itemCount: productsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: const Feedproducts(),
                        // Correct widget name to match your implementation
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "DETAIL",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
              actions: <Widget>[
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          cartProvider.getCartItems.containsKey(productId)
                              ? () {}
                              : () {
                                  cartProvider.addProductToCart(productId,
                                      price, prodAttr.title, prodAttr.imageUrl);
                                },
                      child: Text(
                        cartProvider.getCartItems.containsKey(productId)
                            ? 'In Cart'
                            : 'Add to Cart'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 68, 195, 74)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: () {
                        favsProvider.addAndRemoveFromFav(prodAttr.id, price,
                            prodAttr.title, prodAttr.imageUrl);
                      },
                      child: Center(
                        child: Icon(
                        favsProvider.getFavsItems.containsKey(productId)?Icons.favorite:  Icons.favorite_border,
                          color:favsProvider.getFavsItems.containsKey(productId)?Colors.red: ColorsConsts.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.w600,
              fontSize: 21.0,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
