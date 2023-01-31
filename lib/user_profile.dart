import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/test_db.dart';
import 'package:onlineshoppinapp/test_model.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("User Profile")),
        automaticallyImplyLeading: false,),
      // body: FutureBuilder<List<TestModel>>(
      //   future: Helper.instance.Read(),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<List<TestModel>> snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else {
      //       if (snapshot.data!.isEmpty) {
      //         return const Center(child: Text("No Record"));
      //       } else {
      //         List<TestModel> product = snapshot.data!;
      //         return ListView.builder(itemCount: product.length,
      //             itemBuilder: (context, index) {
      //               TestModel test = product[index];
      //               return Card(
      //
      //                 color: Colors.green,
      //                 child: ListTile(
      //                   trailing: IconButton(onPressed: () async {
      //                     var del = await Helper.instance.delete(test.id!);
      //                     setState(() {
      //
      //                     });
      //                   }, icon: const Icon(Icons.delete)),
      //                   onTap: () {
      //                     showDialog(barrierDismissible: false,
      //                         context: context,
      //                         builder: (context) {
      //                           return AlertDialog(
      //
      //                             content: Text(
      //                                 "${test.title}\n\n${test.description}"),
      //                             title: product.isNotEmpty ? Image.memory(
      //                                 const Base64Decoder().convert(
      //                                     product[index].image!)) : Text(
      //                                 "No Profile"),
      //                             actions: [
      //                               TextButton(onPressed: () {
      //                                 Navigator.of(context).pop();
      //                               }, child: Text("Close"))
      //
      //                             ],
      //
      //                           );
      //                         });
      //                   },
      //                   title: Text("${test.title}"),
      //                   leading: InkWell(
      //                     onTap: () async {
      //                       // pList = await DatabaseHelper2.getAllProfile();
      //                       // print(pList);
      //                     },
      //                     child: Container(
      //                       height: 100,
      //                       width: 100,
      //                       decoration: BoxDecoration(
      //                         border: Border.all(),
      //
      //                       ),
      //                       child: product.isNotEmpty ? Image.memory(
      //                           const Base64Decoder().convert(
      //                               product[index].image!)) : Text(
      //                           "No Profile"),
      //                     ),
      //
      //                   ),
      //                 ),
      //               );
      //             });
      //       }
      //     }
      //   },
      // ),

    );
  }

}
