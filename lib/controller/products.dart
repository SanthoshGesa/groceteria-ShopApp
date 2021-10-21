import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var products = [].obs;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  fetchProducts() {
    _db.collection("products").snapshots().listen((event) {
      var tmp = [];
      event.docs.forEach((product) {
        tmp.add({"id": product.id, ...product.data()});
      });
      products.assignAll(tmp);
    });
  }

  add(obj) {
    _db.collection("products").add(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  updateProduct(id, obj) {
    _db.collection("products").doc(id).update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete(id) {
    _db.collection("products").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
