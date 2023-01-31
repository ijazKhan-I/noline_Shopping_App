
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/user_profile.dart';
import 'package:onlineshoppinapp/view_user_product_screen.dart';

import 'Reuseable_code.dart';
import 'login_screen.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("User page")),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
          }, icon: Icon(Icons.logout)),
        ],

      ),
      body:Container(
        padding: const EdgeInsets.only(top: 20,left: 20),
        child: Row(
          children: [
            const Box(height:0, width:15),
            Tile(
              text: "view product",
              url: "assets/view.png",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewUserProduct()));
              },
            ),
            const Box(height:0, width:15),

            Tile(
              text: "Profile",
              url: "assets/profile.png",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>UserProfile()));
              },
            ),
          ],
        ),
      ),

    );
  }
}
