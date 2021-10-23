import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.nombre,
    this.sku,
    this.descripcion,
  });

  int id;
  String nombre;
  int sku;
  String descripcion;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nombre: json["nombre"],
        sku: json["sku"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "sku": sku,
        "descripcion": descripcion,
      };

  @override
  String toString() {
     return toJson().toString();
  }
}
