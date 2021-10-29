import 'package:flutter_test/flutter_test.dart';
import 'package:tull_shopping_cart_app/models/producto_model.dart';

void main() {
  group("Productos test", () {
    test("Productos vacio = true", () {
      Product product = Product();
      bool result = product.isEmpty();
      expect(result, true);
    });
    test("Productos vacio = false", () {
      Product product = Product(id: 4, name: "Producto", price: 10.0);
      bool result = product.isEmpty();
      expect(result, false);
    });
  }); // It's not much but, it's honest testing!!!
}
