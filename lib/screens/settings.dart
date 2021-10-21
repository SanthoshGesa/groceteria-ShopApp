import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/profile.dart';
import 'package:store/screens/profile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var isSwitched = false;

  ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(_profileController.userObj["imageURL"]),
              ),
              title: Text('${_profileController.userObj["name"]}'),
              subtitle: Text('${_profileController.userObj["mobile"]}'),
              trailing: TextButton(
                child: Text('Edit'),
                onPressed: () {
                  Get.to(() => EditProfile());
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.green,
            ),
            title: Text("Notifications"),
            subtitle: Text("Turn On / Off Notifications"),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.shopping_bag_outlined,
          //     color: Colors.green,
          //   ),
          //   title: Text("My Orders"),
          //   subtitle: Text("Manage orders"),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.green,
          //   ),
          //   onTap: () {
          //     Get.to(() => MyOrdersScreen());
          //   },
          // ),
          // ListTile(
          //   onTap: () {
          //     Get.to(() => ManageAddress());
          //   },
          //   leading: Icon(
          //     Icons.location_on,
          //     color: Colors.green,
          //   ),
          //   title: Text("My Address"),
          //   subtitle: Text("Manage Delivery Address"),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.green,
          //   ),
          // ),
        ],
      ),
    );
  }
}
