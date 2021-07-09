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
    String productId,
    double price,
    String title,
    String imageUrl,
  ) {
    if (cartItems.containsKey(productId)) {
      cartItems.update(
          productId,
          (exitingCartItem) => Cart(
              id: exitingCartItem.id,
              productId: exitingCartItem.productId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      cartItems.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    update();
  }

  void reduceProductInCart(
    String productId,
    double price,
    String title,
    String imageUrl,
  ) {
    cartItems.update(
        productId,
        (exitingCartItem) => Cart(
            id: exitingCartItem.id,
            productId: exitingCartItem.productId,
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
