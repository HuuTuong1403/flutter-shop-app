import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopappfirebase/src/models/product.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadProduct(
      {required String title,
      required String price,
      required File image,
      required String category,
      required String brand,
      required String description,
      required String quantity,
      required Function onError}) async {
    //Connect to FirebaseStorage and create folder productImages
    final ref = FirebaseStorage.instance
        .ref()
        .child('productImages')
        .child(title + '.jpg');

    //Upload File to FirebaseStorage
    await ref.putFile(image);

    //Get url Image after upload
    String url = await ref.getDownloadURL();

    //Create product in FirebaseFirestore
    final User user = _auth.currentUser!;
    String _uid = user.uid;

    //Create id auto
    var uuid = Uuid();
    final productId = uuid.v4();

    //Upload to FirebaseFirestore
    await FirebaseFirestore.instance.collection('products').doc(productId).set({
      'productId': productId,
      'productTitle': title,
      'productPrice': price,
      'productImage': url,
      'productCategory': category,
      'productBrand': brand,
      'productDescription': description,
      'productQuantity': quantity,
      'userId': _uid,
      'createAt': Timestamp.now(),
    }).catchError((err) {
      onError('${err.message}');
    });
  }

  Future<List<dynamic>> fetchProducts() async {
    var _products = [];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((productSnapshot) {
      productSnapshot.docs.forEach((item) {
        _products.insert(
          0,
          Product(
              id: item.get('productId'),
              title: item.get('productTitle'),
              description: item.get('productDescription'),
              price: double.parse(item.get('productPrice')),
              imageUrl: item.get('productImage'),
              brand: item.get('productBrand'),
              productCategoryName: item.get('productCategory'),
              quantity: int.parse(item.get('productQuantity')),
              isPopular: true),
        );
      });
    });
    return _products;
  }
}
