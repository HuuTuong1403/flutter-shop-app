import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopappfirebase/src/models/order.dart';
import 'package:shopappfirebase/src/screens/cart/controllers/cart_controller.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CartController _cartController = Get.find();

  Future<void> deleteOrders({required String orderId}) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
  }

  Future<List<dynamic>> fetchOrders() async {
    User user = _auth.currentUser!;
    var _orders = [];
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((orderSnapshot) {
      orderSnapshot.docs.forEach((item) {
        _orders.insert(
          0,
          Order(
            orderId: item.get('orderId'),
            productId: item.get('productId'),
            userId: item.get('userId'),
            orderDate: item.get('orderDate'),
            title: item.get('title'),
            price: item.get('price'),
            imageUrl: item.get('imageUrl'),
            quantity: item.get('quantity'),
          ),
        );
      });
    });
    return _orders;
  }

  Future<void> uploadOrder({required Function onError}) async {
    //Create product in FirebaseFirestore
    final User user = _auth.currentUser!;
    String _uid = user.uid;

    //Create id auto
    var uuid = Uuid();
    //Upload to FirebaseFirestore
    _cartController.cartItems.forEach((key, value) async {
      final orderId = uuid.v4();
      await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': _uid,
        'productId': value.productId,
        'title': value.title,
        'price': value.price * value.quantity,
        'imageUrl': value.imageUrl,
        'quantity': value.quantity,
        'orderDate': Timestamp.now(),
      }).catchError((err) {
        onError('${err.message}');
      }).catchError((err) {
        onError('${err.message}');
      });
    });
  }
}
