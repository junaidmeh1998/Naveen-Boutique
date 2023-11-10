class WishList {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final String? image;

  WishList(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.image});

  WishList.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        productPrice = res['productPrice'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'image': image,
    };
  }
}
