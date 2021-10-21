import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/order-detail.dart';

class OrdersScreen extends StatelessWidget {
  List _orderList = [
    {
      "id": "12345",
      "status": "Completed",
      "paymentMethod": "COD",
      "deliveryAddress": "34 Flutter Club, Earth 213512",
      "dateString": "21 May 2025",
      "cartTotal": 630.0,
      "itemsCount": 3,
      "cartItems": [
        {
          "imageURL": "assets/images/products/1.jpg",
          "title": "Carrot",
          "qty": 1,
          "price": 20.0,
          "total": 20.0,
        },
        {
          "imageURL": "assets/images/products/5.jpg",
          "title": "Raw Meat",
          "qty": 2,
          "price": 320.0,
          "total": 640.0,
        },
        {
          "imageURL": "assets/images/products/8.jpg",
          "title": "Orange",
          "qty": 1,
          "price": 170.0,
          "total": 170.0,
        }
      ]
    },
    {
      "id": "23412",
      "status": "Cancelled",
      "paymentMethod": "COD",
      "deliveryAddress": "34 Flutter Club, Earth 213512",
      "dateString": "25 Apr 2025",
      "cartTotal": 190.0,
      "itemsCount": 2,
      "cartItems": [
        {
          "imageURL": "assets/images/products/1.jpg",
          "title": "Carrot",
          "qty": 1,
          "price": 20.0,
          "total": 20.0,
        },
        {
          "imageURL": "assets/images/products/8.jpg",
          "title": "Orange",
          "qty": 1,
          "price": 170.0,
          "total": 170.0,
        }
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _orderList.length,
        itemBuilder: (bc, index) {
          return ListTile(
            title: Text("# ${_orderList[index]["id"]}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_orderList[index]["dateString"]}"),
                Text(
                    "${_orderList[index]["itemsCount"]} Items - ₹ ${_orderList[index]["cartTotal"]}"),
              ],
            ),
            isThreeLine: true,
            trailing: Text("${_orderList[index]["status"]}"),
            onTap: () {
              Get.to(
                OrderDetail(
                  orderObj: _orderList[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
