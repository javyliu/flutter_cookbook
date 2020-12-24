import 'product.dart';

class CartItem {
  final Product product;
  final int nums;

  CartItem(this.product, this.nums);
}

List<CartItem> demoCartItems = [
  CartItem(demoProducts[0], 2),
  CartItem(demoProducts[1], 1),
  CartItem(demoProducts[3], 3),
];
