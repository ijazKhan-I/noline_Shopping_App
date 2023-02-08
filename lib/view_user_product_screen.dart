import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'package:onlineshoppinapp/view_cart_screen.dart';
import 'cart_model.dart';
import 'db_screen.dart';
import 'Reuseable_code.dart';
class ViewUserProduct extends StatefulWidget {
  int prefs;
   ViewUserProduct({required this.prefs,Key? key}) : super(key: key);

  @override
  State<ViewUserProduct> createState() => _ViewUserProductState(prefsValue:prefs);
}

class _ViewUserProductState extends State<ViewUserProduct> {
  notification notifications=notification();
  int prefsValue;
  _ViewUserProductState({
    required this.prefsValue,
});
  @override
  void initState() {
   notifications.initilaization();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Center(child: Text("Product")
    ),
    automaticallyImplyLeading: false,
      actions: [
        ElevatedButton(onPressed: () async {
         print(prefsValue);
        }, child: const Text("print")),
      ],
    ),

     body:FutureBuilder<List< ProductModle>>(
        future: DatabaseHelper.instance.productRead(),
                     builder: (BuildContext context, AsyncSnapshot<List< ProductModle>> snapshot){
                   if(!snapshot.hasData  )
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
                     trailing: TextButton(onPressed: () async {
                   Add_To_Cart obj=Add_To_Cart(userID: prefsValue, productID: test.id!);
                   var result=await DatabaseHelper.instance.insertCard(obj);
                   notifications.sendNotification("Notification!", "${test.title} has been dispatched");
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCart(prefs: prefsValue,)));


                      }, child: Image.asset("assets/buy.png")),
                              title: Text("${test.title}"),
                     leading: Container(
                        height: 50,
                     width: 70,
                   decoration:  BoxDecoration(
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
