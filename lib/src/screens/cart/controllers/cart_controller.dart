import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/cart.dart';

class CartController extends GetxController {
  RxMap cartItems = {}.obs;

  double get totalAmount {
    var total = 0.0;
    cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
    String productID,
    double price,
    String title,
    String imageUrl,
  ) {
    if (cartItems.containsKey(productID)) {
      cartItems.update(
          productID,
          (exitingCartItem) => Cart(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      cartItems.putIfAbsent(
          productID,
          () => Cart(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    update();
  }

  void reduceProductInCart(
    String productID,
    double price,
    String title,
    String imageUrl,
  ) {
    cartItems.update(
        productID,
        (exitingCartItem) => Cart(
            id: exitingCartItem.id,
            title: exitingCartItem.title,
            price: exitingCartItem.price,
            quantity: exitingCartItem.quantity - 1,
            imageUrl: exitingCartItem.imageUrl));
    update();
  }

  void removeItem(String productId) {
    cartItems.remove(productId);
    update();
  }

  void clearCart() {
    cartItems.clear();
    update();
  }
}
