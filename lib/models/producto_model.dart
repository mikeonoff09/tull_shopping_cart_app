import 'dart:convert';

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({this.id, this.name, this.sku, this.description, this.price});

  int id;
  String name;
  int sku;
  String description;
  double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "description": description,
        "price": price,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool isEmpty() {
    return id == null && name == null && description == null ? true : false;
  }

  bool isNotEmpty() => !isEmpty();
}
