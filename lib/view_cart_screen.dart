import 'dart:convert';
import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'db_screen.dart';
class ViewCart extends StatefulWidget {
  int prefs;
   ViewCart({required this.prefs,Key? key}) : super(key: key);

  @override
  State<ViewCart> createState() => _ViewCartState(LoggedID: prefs);
}

class _ViewCartState extends State<ViewCart> {

  late var list;
  int LoggedID;
  _ViewCartState({
    required this.LoggedID
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Cart"),
        actions: [
          ElevatedButton(onPressed: () async {
            // var read=await DatabaseHelper.instance.ReadCart();
            // for(var list in read){
            //
            //  if(LoggedID==list.userID){
            //    print(LoggedID);
            //    print(list.title);
            //    print(list.name);
            //    print(list.priceInt);
            //
            //
            //  }
            //
            //
            // }
          }, child: const Text("ok")),
        ],
      ),
      body:FutureBuilder<List< Add_To_Cart>>(

        future: DatabaseHelper.instance.ReadCart(),

        builder: (BuildContext context, AsyncSnapshot<List< Add_To_Cart>> snapshot){
          if(!snapshot.hasData)
          {
            return const Center(child: CircularProgressIndicator());
          }else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No Record"));
            } else{
              List<Add_To_Cart> cart = snapshot.data!;

              return ListView.builder(

                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    Add_To_Cart test = cart[index];
                    if(LoggedID==test.userID){
                      return Card(
                      // elevation: 5,
                      child: ListTile(
                        iconColor: Colors.red,
                        title: Text("${test.title}\n${test.name}"),
                        trailing: Text("${test.priceInt}\n${test.price}"),
                        leading: Container(
                          height: 50,
                          width: 70,
                          decoration: const BoxDecoration(
                          ),
                          child: cart.isNotEmpty ? Image.memory(fit: BoxFit.fill,
                              const Base64Decoder().convert(
                                  cart[index].picture!)) : const Text(
                              "No Profile"),

                        ),
                      ),

                    );
                    }
                return  const Text("");

                  }
                  );
            }

          }

        },
      ),
    );
  }

}
