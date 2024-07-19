import 'package:flutter/material.dart';
import 'package:flutter_shop_app/consts/colors.dart';
import 'package:flutter_shop_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final themechange = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/cart download.jpg'))),
        ),
        Text(
          'Your Cart is Empty',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Looks Like you didn/t\n add anything to your cart ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color:themechange.darkTheme? Theme.of(context).disabledColor: ColorsConsts.subTitle,
              fontSize: 26,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.9, 
          height: MediaQuery.of(context).size.height*0.06,
          child: ElevatedButton(
            
            onPressed: (){},
             child:Text(
            'Shop Now'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ), 
             
             ),
        )
      ],
    );
  }
}
