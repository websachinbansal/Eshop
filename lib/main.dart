import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop_app/inner_screens/categories_feeds.dart';
import 'package:flutter_shop_app/inner_screens/product_details.dart';
import 'package:flutter_shop_app/inner_screens/upload_newproduct.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/provider/dark_theme_provider.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:flutter_shop_app/screens/auth/sign_up.dart';
import 'package:flutter_shop_app/screens/cart.dart';
import 'package:flutter_shop_app/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'inner_screens/brands_navigation_rail copy.dart';
import 'provider/fav_provider.dart';
import 'provider/styles.dart';
import 'screens/auth/login.dart';
import 'screens/bottom_bar.dart';
import 'screens/feeds.dart';
import 'screens/first_screen.dart';
import 'screens/user_state.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      
       
      options: FirebaseOptions(
    apiKey: 'AIzaSyDQt1RbpJgHeiLFZHeDy-whOEzev7ZRKSQ',
    appId: '1:943739742217:android:fbe897d60e18930bd5f0d8',
    messagingSenderId: '943739742217',
    projectId: 'storeapp-2597b',
    storageBucket: 'storeapp-2597b.appspot.com'
   
  )
    ); // Initialize Firebase here

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    //  print('Building MyApp');
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
      
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(create: (_) => Products()),
                ChangeNotifierProvider(create: (_) => CartProvider()),
                ChangeNotifierProvider(create: (_) => FavsProvider()),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, ThemeData, child) {
                return MaterialApp(
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home:  UserState(),
                  routes: {
                    '/brands_navigation_rail': (ctx) =>
                        const BrandNavigationRailScreen(),
                    Feeds.routeName: (ctx) => const Feeds(),
                    Cart.routeName: (ctx) => const Cart(),
                    WishListScreen.routeName: (ctx) => const WishListScreen(),
                    CategoriesFeedScreen.routeName: (ctx) =>
                        const CategoriesFeedScreen(),
                    ProductDetails.routeName: (ctx) => const ProductDetails(),
                    LoginScreen.routeName: (ctx) => const LoginScreen(),
                    SignUpScreen.routeName: (ctx) => const SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => const BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) =>
                        const UploadProductForm()
                    // Add the route here
                  },
                );
              }));
        });
  }
}
