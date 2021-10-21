import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/controller/category.dart';
import 'package:store/controller/products.dart';
import 'package:store/screens/login.dart';

class ManageProductScreen extends StatefulWidget {
  var canEdit = false;
  var product = {};

  ManageProductScreen({this.canEdit, this.product});
  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  ProductsController _productsController = Get.put(ProductsController());
  CategoryController _categoryController = Get.put(CategoryController());
  // var _categories = [];
  var _selectedId = "ldZqCeVOHO0ZmQvgB73j";
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var imgURL = "http://placehold.it/150x150";

  // fetchProducts() {
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

  // add() {
  //   _db.collection("products").add({
  //     "title": _titleController.text,
  //     "price": double.parse(_priceController.text),
  //     "categoryId": _selectedId,
  //     "description": _descriptionController.text,
  //     "imageURL": imgURL
  //   }).then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // update() {
  //   _db.collection("products").doc(widget.product["id"]).update({
  //     "title": _titleController.text,
  //     "price": double.parse(_priceController.text),
  //     "categoryId": _selectedId,
  //     "description": _descriptionController.text,
  //     "imageURL": imgURL
  //   }).then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // delete() {
  //   _db.collection("products").doc(widget.product["id"]).delete().then((value) {
  //     Get.back();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  uploadImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      var filepath = (DateTime.now().millisecondsSinceEpoch.toString());

      _storage
          .ref()
          .child("products")
          .child(filepath)
          .putFile(image)
          .then((value) {
        print(value);
        value.ref.getDownloadURL().then((url) {
          print("Uploaded Url - " + url);
          setState(() {
            imgURL = url;
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("no file is chosen");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this.fetchProducts();
    _titleController.text = widget.product['title'];
    _priceController.text = widget.product['price'];
    _descriptionController.text = widget.product['description'];
    _selectedId = widget.product['categoryId'];
    imgURL = widget.product['imageURL'] != null
        ? widget.product['imageURL']
        : "http://placehold.it/120x120";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgURL),
                  radius: 60,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Product Title",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Price",
                ),
              ),
              SizedBox(height: 12),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category"),
                    Card(
                      elevation: 0,
                      child: Obx(
                        () => DropdownButton(
                          value: _selectedId,
                          onChanged: (v) {
                            setState(() {
                              _selectedId = v;
                            });
                          },
                          items: _categoryController.category.map((category) {
                            return DropdownMenuItem(
                              value: category["id"],
                              child: Text(category["title"]),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Description",
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
                    "${widget.canEdit ? 'Update' : 'Add'} Product",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    widget.canEdit
                        ? _productsController
                            .updateProduct(widget.product["id"], {
                            "title": _titleController.text,
                            "price": _priceController.text,
                            "categoryId": _selectedId,
                            "description": _descriptionController.text,
                            "imageURL": imgURL
                          })
                        : _productsController.add({
                            "title": _titleController.text,
                            "price": _priceController.text,
                            "categoryId": _selectedId,
                            "description": _descriptionController.text,
                            "imageURL": imgURL
                          });
                  },
                ),
              ),
              widget.canEdit
                  ? TextButton(
                      onPressed: () {
                        _productsController.delete(widget.product["id"]);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 16),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
