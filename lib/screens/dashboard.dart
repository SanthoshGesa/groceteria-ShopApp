import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/custom-widgets/dashboard-card.dart';
import 'package:store/screens/order-detail.dart';

class DashBoardScreen extends StatelessWidget {
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
      appBar: AppBar(title: Text("Dashboard")),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DashBoardCard(
                  title: "On Process",
                  value: 3.0,
                ),
                DashBoardCard(
                  title: "Completed",
                  value: 18.0,
                ),
                DashBoardCard(
                  title: "Cancelled",
                  value: 4.0,
                ),
              ],
            ),
            Row(
              children: [
                DashBoardCard(
                  title: "Total Orders",
                  value: 20.0,
                ),
                DashBoardCard(
                  title: "Total Revenue",
                  value: 2000.0,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "ON GOING ORDERS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
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
            )
          ],
        ),
      ),
    );
  }
}
