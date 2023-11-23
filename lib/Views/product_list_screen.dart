import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const String screen_id = "ProductListScreen";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          badges.Badge(
            badgeContent: Text('0'),
            badgeAnimation: badges.BadgeAnimation.fade(),
          ),
          Icon(Icons.shopping_bag_outlined, color: Colors.white,),
          SizedBox(width: 20,),
        ],
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
