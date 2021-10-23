import 'dart:convert';

List<ProductCart> productCartFromJson(String str) => List<ProductCart>.from(
    json.decode(str).map((x) => ProductCart.fromJson(x)));

String productCartToJson(List<ProductCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCart {
  ProductCart({
    this.id,
    this.productId,
    this.quantity,
  });

  int id;
  int productId;
  int quantity;

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
      };
      @override
      String toString() {
         return toJson().toString();
      }
}
