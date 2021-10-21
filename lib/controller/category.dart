import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var category = [].obs;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    this.fetchCategories();
  }

  fetchCategories() {
    _db.collection("categories").snapshots().listen((event) {
      var tmp = [];
      event.docs.forEach((element) {
        tmp.add({"id": element.id, "title": element.data()["title"]});
      });
      category.assignAll(tmp);
    });
  }

  
  updateCategory(id,obj) {
    _db
        .collection("categories")
        .doc(id)
        .update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  add(obj) {
    _db
        .collection("categories")
        .add(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete(id) {
    _db.collection("categories").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
