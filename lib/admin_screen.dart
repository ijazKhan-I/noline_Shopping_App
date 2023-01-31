import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlineshoppinapp/login_screen.dart';

import 'package:onlineshoppinapp/view_pruduct_screen.dart';

import 'Reuseable_code.dart';
import 'add_screen.dart';
import 'admin_profile.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Admin page")),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Tile(
                text: "Add product",
                url: "assets/Add.png",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddScreen()));
                },
              ),
              const Box(height:0, width:15),
              Tile(
                text: "view product",
                url: "assets/view.png",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewScreen()));
                },
              ),
              const Box(height:0, width:15),
              Tile(
                text: "Profile",
                url: "assets/profile.png",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminProfile()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
