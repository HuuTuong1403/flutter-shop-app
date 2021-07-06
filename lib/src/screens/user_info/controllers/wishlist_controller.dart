import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/favorite.dart';

class WishlistController extends GetxController {
  RxMap favItems = {}.obs;

  void addFavoriteItems(
    String productID,
    double price,
    String title,
    String imageUrl,
  ) {
    if (favItems.containsKey(productID)) {
      removeItem(productID);
    } else {
      favItems.putIfAbsent(
          productID,
          () => Favorite(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              imageUrl: imageUrl));
    }
    update();
  }

  void removeItem(String productId) {
    favItems.remove(productId);
    update();
  }

  void clearFav() {
    favItems.clear();
    update();
  }
}
