import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/products.dart';
import 'package:store/screens/categories.dart';
import 'package:store/screens/manage-product.dart';

class ProductsScreen extends StatelessWidget {
  ProductsController _productsController = Get.put(ProductsController());

  // var _products = [];
  // FirebaseFirestore _db = FirebaseFirestore.instance;

  // fetchProducts() {
  //   _db.collection("products").snapshots().listen((event) {
  //     var tmp = [];
  //     event.docs.forEach((product) {
  //       tmp.add({"id": product.id, ...product.data()});
  //     });
  //     setState(() {
  //       _products = tmp;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => ManageProductScreen(
                    canEdit: false,
                    product: {},
                  ));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    Get.to(CategoriesScreen());
                  },
                  child: Text("Manage Categories")),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _productsController.products.length,
                  itemBuilder: (bc, index) {
                    return ListTile(
                      title: Text(
                          "${_productsController.products[index]["title"]}"),
                      subtitle: Text(
                          "${_productsController.products[index]["price"]}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                        onPressed: () {
                          Get.to(() => ManageProductScreen(
                                canEdit: true,
                                product: _productsController.products[index],
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
