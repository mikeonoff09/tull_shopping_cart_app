import 'dart:convert';

List<Cart> cartsFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartsToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    this.id,
    this.status,
  });

  int id;
  String status;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
