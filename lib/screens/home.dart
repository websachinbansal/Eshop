import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/consts/colors.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:flutter_shop_app/screens/feeds.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:provider/provider.dart';

import '../inner_screens/brands_navigation_rail copy.dart';

import '../widgets/backlayer.dart';
import '../widgets/category.dart';
import '../widgets/popular_products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _carouselImages = [
    'assets/def.jpg',
    'assets/ghi.jpg',
    'assets/jkl.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    // print('Building Home file');
    final productsData = Provider.of<Products>(context);
    final popularItems = productsData.PopularProducts;
    // print('popularitem length from home file ${popularItems.length}');
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: BackdropAppBar(
            excludeHeaderSemantics: true,
            title: const Text("Home"),
            leading: const BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorsConsts.starterColor,
                ColorsConsts.endColor
              ])),
            ),
            actions: <Widget>[
              IconButton(
                iconSize: 15,
                onPressed: () {},
                icon: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                  ),
                  child: CircleAvatar(
                    radius: 13,
                  ),
                ),
              )
            ],
          ),
          backLayer: const BackLayerMenu(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourserSlider(carouselImages: _carouselImages),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      // print('printintg from home.dart file');
                      return CategoryWidget(index: index);
                    },
                  ),
                ),
                const PopularBrands(),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Popular Products',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Feeds.routeName);
                            },
                            child: const Text(
                              'View All....',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.red),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        // color: Colors.blue,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: popularItems.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            // print('popular product builder');
                            return ChangeNotifierProvider.value(
                              value: popularItems[index],
                              child: const PopularProducts(),
                            );
                          },
                        ),
                      )
                    ],
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

class PopularBrands extends StatelessWidget {
  const PopularBrands({super.key});

  @override
  Widget build(BuildContext context) {
    // print('Printing popular brands widget4');
    List brandImage = [
      'assets/bc.png',
      'assets/cd.png',
      'assets/de.png',
    ];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Popular Brands',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'View All....',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.red),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 210,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Swiper(
              autoplay: true,
              autoplayDelay: 3000,
              onTap: (index) {
                Navigator.of(context).pushNamed(
                  BrandNavigationRailScreen.routeName,
                  arguments: 'index_$index',
                );
                // print('button pressed');
              },
              itemBuilder: (BuildContext ctx, int index) {
                // print('popular brand builder');

                return Container(
                  color: const Color.fromARGB(255, 245, 244, 244),
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(brandImage[index]),
                  ),
                );
              },
              itemCount: brandImage.length,
            ),
          )
        ],
      ),
    );
  }
}

class CourserSlider extends StatelessWidget {
  const CourserSlider({
    super.key,
    required List<String> carouselImages,
  }) : _carouselImages = carouselImages;

  final List<String> _carouselImages;

  @override
  Widget build(BuildContext context) {
    // print('Printing cursoer slider widget'); //this statement is not building
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Swiper(
        autoplay: true,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
        itemCount: _carouselImages.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(color: Colors.amber),
            child: Image.asset(
              _carouselImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
