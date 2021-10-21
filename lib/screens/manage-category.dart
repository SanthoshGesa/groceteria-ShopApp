import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/category.dart';

class ManageCategoryScreen extends StatelessWidget {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController _titleController = TextEditingController();

  bool canEdit = false;
  var category = {};

  ManageCategoryScreen({this.canEdit, this.category}) {
    _titleController.text = category["title"];
  }

  CategoryController _categoryController = CategoryController();
  // _update() {
  //   _db
  //       .collection("categories")
  //       .doc(category["id"])
  //       .update({"title": _titleController.text}).then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _add() {
  //   _db
  //       .collection("categories")
  //       .add({"title": _titleController.text}).then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _delete() {
  //   _db.collection("categories").doc(category["id"]).delete().then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${canEdit ? 'Edit' : 'Add'} Category"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Category Name",
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.green,
                ),
                child: Text(
                  "${canEdit ? 'UPDATE' : 'ADD'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  canEdit
                      ? _categoryController.updateCategory(category["id"], {
                          "title": _titleController.text,
                        })
                      : _categoryController
                          .add({"title": _titleController.text});
                },
              ),
            ),
            canEdit
                ? TextButton(
                    onPressed: () {
                      _categoryController.delete(category["id"]);
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 16),
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
