import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'db_screen.dart';
import 'image_db.dart';
import 'image_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                      elevation: 5,
                      child: ListTile(
                        iconColor: Colors.red,
                        trailing: IconButton(onPressed: () async {
                          return showDialog(barrierDismissible: false,
                              context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Confirmation!"),
                              content: const Text("are you sure to delete record?"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: const Text("No")),
                                TextButton(onPressed: ()async{
                                  Navigator.of(context).pop();
                                  var del=await DatabaseHelper.instance.delete(test.id!);
                                  Fluttertoast.showToast(msg: "Delete Record",backgroundColor: Colors.red);
                                setState(() {});},
                                    child: const Text("Yes")),
                              ],
                            );
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
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
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
