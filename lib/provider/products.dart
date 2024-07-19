import 'package:flutter/material.dart';
import '../models/products.dart';

class Products with ChangeNotifier {
 final List<Product> _products = [
  Product(
    id: 'samsung',
    title: 'Samsung Galaxy S9',
    price: '30000',
    imageUrl: 'https://images.samsung.com/is/image/samsung/p6pim/levant/galaxy-s9-sm-g960fzkakwd/gallery/levant-galaxy-s9-g960-sm-g960fzkakwd-190670614?720_576_PNG',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'Samsung',
    isPopular: false,
    description: 'Description',
  ),
  Product(
    id: 'nokia',
    title: 'Nokia 6.1 Plus',
    price: '25000',
    imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/61WT1fQCiAL._SX679_.jpg',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'Nokia',
    isPopular: false,
    description: 'Description',
  ),
  Product(
    id: 'huawei',
    title: 'Huawei A4',
    price: '30000',
    imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/41EOMdmjU3L._SX679_.jpg',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'Huawei',
    isPopular: true,
    description: 'Description',
  ),
  Product(
    id: 'iphone',
    title: 'iPhone 15 Pro',
    price: '30000',
    imageUrl: 'https://www.apple.com/newsroom/images/product/iphone/standard/Apple-iPhone-15-Pro-glass-back-design-09122023.jpg.og.jpg',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'Apple',
    isPopular: true,
    description: 'Description',
  ),
  Product(
    id: 'moto',
    title: 'Moto M15',
    price: '25000',
    imageUrl: 'https://fdn2.gsmarena.com/vv/pics/motorola/motorola-moto-g15-1.jpg',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'Motorola',
    isPopular: false,
    description: 'Description',
  ),
  Product(
    id: 'realme',
    title: 'RealMe P1',
    price: '25000',
    imageUrl: 'https://fdn2.gsmarena.com/vv/pics/realme/realme-p1-1.jpg',
    quantity: 10,
    productCategoryName: 'phones',
    brand: 'RealMe',
    isPopular: false,
    description: 'Description',
  ),
  Product(
    id: 'cottoncloth',
    title: 'Cotton Cloth',
    price: '999',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRyuH09oyzfnq90uTow0iXtX-dG_a2hifd6g&usqp=CAU',
    quantity: 20,
    productCategoryName: 'clothes',
    brand: 'Rolex',
    isPopular: true,
    description: 'Description',
  ),
  Product(
    id: 'nike-shoes',
    title: 'Nike Running Shoes',
    price: '5000',
    imageUrl: 'data:image/jpeg;base64,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',
    quantity: 15,
    productCategoryName: 'shoes',
    brand: 'Nike',
    isPopular: true,
    description: 'High-performance running shoes with great cushioning.',
  ),
  Product(
    id: 'adidas-shoes',
    title: 'Adidas Sneakers',
    price: '4500',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRneuH6XYOf7krxHVrGm0jJ-Gm8oEmozQxdCg&usqp=CAU',
    quantity: 20,
    productCategoryName: 'shoes',
    brand: 'Adidas',
    isPopular: false,
    description: 'Stylish and comfortable sneakers for everyday use.',
  ),
  Product(
    id: 'lipstick',
    title: 'Matte Lipstick',
    price: '999',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrFKcyEVvj_PTE1sVimB9lZtKlJU70XkIj2A&usqp=CAU',
    quantity: 30,
    productCategoryName: 'Beauty&Health',
    brand: 'Maybelline',
    isPopular: true,
    description: 'Long-lasting matte lipstick available in various shades.',
  ),
  Product(
    id: 'face-cream',
    title: 'Face Cream',
    price: '1299',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvIhr7UM4o_-Zy-WFtBSIKDg9V1NyHzuWEfA&usqp=CAU',
    quantity: 25,
    productCategoryName: 'Beauty&Health',
    brand: 'Olay',
    isPopular: false,
    description: 'Moisturizing face cream for smooth and radiant skin.',
  ),
  Product(
    id: 'shampoo',
    title: 'Herbal Shampoo',
    price: '799',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXFfnJrjrAKWA-_iwlib00R7o6XEL5NDKHTg&usqp=CAU',
    quantity: 50,
    productCategoryName: 'Beauty&Health',
    brand: 'Herbal Essences',
    isPopular: true,
    description: 'Natural shampoo for strong and healthy hair.',
  ),
  Product(
    id: 'jeans',
    title: 'Denim Jeans',
    price: '1999',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt7XDwk9rSh-gTPf0PDVRc8v2s9VvyDQwAfQ&usqp=CAU',
    quantity: 40,
    productCategoryName: 'clothes',
    brand: 'H&M',
    isPopular: true,
    description: 'Classic denim jeans with a comfortable fit.',
  ),
  Product(
    id: 'tshirt',
    title: 'Graphic T-Shirt',
    price: '499',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0XMv05SCpfrZ4BgoPTkJlQti5Y3nwNtcW6A&usqp=CAU',
    quantity: 60,
    productCategoryName: 'clothes',
    brand: 'H&M',
    isPopular: false,
    description: 'Stylish graphic t-shirt made from soft cotton.',
  ),
  Product(
    id: 'dress',
    title: 'Summer Dress',
    price: '2999',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDNrzOELi4kNeQQIIzJUaS7Xr3fAbgkmNMPw&usqp=CAU',
    quantity: 25,
    productCategoryName: 'clothes',
    brand: 'Zara',
    isPopular: true,
    description: 'Lightweight summer dress perfect for warm weather.',
  ),
];


  List<Product> get products {
    return [..._products];
  }

   List<Product> get PopularProducts{
    return _products.where((element)=> element.isPopular).toList();
  }

  List<Product> findByCategory(String categoryName) {
    return _products
        .where((product) => product.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
  }

  List<Product> findByBrand(String brandName) {
    return _products
        .where((product) =>
            product.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
  }

  Product findById(String ProductId) {
    return _products.firstWhere((Element) => Element.id == ProductId);
  }

   List<Product> searchQuery(String searchText) {
   
    return _products
        .where((product) =>
            product.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
 

 
}
