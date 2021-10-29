import 'dart:convert';

List<ProductCart> productCartsFromJson(String str) => List<ProductCart>.from(
    json.decode(str).map((x) => ProductCart.fromJson(x)));

String productCartsToJson(List<ProductCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCart {
  ProductCart({
    this.id,
    this.productId,
    this.quantity,
    this.cartId,
  });

  int id;
  int productId;
  int quantity;
  int cartId;

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        id: json["id"],
        productId: json["product_id"],
        cartId: json["cart_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "cart_id": cartId,
        "quantity": quantity,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
