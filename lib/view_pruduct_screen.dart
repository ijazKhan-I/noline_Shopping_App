import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'db_screen.dart';
import 'image_db.dart';
import 'image_model.dart';
class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
var item=1;
  //
  List<ProfileModel> pList = [];
  //
  @override
  initState() {
    DatabaseHelper2.getAllProfile();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View product"),
      ),
      body:FutureBuilder<List< ProductModle>>(
        future: DatabaseHelper.instance.productRead(),
        builder: (BuildContext context, AsyncSnapshot<List< ProductModle>> snapshot){
          if(!snapshot.hasData)
          {
            return const Center(child: CircularProgressIndicator());
          }else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No Record"));
            } else {
              List<ProductModle> product = snapshot.data!;
              return ListView.builder(itemCount: product.length,
                  itemBuilder: (context, index) {
                    ProductModle test = product[index];
                    return Card(


                      color: Colors.green[400],
                      child: ListTile(

                        iconColor: Colors.red,
                        

                        trailing: IconButton(onPressed: () async {
                         var del=await DatabaseHelper.instance.delete(test.id!);
                          setState(() {

                          });

                        }, icon: const Icon(Icons.delete)),
                        onTap: () {
                          showDialog(barrierDismissible: false,
                              context: context,
                              builder: (context) {

                                return AlertDialog(

                                  content:Text("${test.title}\n\n${test.description}") ,
                                 title: product.isNotEmpty?Image.memory(
                                     const Base64Decoder().convert(
                                         product[index].picture!)) : Text(
                                     "No Profile"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text("Close"))

                                  ],

                                );
                              });
                        },
                        title: Text("${test.title}"),
                        leading: Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                                 border: Border.all(color: Colors.green),


                          ),
                          child: product.isNotEmpty ? Image.memory(fit: BoxFit.fill,
                              const Base64Decoder().convert(
                                  product[index].picture!)) : Text(
                              "No Profile"),
                        ),
                      ),
                    );
                  });
            }
          }
        },
      ),
    );
  }


}
