import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_cart_with_provider/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/cart_model.dart';

class CartProvider with ChangeNotifier {

  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;

  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData () async{
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    // print("Cart item: "+pr)
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  // -------------Functions for Counter---------------------

  void incrementCounter() {
    _counter++;
    // _setPrefItems();
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  // -------------Functions for totalPrice---------------------

  void addInTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeFromTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
