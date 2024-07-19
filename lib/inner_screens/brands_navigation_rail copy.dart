import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  const BrandNavigationRailScreen({super.key});

  static const routeName = '/brands_navigation_rail';

  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 0;
  late String brand;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    _selectedIndex = int.parse(routeArgs.split('_')[1]);
    setBrand(_selectedIndex);
    // print('Route Arguments: $routeArgs');
    // print('Selected Brand: $brand');
    // print('brand name will be printed');
  }

  void setBrand(int index) {
    setState(() {
      switch (index) {
        case 0:
          brand = 'Gucci';
          break;
        case 1:
          brand = 'Rolex';
          break;
        case 2:
          brand = 'H&M';
          break;
        default:
          brand = 'View All';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final productBrands = productsData.findByBrand(brand);
    if (brand == 'View All') {
      for (int i = 0; i < productsData.products.length; i++) {
        productBrands.add(productsData.products[i]);
        // print(brand);
        //  print('$productBrands');
      }
    }
    // print('brand $brand');
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 56.0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setBrand(index);
              // print('Selected Index: $index');
              // print('Selected Brand: $brand');
            },
            labelType: NavigationRailLabelType.all,
            leading: const Column(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
            selectedLabelTextStyle: const TextStyle(
              color: Color.fromARGB(255, 215, 104, 6),
              fontSize: 20,
              letterSpacing: 1,
              decoration: TextDecoration.underline,
              decorationThickness: 2.5,
            ),
            unselectedLabelTextStyle: const TextStyle(
              fontSize: 15,
              letterSpacing: 0.8,
            ),
            destinations: [
              buildRotatedTextRailDestination('Gucci'),
              buildRotatedTextRailDestination('Rolex'),
              buildRotatedTextRailDestination('H&M'),
              buildRotatedTextRailDestination('View All'),
            ],
          ),
          Expanded(child: ContentSpace(brand: brand)),
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(String text) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: RotatedBox(
      quarterTurns: 3,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  final String brand;
  const ContentSpace({required this.brand, super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsBrand = productsData.findByBrand(brand);
    // print('product brand is $productsBrand');
    // print('brand $brand');
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: BrandsNavigationRail(selectedBrand: brand),
      ),
    );
  }
}
