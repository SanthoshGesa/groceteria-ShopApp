import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/category.dart';
import 'package:store/screens/manage-category.dart';

class CategoriesScreen extends StatelessWidget {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  CategoryController _categoryController = Get.put(CategoryController());

  // var _categories = [];
  // fetchCategories() {
  //   _db.collection("categories").snapshots().listen((event) {
  //     var tmp = [];
  //     event.docs.forEach((element) {
  //       tmp.add({"id": element.id, "title": element.data()["title"]});
  //     });
  //     setState(() {
  //       _categories = tmp;
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchCategories();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ManageCategoryScreen(
                canEdit: false,
                category: {},
              ));
            },
          )
        ],
      ),
      body: Container(
        child: Obx(
          () => ListView.builder(
            itemCount: _categoryController.category.length,
            itemBuilder: (bc, index) {
              return ListTile(
                title: Text("${_categoryController.category[index]["title"]}"),
                trailing: Icon(Icons.edit_outlined),
                onTap: () {
                  Get.to(() => ManageCategoryScreen(
                        canEdit: true,
                        category: _categoryController.category[index],
                      ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
