import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({this.id, this.nombre, this.sku, this.description, this.price});

  int id;
  String nombre;
  int sku;
  String description;
  double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nombre: json["nombre"],
        sku: json["sku"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "sku": sku,
        "description": description,
        "price": price,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool isEmpty() {
    return id == null && nombre == null && description == null ? true : false;
  }
}
