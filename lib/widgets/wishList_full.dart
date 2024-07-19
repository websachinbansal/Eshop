import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/favs_attr.dart';
import 'package:flutter_shop_app/provider/fav_provider.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../services/global_methods.dart';

class WishlistFull extends StatefulWidget {
  final String productid;
  const WishlistFull({super.key, required this.productid});

  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final favsAttr = Provider.of<FavsAttr>(context);
    String price = favsAttr.price.toString();
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      child: Image.network(favsAttr.imageUrl
                          // 'https://abong.com.bd/public//admin/media/2020/03/yellow_mesh_men_sport_sneaker_shoesjpeg_20200307141459.jpeg'
                          ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productid),
      ],
    );
  }

  Widget positionedRemove(String productID) {
      GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return Positioned(
      top: 20,
      right: 15,
      child: SizedBox(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.all(0.0),
          color: ColorsConsts.favColor,
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            globalMethods.showDialogg(
                'Remove Wish!',
                'This Product will be removed from wishlist',
                () => favsProvider.removeItem(productID), context);
          },
        ),
      ),
    );
  }
}
