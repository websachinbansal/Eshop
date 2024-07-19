
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/landing_page.dart';

import '../inner_screens/upload_newproduct.dart';
import 'bottom_bar.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [BottomBarScreen(), UploadProductForm()],
    );
  }
}
