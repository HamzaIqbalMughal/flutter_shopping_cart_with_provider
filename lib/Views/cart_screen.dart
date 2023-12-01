import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_with_provider/db_helper.dart';
import 'package:provider/provider.dart';

import '../Models/cart_model.dart';
import '../cart_provider.dart';
import 'package:badges/badges.dart' as badges;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              badgeAnimation: badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 2),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
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
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                        snapshot.data![index].image.toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![index].productName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  dbHelper!.delete(snapshot
                                                      .data![index].id!);
                                                  cart.decrementCounter();
                                                  cart.removeFromTotalPrice(
                                                      snapshot.data![index]
                                                          .productPrice!);
                                                },
                                                child: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            snapshot.data![index].productName
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            snapshot.data![index].unitTag
                                                    .toString() +
                                                " " +
                                                r"$" +
                                                snapshot
                                                    .data![index].productPrice
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          int quantity = snapshot.data![index].quantity!;
                                                          double price = snapshot.data![index].initialPrice!;
                                                          quantity--;
                                                          double? newPrice = price * quantity;
                                                          if(quantity >= 1){
                                                            dbHelper!.updateQuantity(
                                                                Cart(
                                                                  id: snapshot.data![index].id!,
                                                                  productId: snapshot.data![index].productId.toString(),
                                                                  productName: snapshot.data![index].productName.toString(),
                                                                  initialPrice: snapshot.data![index].initialPrice!,
                                                                  productPrice: newPrice,
                                                                  quantity: quantity,
                                                                  unitTag: snapshot.data![index].unitTag.toString(),
                                                                  image: snapshot.data![index].image.toString(),
                                                                )
                                                            ).then((value) {
                                                              newPrice = 0;
                                                              quantity = 0;
                                                              cart.removeFromTotalPrice(snapshot.data![index].initialPrice!);
                                                            }).onError((error, stackTrace) {
                                                              print('Error in Update Quantity'+ error.toString());
                                                            });
                                                          }

                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          int quantity = snapshot.data![index].quantity!;
                                                          double price = snapshot.data![index].initialPrice!;
                                                          quantity++;
                                                          double? newPrice = price *quantity;
                                                          dbHelper!.updateQuantity(
                                                            Cart(
                                                                id: snapshot.data![index].id!,
                                                                productId: snapshot.data![index].productId.toString(),
                                                                productName: snapshot.data![index].productName.toString(),
                                                                initialPrice: snapshot.data![index].initialPrice!,
                                                                productPrice: newPrice,
                                                                quantity: quantity,
                                                                unitTag: snapshot.data![index].unitTag.toString(),
                                                                image: snapshot.data![index].image.toString(),
                                                            )
                                                          ).then((value) {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.addInTotalPrice(snapshot.data![index].initialPrice!);
                                                          }).onError((error, stackTrace) {
                                                            print('Error in Update Quantity'+ error.toString());
                                                          });

                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                  );
                }
                return Text('Loading...');
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                  ? false
                  : true,
              child: Column(
                children: [
                  ReuseableWidget(
                    title: 'Sub Total',
                    value: r'$' + value.getTotalPrice().toString(),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  final String title, value;

  const ReuseableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
