import 'package:flutter/material.dart';
class ViewUserProduct extends StatefulWidget {
  const ViewUserProduct({Key? key}) : super(key: key);

  @override
  State<ViewUserProduct> createState() => _ViewUserProductState();
}

class _ViewUserProductState extends State<ViewUserProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Center(child: Text("Product")),
    automaticallyImplyLeading: false,
    ),

    body: Container(

    ),

    );

  }
}
