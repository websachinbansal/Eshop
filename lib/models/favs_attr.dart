import 'package:flutter/material.dart';

class FavsAttr with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  FavsAttr({
  required  this.id,
  required  this.title,
  required  this.quantity,
  required  this.price,
  required  this.imageUrl,
  });
}
