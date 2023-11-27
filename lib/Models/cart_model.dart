class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final String? initialPrice;
  final String? productPrice;
  final String? quantity;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productName,
    required this.image,
    required this.initialPrice,
    required this.productId,
    required this.productPrice,
    required this.quantity,
    required this.unitTag,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        initialPrice = res['initialPrice'],
        productPrice = res['productPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap(){
    return {
      'id' : id,
      'productId' : productId,
      'productName' : productName,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'unitTag' : unitTag,
      'image' : image,
    };
  }
}
