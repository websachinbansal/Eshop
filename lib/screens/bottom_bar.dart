import 'package:flutter/material.dart';

import 'cart.dart';
import 'feeds.dart';
import 'home.dart';
import 'search.dart';
import 'user_info.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': const Home(),
        'title': 'Home',
      },
      {
        'page': const Feeds(),
        'title': 'Feeds',
      },
      {
        'page': const Search(),
        'title': 'Search',
      },
      {
        'page': const Cart(),
        'title': 'Cart',
      },
      {
        'page': const UserInfo(),
        'title': 'User',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = _pages[_selectedPageIndex];
    return Scaffold(
      appBar: _selectedPageIndex == 0
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(currentPage['title'] as String? ?? ''),
            ),
      body: SafeArea(child: currentPage['page'] as Widget),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.rss_feed, 'Feeds', 1),
              const SizedBox(width: 40), // Space for the FAB
              _buildNavItem(Icons.shopping_bag, 'Cart', 3),
              _buildNavItem(Icons.person, 'User', 4),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        hoverElevation: 10,
        splashColor: Colors.grey,
        tooltip: 'Search',
        elevation: 3,
        child: const Icon(Icons.search),
        onPressed: () => setState(() {
          _selectedPageIndex = 2;
        }),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _selectPage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _selectedPageIndex == index
                ? Colors.blue
                : const Color.fromARGB(102, 33, 33, 33),
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedPageIndex == index
                  ? Colors.blue
                  : const Color.fromARGB(102, 33, 33, 33),
            ),
          ),
        ],
      ),
    );
  }
}
