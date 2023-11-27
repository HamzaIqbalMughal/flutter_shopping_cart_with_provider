import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const String screen_id = "ProductListScreen";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Cherry',
    'Peach',
    'Apple'
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'KG',
    'Dozen',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70, 80];

  List<String> productImage = [
    'https://www.shutterstock.com/shutterstock/photos/144185134/display_1500/stock-photo-mango-fruit-isolated-on-white-background-144185134.jpg',
    'https://www.shutterstock.com/shutterstock/photos/342874121/display_1500/stock-photo-fresh-orange-isolated-on-white-background-342874121.jpg',
    'https://www.shutterstock.com/shutterstock/photos/575528746/display_1500/stock-photo-banana-cluster-isolated-575528746.jpg',
    'https://www.shutterstock.com/shutterstock/photos/118787176/display_1500/stock-photo-assortment-of-exotic-fruits-in-basket-isolated-on-white-118787176.jpg',
    'https://www.shutterstock.com/shutterstock/photos/200523716/display_1500/stock-photo-cherry-isolated-on-white-background-200523716.jpg',
    'https://www.shutterstock.com/shutterstock/photos/237716656/display_1500/stock-photo-peach-fruit-with-slice-isolated-on-white-background-237716656.jpg',
    'https://www.shutterstock.com/shutterstock/photos/397222102/display_1500/stock-photo-fresh-red-apple-isolated-on-white-with-clipping-path-397222102.jpg',
  ];

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
            badgeContent: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
            badgeAnimation: badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 2),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
          // Icon(Icons.shopping_bag_outlined, color: Colors.white,),
          SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productImage.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: NetworkImage(
                                productImage[index].toString(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    productUnit[index].toString() +
                                        " " +
                                        r"$" +
                                        productPrice[index].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
